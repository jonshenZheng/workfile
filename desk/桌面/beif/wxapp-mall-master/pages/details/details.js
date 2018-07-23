//获取应用实例
let app = getApp(),
  rq = app.bzRequest,
  baseURL = app.globalData.svr,
  commJS = require("../common/common.js"),
  prodID,
  pageBeforeLoadRun = app.pageBeforeLoadRun,
  testThat = this;

Page({
  data: {
    qiuckNavig : 'btn_left',  
    qiuckNavigShow : false,
    sendkefu: {},
    baseimgURL: app.globalData.baseImgUrl,
    btnff : '',
    sendkefuMsg : '',
    cartNumAnimate : '',
    addcartNum : '',
    totalCartNum: 0,    
    tabarData: {
      isCollection: false,
      isAddCart: false
    },
    isShowPop : false,
    autoplay: true,
    interval: 3000,
    duration: 1000,
    goodsSelection: {
    },//核心:选择所依托的数据
    goodsDetail: {
    },//核心:当前选中的商品的详情
    collectionId : '',
    swiperCurrent: 0,//目前没用
    hasMoreSelect: true,//是否能针对当前商品进行更多的属性选择
    bHideSelectView: true,//是否显示选择的view
    purchaseQuantity: 1,//用户设置的购买数量,每点一次加入购车,就会放入bHideSelectView个商品
    minPurchaseQuantity: 1,
    maxPurchaseQuantity: 999,
    selectedPropertyStr: "",//选中的属性对应的字符串,用于界面显示选择中属性文本
    isRangePrice : false,
    showMaxPrice:0,
    showMinPrice:0,

    prodIdParm: '',
    showReplaceProd : false,

  },


  getSelectPropCOP : function(){
      this.SelectPropCOP = this.selectComponent('#SelectProp');
  }, 

  onLoad: function (options) {
    pageBeforeLoadRun(this);  
    commJS.injectData(this, options);
    this.options = options;//缓存住，以便onShow时候刷新
  },
  onShow: function () {
    if (this.expired) {
      this.requestGoodsInfo(this.options);
      this.expired = false;
    }

    // 主动刷新购物车数量
    this.getCartNUM();

    // 更新视图角色
    commJS.updateRoleView(this);
  },
  onDataInjected:function(options){

    if (options.isReplaceProd === 'true'){
        this.setData({
            showReplaceProd : true
        })
    }

    this.requestGoodsInfo(options);
  },
  requestGoodsInfo: function (options){
    wx.showLoading({
      title: '加载中',
    })

    let self = this,
      dataO;

    prodID = options.prodId;

    this.setData({
        prodIdParm: prodID
    });

    var skuId = options.skuId;
    var url = baseURL + 'produce/detail/'+this.data.shopOfView.shopId+'/' + prodID;
    if (skuId)
      url = baseURL + 'produce/skudetail/' + this.data.shopOfView.shopId + '/'+ prodID + '/' + skuId;
    rq({
      url: url,
      header: { "with-selection": "true" },
      success: function (r) {
        wx.hideLoading();

        let selection = r.data.data.goodsSelection;
        let selected = r.data.data.goodsSelection.selected;
        
        for (var i = 0; i < selected.properties.length; i++) {
          let idx = selected.properties[i];
          try {
            selection.properties[i].values[idx].selected = true
          } catch (e) {
            console.error(e)
          }
        }

        if (!r.data.data.goodsDetail.pics.length){
            r.data.data.goodsDetail.pics[0] = '';
        }

        commJS.checkImgExist(r.data.data.goodsDetail.pics);
        r.data.data.goodsDetail.basicInfo.icon = commJS.checkImgExist(r.data.data.goodsDetail.basicInfo.icon);

        self.setData({
          goodsSelection: r.data.data.goodsSelection,
          goodsDetail: r.data.data.goodsDetail
        });
        self.checkSelection();

      }
    });

    //请求是否收藏
    rq({
      url: baseURL + 'colletion/getId/' + prodID,
      withoutToken: false,
      success: function (r) {

        self.setData({
          collectionId: r.data.data.mallCollectionId
        });

      }
    });

    let sendKefuObj = {
      prodId: prodID,
      skuId: skuId
    };

    this.changeProdFn(sendKefuObj);

  },
  //快速导航
  showqiuckNavig : function(){
      let isShow = this.data.qiuckNavigShow;
      this.setData({
          qiuckNavigShow: !isShow
      });
  },
  showCartNum : function(num){
    let self = this;
    this.setData({
        cartNumAnimate : 'on',
        addcartNum: num
    });
    setTimeout(function(){
        self.setData({
            cartNumAnimate: '',
            addcartNum: ''
        });
    },1000)
  },
  btnStartFn: function (e) {
      let n = e.currentTarget.dataset.cname,
          common = common ? common : commJS; 

      common.btnStartFn(this, n);
  },
  btnEndFn: function () {
      let common = common ? common : commJS; 
      common.btnEndFn(this);
  },
  onimgfail: function (e) {

      let objName = e.currentTarget.dataset.objname,
          ind = e.currentTarget.dataset.imgind,
          arr = this.data.goodsDetail;

      switch (objName) {
          case 'pics':  if (e.detail.errMsg.indexOf('noPic.png') === -1) {
                            arr.pics[ind] = '../../image/noPic.png';
                        }
              break;
          case 'icon':  if (e.detail.errMsg.indexOf('noPic.png') === -1) {
                            arr.basicInfo.icon = '../../image/noPic.png';
                        }
              break;
      }

      this.setData({
          goodsDetail: arr
      });

  },

  //事件处理函数
  swiperchange: function (e) {
    //console.log(e.detail.current)
    this.setData({
      swiperCurrent: e.detail.current
    })
  },
  changeProdFn : function(data,cb){

      let dataObj,
          pid = data.prodId ? data.prodId : this.data.sendkefu.prodId,
          sid = data.skuId ? data.skuId : this.data.sendkefu.skuId;

        dataObj = {
            prodId: pid,
            skuId: sid
        }

        this.setData({
            sendkefu: dataObj
        });
  },
  getCartNUM : function(cb){
      let cbFn = cb || '',
          self = this;
      rq({
          url: baseURL + 'shopcart/count/'+self.data.shopOfView.shopId,
          withoutToken: false,
          success: function (r) {
              self.setData({
                  totalCartNum: r.data.data
              });
              if (typeof cbFn == 'function'){
                  cbFn();
              }
          }
      });
  },
  /**
   * 跳转到购物车页面
   */
  goToShopCart: function () {
    // wx.switchTab({
    //   url: '../cart/cart'
    // })
      wx.navigateTo({
          url: '../cart2/cart2'
      })
  },
  /**
   * 添加到购物车
   */
  addToShopCart: function (e) {

    let that = this;
    // let res = this.checkSelection();
    // let canSubmit = res.skuId;

    let canSubmit,
        purchaseQuantity,
        res;


    if (e.detail.skuid){
        canSubmit = e.detail.skuid;
        purchaseQuantity = e.detail.num;
    }
    else{
        res = this.checkSelection();
        canSubmit = res.skuId;
        purchaseQuantity = this.data.purchaseQuantity;
    }

    
    if (this.isDistributorVisitorOtherDistributor()) {
      wx.showToast({
        title: '您正在浏览他人店铺',
        icon: 'none'
      })
      return;
    }
    if (canSubmit) {
      rq({
        method: 'post',
        withoutToken: false,
        // url: baseURL + 'shopcart/' + this.data.shopOfView.shopId +'/'+ prodID + '/' + this.data.goodsDetail.basicInfo.id + '/' + this.data.purchaseQuantity,
        url: baseURL + 'shopcart/' + this.data.shopOfView.shopId + '/' + prodID + '/' + canSubmit + '/' + purchaseQuantity,
        success: function (r) {

            wx.showToast({
              title: r.data.meta.msg,
              icon: 'success',
              duration: 1500
            });

            that.hideSelectView();
            
            that.getCartNUM(function(){
                 that.showCartNum(r.data.data);
            });

        }
      })
    } else {
      //if (this.data.bHideSelectView)
        if (!this.data.isShowPop)
        this.popupSelectView();
      else
        wx.showModal({
          title: '提示',
          content: '请选择商品规格',
          showCancel: false,
        })
    }
  },

  submitRepalcePd: function (e) {

      let that = this;
      let canSubmit,
          res;


      if (e.detail.skuid) {
          canSubmit = e.detail.skuid;
      }
      else {
          res = this.checkSelection();
          canSubmit = res.skuId;
      }

      if (canSubmit) {
            //提交数据 成功返回首页并刷新
          let oldFid = app.globalData.indexRecommendsId,
              newSkuId = canSubmit,
              shopId = this.data.shopOfView.shopId;

          rq({
              url: baseURL + 'recommend/recommend/'+oldFid+'/'+newSkuId,
              withoutToken: false,
              method : 'put',
              success: function (r) {
                  wx.showToast({
                      title: '替换成功',
                      icon: 'none',
                  })

                  setTimeout(function(){
                      wx.switchTab({
                          url: '../index/index',
                          success: function () {
                              getCurrentPages()[0].getRecommendFn();
                          }
                      })  

                  },500)
                     
              }
          });

      } else {
          if (!this.data.isShowPop)
              this.popupSelectView();
          else
              wx.showModal({
                  title: '提示',
                  content: '请选择商品规格',
                  showCancel: false,
              })
      }
  },

  isDistributorVisitorOtherDistributor:function(){
    return this.data.role == this.data.ROLE_DISTRIBUTOR 
      && this.data.shop.shopId != this.data.shopOfView.shopId;
  },
  onTapInstantPurchaseBtn:function(e){
    let that = this;
    // let res = this.checkSelection();
    // let canSubmit = res.skuId;

    let canSubmit,
        purchaseQuantity,
        res,
        basicInfo;

    if (e.detail.skuid){
        canSubmit = e.detail.skuid;
        purchaseQuantity = e.detail.num;
        basicInfo = e.detail.basicInfo;
    }
    else{
        res = this.checkSelection();
        canSubmit = res.skuId;
        purchaseQuantity = this.data.purchaseQuantity;
        basicInfo = that.data.goodsDetail.basicInfo;
    }


    
    if (canSubmit) {
      if (this.isDistributorVisitorOtherDistributor()){
        wx.showToast({
          title: '您正在浏览他人店铺',
          icon:'none'
        })
        return;
      }

      
      app.tmpData.orderProducts = [
        // {
        //   prodId: prodID,
        //   skuId: basicInfo.id,
        //   property: res.selectedPropertyStr,
        //   count: that.data.purchaseQuantity,
        //   produceName: basicInfo.name,
        //   price: basicInfo.price,
        //   factoryPrice: basicInfo.factoryPrice,
        //   imgUrl: basicInfo.icon
        // },
        {
            prodId: prodID,
            skuId: canSubmit,
            property: that.data.selectedPropertyStr,
            count: purchaseQuantity,
            produceName: basicInfo.name,
            price: basicInfo.price,
            factoryPrice: basicInfo.factoryPrice,
            imgUrl: basicInfo.icon
        }
      ]
      wx.navigateTo({
        url: '../confirmOrder/confirmOrder?instantPurchase=true',
      })
    }
  },

  addToCollection: function () {

    let that = this;
    let collectionId = this.data.collectionId;
    let isInCollection = Boolean(collectionId);

    let url = baseURL + 'collection/';
    let method = 'post';
    let toastTitle = '收藏成功';
    if (isInCollection){
      url += collectionId;
      method = 'delete';
      toastTitle = '取消收藏';
    }else{
      url += prodID;
    }
    rq({
      url: url,
      withoutToken: false,
      method: method,
      
      success: function success(res) {
        if (res.statusCode != 200)
          return;
        if (res.data.meta.code == 200) {
          if (isInCollection)
            collectionId = '';
          else
            collectionId = res.data.data;
        }else{
          toastTitle = res.data.meta.msg;
        }
        console.log(toastTitle + collectionId);
        that.setData({
          collectionId: collectionId
        })
        wx.showToast({
          title: toastTitle,
        });
      }
    });    
  },

  /**
   * 规格选择弹出框
   */
  popupSelectView: function () {

        if (!this.SelectPropCOP){
            this.getSelectPropCOP();
        }

        this.SelectPropCOP.setData({
            selectedPropertyStr: this.data.selectedPropertyStr
        });

        this.SelectPropCOP.showSelectView();

        this.setData({
            isShowPop : true,  
            //bHideSelectView: false
        })
  },

  /**
   * 规格选择弹出框隐藏
   */
  hideSelectView: function () {
    this.setData({
      isShowPop : false,  
      //bHideSelectView: true
    })

    if (!this.SelectPropCOP){
        this.getSelectPropCOP();
    }
    this.SelectPropCOP.hideSelectView();
  },

//   组件关闭规格弹窗

  closeproperty : function(){
       this.setData({
           isShowPop: false,
       })
   }, 

   /** 组件更新选择的信息**/

    updateData : function(e){

        let data = e.detail;
        this.setData({
            purchaseQuantity: data.purchaseQuantity,
            selectedPropertyStr: data.selectedPropertyStr,
            goodsSelection: data.goodsSelection,
            goodsDetail: data.goodsDetail
        })

    },
  
  /**
   * 增加购买数目
   */
  onTapIncrOrDecrQuantityBtn: function (e) {
    let incr = e.currentTarget.dataset.increasement
    var currentQuantity = this.data.purchaseQuantity;
    this.changeQuantity(currentQuantity + Number(incr));
  },
  onInputQuantity: function (e) {

    let val = Number(e.detail.value);
    this.changeQuantity(val);
  },
  changeQuantity: function (val) {
    let min = this.data.minPurchaseQuantity,
      max = this.data.maxPurchaseQuantity;

    if (val < min) {
      val = min;
    }
    else if (val > max) {
      val = max;
    }

    this.setData({
      purchaseQuantity: val
    })

  },

  getPriceRange: function (selectedPropertyIndexs2, compositions){
   
    let exp2 = new RegExp('^' + selectedPropertyIndexs2.toString() + "$");
    let i = 0,
        maxPrice = 0,
        minPrice = 0,
        isfirst = true,
        len = compositions.length,
        compProp;

    for(;i<len;i++){

        compProp = compositions[i].properties;        

        if (exp2.test(compProp.toString())) {
            if (isfirst){
                isfirst = false;
                maxPrice = compositions[i].price;
                minPrice = compositions[i].price;
                continue;
            }
            if (compositions[i].price > maxPrice) {
                maxPrice = compositions[i].price;
            }

            if (compositions[i].price < minPrice) {
                minPrice = compositions[i].price;
            }
        }

    }    

    return {
        minPrice: minPrice,
        maxPrice: maxPrice
    }

        
  },

  /**
   * 选择商品规格
   * @param {Object} e
   */
  selectGoods: function (e) {
    var that = this;
    var properties = that.data.goodsSelection.properties;
    const propertyIndex = e.currentTarget.dataset.propertyIndex;
    const propertyValueIndex = e.currentTarget.dataset.propertyValueIndex;
    const propertyDisabled = e.currentTarget.dataset.propertyDisabled;
    
    //首先属性应该是可选的,不可选则直接返回
    if (propertyDisabled) {
      console.log('propertyDisabled');
      return;
    }

    // 取消该属性下的所有值的选中状态+设置当前选中状态
    let prevStatus = properties[propertyIndex].values[propertyValueIndex].selected
    var childs = properties[propertyIndex].values;
    for (var i = 0; i < childs.length; i++) {
      properties[propertyIndex].values[i].selected = false;
    }
    properties[propertyIndex].values[propertyValueIndex].selected = !prevStatus;

    // 检查当下的选择
    var checkRes = this.checkSelection();
    let selectedPropertyStr = checkRes.selectedPropertyStr;
    let selectedPropertyIndexs = checkRes.selectedPropertyIndexs;

    let selectedPropertyIndexs2 = selectedPropertyIndexs.slice(),
        selectedPI_v = 0,
        selectedPI_i = 0,
        priceRangeObj,
        selectedPI_len = selectedPropertyIndexs.length;

    for (; selectedPI_i < selectedPI_len; selectedPI_i++){
        selectedPI_v += selectedPropertyIndexs2[selectedPI_i];
        if (selectedPropertyIndexs2[selectedPI_i] == -1){
            selectedPropertyIndexs2[selectedPI_i] = '\\d';
        }
    }


    // 重新计算disable
    let compositions = this.data.goodsSelection.composition;
    let maxPrice = 0,
        minPrice = compositions[0].price;
    
    //当第i个属性未确定,其余均取当前选择的结果,那么看第i个属性所有的值有哪些是存在于组合的
    for (var i = 0; i < selectedPropertyIndexs.length; i++) {      
      let tmpCompProp = selectedPropertyIndexs.slice(0);
      // 将未选中项替换为对应的正则\\d+
      for (var j = 0; j < tmpCompProp.length; j++){
        if (j != i && tmpCompProp[j] == -1)
          tmpCompProp[j] = '\\d+';
      }
      // 遍历第i个属性的所有取值
      let propValue = properties[i].values;
      for (var j = 0; j < propValue .length; j++) {
        tmpCompProp[i] = j;//第i个属性取第j个值
        var exp = new RegExp('^' + tmpCompProp.toString() + "$");//生成对应的正则
        let disabled = true;
        for (var k = 0; k < compositions.length; k++) {
          let compProp = compositions[k].properties;
          let meet = exp.test(compProp.toString());//判断

          if (meet) {
            disabled = false;            
            break;
          }
        };
        propValue[j].disabled = disabled;
      }
    }

    let kefuMsg = '产品名：' + this.data.goodsDetail.basicInfo.name + '规格：' + selectedPropertyStr;


    priceRangeObj = this.getPriceRange(selectedPropertyIndexs2, compositions);

    if (checkRes.skuId){
        // 更新选择
        that.setData({
            goodsSelection: that.data.goodsSelection,
            selectedPropertyStr: selectedPropertyStr,
            sendkefuMsg: kefuMsg,
            isRangePrice: false,
            showMaxPrice: 0,
            showMinPrice: 0,
        });
    }
    else{
        // 更新选择
        that.setData({
            goodsSelection: that.data.goodsSelection,
            selectedPropertyStr: selectedPropertyStr,
            sendkefuMsg: kefuMsg,
            isRangePrice: true,
            showMaxPrice: priceRangeObj.maxPrice,
            showMinPrice: priceRangeObj.minPrice,
        });
    }


    // 更新商品详情
    var skuId = checkRes.skuId;
    if (skuId) {
      var url = baseURL + 'produce/skudetail/' + this.data.shopOfView.shopId + '/'+ prodID + '/' + skuId;

      wx.showLoading()
      rq({
        url: url,
        header: { "with-selection": "false" },
        success: function (r) {
            if (!r.data.data.goodsDetail.pics.length) {
                r.data.data.goodsDetail.pics[0] = '';
            }
            commJS.checkImgExist(r.data.data.goodsDetail.pics);
            r.data.data.goodsDetail.basicInfo.icon = commJS.checkImgExist(r.data.data.goodsDetail.basicInfo.icon);
            that.setData({
              goodsDetail: r.data.data.goodsDetail,
            });
        },
        complete: function () {
            wx.hideLoading();
        }
      })

      that.changeProdFn({ skuId: skuId});

    }
  },

  /**
   * 检查当前的选择是否合法
   * 注意!!!这个方法会更新selectedPropertyStr
   * 返回skuid,空串则非法
   */
  checkSelection: function () {
    // 获取所有的选中规格尺寸数据
    var properties = this.data.goodsSelection.properties
    var needSelectNum = properties.length;
    var curSelectNum = 0;
    var selectedPropertyIndexs = [];
    var selectedPropertyStr = "";
    for (var i = 0; i < properties.length; i++) {
      var childs = properties[i].values;
      var s = false;
      for (var j = 0; j < childs.length; j++) {
        if (childs[j].selected) {
          curSelectNum++;
          s = true;
          selectedPropertyIndexs.push(j);
          // selectedPropertyStr = selectedPropertyStr + properties[i].name + ":" + childs[j].name + "  ";
          selectedPropertyStr = selectedPropertyStr + childs[j].name + "，";
        }
      }
      if (!s)
        selectedPropertyIndexs.push(-1);
    }
    if (selectedPropertyStr.endsWith("，"))
      selectedPropertyStr = selectedPropertyStr.substr(0, selectedPropertyStr.length-1)

    var skuId = '';
    if (needSelectNum == curSelectNum) {
      let comp = this.data.goodsSelection.composition;
      for (var i = 0; i < comp.length; i++) {
        let value = comp[i];
        if (value.properties.toString() == selectedPropertyIndexs.toString()) {
          skuId = value.id;
          break;
        }
      };
    }

    let kefuMsg = '产品名：' + this.data.goodsDetail.basicInfo.name + '规格：' + selectedPropertyStr;

    this.setData({
      selectedPropertyStr: selectedPropertyStr,
      sendkefuMsg: kefuMsg
    });

    return {
      "skuId": skuId,
      "selectedPropertyIndexs": selectedPropertyIndexs,
      "selectedPropertyStr": selectedPropertyStr,
    };
  },

  contactUs: function () {
      commJS.callKefu()
  },

  onShareAppMessage: function () {
    let path = '/pages/details/details?prodId=' + prodID + '&skuId=' + this.data.goodsDetail.basicInfo.id;
    path = commJS.suffixUriWithShopId(this, path);
    return {
      title: '[有人@我] 我觉得你的办公室就缺这款 "'+this.data.goodsDetail.basicInfo.name+'"',
      path: path,
      imageUrl: this.data.goodsDetail.pics[0],
      success: function (res) {
        // 转发成功
      },
      fail: function (res) {
        // 转发失败
      }
    }
  },
  /*图片预览*/
  prevImg : function(e){
      var src = e.currentTarget.dataset.src;
      wx.previewImage({
          current: src, 
          urls: this.data.goodsDetail.pics 
      });
  },
  
  onTapModifyPriceBtn:function(){
    this.expired = true;//设置页面已经过期
    wx.navigateTo({
      url: '../profitsetting/profitsetting?categoryCode=' + this.data.goodsDetail.basicInfo.prodTypeCode,
    })
  },
  onTapShareBtn:function(){
    if (this.data.distributorInfo.level == this.data.DIST_LV_ON_TRAIL)
      wx.showModal({
        title: '正式分销商才能分享商品',
        confirmText: '注册',
        cancelText: '取消',
        success: function (res) {
          if (res.confirm) {
            wx.navigateTo({
              url: '../registerStore/registerStore',
            })
          }
        }
      })
  }
})


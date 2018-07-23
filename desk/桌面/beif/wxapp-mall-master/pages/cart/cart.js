// page/component/new-pages/cart/cart.js

//获取应用实例
let app = getApp(),
  rq = app.bzRequest,
  storageKey = 'cart',
  pageStorage,
  commJS = require("../common/common.js"),
  fromId,
  start_x,
  baseURL = app.globalData.svr;

Page({
  data: {
    showBindPhone: false,
    carts: null,               // 购物车列表,null表示一次初始化都未进行
    totalPrice: 0,           // 总价，初始为0
    allSelected: false,    // 全选状态
    selNum: 0,             //统计已选家具数量
    baseImgUrl: getApp().globalData.baseImgUrl,
    noSelect: true, //未选中任一商品
    btnff: '',
  },
  onLoad: function (options) {
    commJS.injectData(this, options);
  },
  onShow: function () {
    wx.showLoading({
      mask: true,
    })
    if (this.data.isDataInjected) {
      this.reqCartData();
    } else {//当shop数据未准备好时，使用onDataInjected进行刷新购物车数据
      this.onDataInjected = this.reqCartData;
    }
    commJS.updateRoleView(this);
  },
  reqCartData: function () {
    var that = this
    //this.getTotalPrice();
    //请求购物车数据
    rq({
      url: baseURL + 'shopcart/' + that.data.shopOfView.shopId,
      withoutToken: false,
      showLoading: true,
      success: function (r) {

        let cartItems = r.data.data;

        that.dealwithCarT(cartItems);

        commJS.checkImgExist(cartItems, 'imgUrl');

        let carts = that.data.carts||[];

        for (var i = 0; i < cartItems.length; i++) {
          for (var j = 0; j < carts.length; j++) {
            if (cartItems[i].id == carts[j].id) {
              cartItems[i].selected = carts[j].selected;
              break;
            }
          }
        }
        that.setData({
          carts: cartItems,
        });
        // commJS.setStorageByPage(storageKey, that, 'cart', pageStorage, cartItems);
        that.getTotalPrice();
      }
    })
  },
  tstart: function (e) {
    start_x = e.changedTouches[0].clientX;
  },
  tend: function (e) {

    let arr = this.data.carts,
      wid = e.changedTouches[0].clientX - start_x,
      ind = e.currentTarget.dataset.ind;

    if (wid < -20) {
      arr[ind].isShowDel = 'show';
    }
    else if (wid > 20) {
      arr[ind].isShowDel = '';
    }

    this.setData({
      carts: arr
    });


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
  dealwithCarT: function (arr) {
    if (!arr.length) {
      return;
    }
    let i = arr.length,
      maxNum;

    for (; i--;) {

      maxNum = arr[i].maxNum || 9999;

      arr[i]['maxNum'] = maxNum;

      arr[i]['curDisabled'] = arr[i].count <= 1 ? true : false;

      arr[i]['addDisabled'] = arr[i].count >= (maxNum - 1) ? true : false;

      arr[i]['isSel'] = false;
      arr[i]['isShowDel'] = false;

      arr[i]['selected'] = false;

    }

  },
  onimgfail: function (e) {
    let arr = this.data.carts,
      self = this;

    commJS.loadimgfail(arr, e, 'carts', 'imgUrl', self);
  },

  /**
   * 删除购物车当前商品
   */
  removeGoodsFromCart(e) {
    var that = this;
    var id = e.currentTarget.dataset.id;
    const index = e.currentTarget.dataset.index;
    let carts = this.data.carts;
    rq({
      url: baseURL + 'shopcart/' + id,
      method: 'DELETE',
      withoutToken: false,
      success: function (r) {

        carts.splice(index, 1);
        that.setData({
          carts: carts
        });
        that.getTotalPrice();

      }
    });
  },

  limitNum: function (e) {

    let val = Number(e.detail.value),
      ind = e.currentTarget.dataset.arrind,
      arr = this.data.carts,
      min = 1,
      max = 200;

    if (val < min) {
      val = min;
    }
    else if (val > max) {
      val = max;
    }

    this.sentCount(ind, val);
  },

  sentCount: function (ind, val) {

    let arr = this.data.carts,
      id = arr[ind].id,
      count = val,
      that = this;

    rq({
      url: baseURL + 'shopcart/' + id + '/' + count,
      method: 'PUT',
      withoutToken: false,
      success: function (r) {
        arr[ind].count = count;
        that.setData({
          carts: arr,
        });
        that.getTotalPrice();
      }
    })
  },

  /**
   * 当前商品选中事件
   */
  selectGoodsInCart(e) {

    const index = e.currentTarget.dataset.index;
    let carts = this.data.carts;
    const selected = carts[index].selected;
    carts[index].selected = !selected;
    this.setData({
      carts: carts
    });
    this.getTotalPrice();
  },

  /**
   * 购物车全选事件
   */
  selectAll(e) {

    let allSelected = this.data.allSelected;
    allSelected = !allSelected;
    let carts = this.data.carts;

    for (let i = 0; i < carts.length; i++) {
      carts[i].selected = allSelected;
    }
    this.setData({
      allSelected: allSelected,
      carts: carts
    });
    this.getTotalPrice();
  },

  /**
   * 绑定加数量事件
   */
  changeQuantity(e) {
    var that = this;
    const id = e.currentTarget.dataset.id;
    const index = e.currentTarget.dataset.index;
    const change = Number(e.currentTarget.dataset.change);
    let carts = this.data.carts;
    let count = carts[index].count;

    carts[index].addDisabled = false;
    carts[index].curDisabled = false;

    if (change == -1 && count <= 2) {
      carts[index].curDisabled = true;
      that.setData({
        carts: carts
      });
      if (count <= 1) {
        return
      }

    }

    if (change == 1 && count >= (carts[index].maxNum - 1)) {
      carts[index].addDisabled = true;
      that.setData({
        carts: carts
      });

      if (count >= carts[index].maxNum) {
        wx.showToast({
          title: '数量已到极限',
        });
        return;
      }

    }

    count = count + change;
    rq({
      url: baseURL + 'shopcart/' + id + '/' + count,
      method: 'PUT',
      withoutToken: false,
      success: function (r) {
        carts[index].count = count;
        that.setData({
          carts: carts,
        });
        that.getTotalPrice();
      }
    })
  },

  /**
   * 计算总价
   */
  getTotalPrice: function () {

    let carts = this.data.carts;                  // 获取购物车列表
    let total = 0;
    let factoryTotal = 0;
    let noSelect = true;//是否一个都无选中
    let allSelected = true;
    let cNum = 0;
    let isDistributor = this.data.role == this.data.ROLE_DISTRIBUTOR;
    for (let i = 0; i < carts.length; i++) {         // 循环列表得到每个数据
      if (carts[i].selected) {                     // 判断选中才会计算价格
        total += carts[i].count * carts[i].price;   // 所有价格加起来
        if (isDistributor)//分销商计算总成本
          factoryTotal += carts[i].count * carts[i].factoryPrice;
        noSelect = false;
        cNum += carts[i].count;
      } else
        allSelected = false;
    }

    if (!carts.length) {
      allSelected = false;
    }

    this.setData({// 最后赋值到data中渲染到页面
      carts: carts,
      totalPrice: total.toFixed(2),
      totalFactoryPrice: factoryTotal.toFixed(2),
      noSelect: noSelect,
      selNum: cNum,
      allSelected: allSelected,
    });
  },
  /**
   * 下单
   */
  submitOrder: function (e) {
    let orderProducts = [], i = 0;
    for(; i< this.data.carts.length;i++){
      let item = this.data.carts[i];
      if (item.selected){
        if (item.prodStatus == 0) {//'已下架'
          wx.showModal({
            showCancel: false,
            content: carts[i].produceName + '已经下架，不能下单',
          })
          return;
        }
        orderProducts.push(this.data.carts[i]);
      }
    }
    if (orderProducts.length == 0)
      return;

    app.tmpData.orderProducts = orderProducts
    wx.navigateTo({
        url: '../confirmOrder/confirmOrder'
    })
  },
  /*
   显示删除按钮
  */
  delItemFn: function (e) {

    let ind = e.currentTarget.dataset.ind,
      arr = this.data.carts,
      isShow = arr[ind].isShowDel;

    if (isShow == 'show') {
      arr[ind].isShowDel = '';
    }
    else {
      arr[ind].isShowDel = 'show';
    }

    this.setData({
      carts: arr
    })

  },
  delItemFn: function (e) {

    let ind = e.currentTarget.dataset.ind,
      arr = this.data.carts,
      isShow = arr[ind].isShowDel;

    if (isShow == 'show') {
      arr[ind].isShowDel = '';
    }
    else {
      arr[ind].isShowDel = 'show';
    }

    this.setData({
      carts: arr
    })

  },
  delDataItemFn: function (e) {

    let ind = e.currentTarget.dataset.ind,
      arr = this.data.carts,
      self = this,
      id = arr[ind].id;

    function delFail() {
      wx.showToast({
        title: '删除失败',
      });
    }

    rq({
      method: 'delete',
      withoutToken: false,
      errorcb: delFail,
      url: baseURL + 'shopcart/' + id,
      success: function (r) {

        arr.splice(ind, 1);

        self.setData({
          carts: arr
        })

        self.getTotalPrice();

      }
    })

  },
  //提示绑定手机号
  hideBindPhone: function () {
    this.setData({
      showBindPhone: false
    });
    commJS.isRegister('../cart/cart', 1, true);
  },
  //获取绑定手机号
  getPhoneNum: function (e) {

    let self = this;
    if (e.detail.errMsg == 'getPhoneNumber:fail user deny') {
      this.hideBindPhone();

      commJS.isRegister('../cart/cart', 1, true);
    } else {

      let data = e.detail.encryptedData,
        iv = e.detail.iv,
        self = this,
        dat = { "iv": iv, "encryptedData": data };

      sendPhoneData();

      function sendPhoneData() {
        rq({
          method: 'put',
          data: JSON.stringify(dat),
          errorcb: function () {
            wx.showModal({
              content: '绑定失败，请重试。',
              showCancel: false
            });
          },
          //requestAgain: sendPhoneData,
          withoutToken: false,
          errorcb: function () {
            app.login();
          },
          url: baseURL + 'getUserPhone',
          success: function (r) {
            wx.setStorageSync(app.globalData.needRegPhoneNumKey, true);
            wx.showModal({
              content: '绑定成功',
              showCancel: false,
              success: function (res) {
                self.hideBindPhone();

                wx.showLoading({
                  title: '正在下单',
                  mask: true
                })
                //self.placeOrder();
              }
            });

          },
          fail: function () {
            wx.showModal({
              content: '绑定失败',
              showCancel: false,
              success: function (res) {
                self.hideBindPhone();
              }
            });
          }
        });
      }

    }
  },
  getSelectPropCOP: function () {
      this.SelectPropCOP = this.selectComponent('#SelectProp');
  }, 
  //替换产品
    replaceProdFn:function(e){
        debugger
        let that = this,
            data = e.detail,
            //basicInfo = data.basicInfo,
            count = data.num,
            skuid = data.skuid,
            handle = data.thisCase,
            cartId = handle.cartId; 

        if (skuid){

            rq({
                method: 'PUT',
                withoutToken: false,
                data: JSON.stringify({ id: cartId, skuId: skuid, count: count}),
                url: baseURL + 'shopcart/replace',
                success: function (r) {
                    handle.hideSelectView();
                    that.onShow();
                },
                errorcb : function(r){
                    wx.showToast({
                        title: r.data.meta.msg,
                        icon: 'none'
                    });
                }
            })

        }
        else{
            wx.showToast({
                title: '每个属性必须选择一项',
                icon: 'none'
            });
        }

    },
    //显示SKU弹窗
  showSkuInfo : function(e){
      
      let that = this,
          ind = e.currentTarget.dataset.ind,
          arr = this.data.carts,
          temp = arr[ind],
          count = temp.count,
          cartId = temp.id,
          prodId = temp.produceId,
          skuId = temp.skuId,
          shopId = this.data.shopOfView.shopId;


      rq({
          method: 'GET',
          withoutToken: false,
          url: baseURL + 'produce/goodsSelection/' + shopId + '/' + prodId + '/' + skuId,
          success: function (r) {


              let goodsDetail = {},
                  goodsSelection = {};

              goodsDetail.basicInfo = {};
              goodsDetail.basicInfo.factoryPrice = temp.factoryPrice;
              goodsDetail.basicInfo.icon = temp.imgUrl;
              goodsDetail.basicInfo.id = skuId;
              //goodsDetail.basicInfo.marketPrice = 123;
              goodsDetail.basicInfo.name = temp.produceName;
              goodsDetail.basicInfo.price = temp.price;
              //goodsDetail.pics = [];
              //goodsDetail.specification = {};  

              goodsSelection = r.data.data;


              let selection = goodsSelection;
              let selected = goodsSelection.selected;

              for (let i = 0; i < selected.properties.length; i++) {
                  let idx = selected.properties[i];
                  try {
                      selection.properties[i].values[idx].selected = true
                  } catch (e) {
                      console.error(e)
                  }
              }


              if (!that.SelectPropCOP) {
                  that.getSelectPropCOP();
              }

              that.SelectPropCOP.setData({
                  goodsSelection: goodsSelection,
                  goodsDetail: goodsDetail,
                  prodid: prodId,
                  purchaseQuantity: count,
                  isRangePrice : false
              });

              that.SelectPropCOP.cartId = cartId;

              that.SelectPropCOP.showSelectView();

              

          }
      })
      
  }

})
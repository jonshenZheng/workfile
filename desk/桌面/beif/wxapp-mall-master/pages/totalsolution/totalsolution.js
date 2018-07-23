// pages/totalsolution/totalsolution.js
var common = require('../common/common.js')
let app = getApp(),
    rq = app.bzRequest,
    baseURL = app.globalData.svr,
    pageBeforeLoadRun = app.pageBeforeLoadRun,
    storageKey = 'index',
    maxUploadImgLen = 4,
    imgBaseURL = app.globalData.baseImgUrl,
    updateSaleinfoObj = {
        id : 'none',
        ind1 : 'none',
        ind2 : 'none' 
    },
    needStr = '';
const INDEX_BIZOPP_SEA = 0;
const INDEX_MY_BIZOPPS = 1;
const INDEX_MY_FAVORITES = 2;
const REQ_FAVOR_SIZE = 12;

Page({

  /**
   * 页面的初始数据
   */
  data: {
      //获取报价相关
      vedioSrc: imgBaseURL + 'weixin/video/introduce.mp4',
       needsList : [
           { name: '价格实惠', isActive : false },
           { name: '性价比高', isActive: false },
           { name: '国际品牌', isActive: false },
           { name: '现货为主', isActive: false },
           { name: '10天到位', isActive: false },
           { name: '正常工期', isActive: false },
           { name: '商务', isActive: false },
           { name: '休闲', isActive: false },
           { name: '工业', isActive: false },
           { name: '中式', isActive: false },
           { name: '现代', isActive: false },
           { name: '简约', isActive: false },
           { name: '互联网', isActive: false },
           { name: '消费品', isActive: false },
           { name: '金融', isActive: false },
           { name: '事业单位', isActive: false },
           { name: '广告传媒', isActive: false },
           { name: '餐饮', isActive: false },
           { name: '旅游', isActive: false },
       ],
       nullVal : '',
       selectImgArr : [], 
       isHedeAddImgBtn : false,

      //商机相关
       curIndex: 0,//商机公海-我的商机-我的收藏这几栏标签当前选中的index
       curIndex2: 0,//我的商机下面，已抢占跟已锁定标签栏当前选中的index
       searchStr: '',
       bizoppsInSea: [],// 公海里的商机
       bizoppsTracked: [],//用户当前跟踪的商机
       bizoppsLocked: [],//用户当前锁定的商机
       bizoppsInFavorites: [],//用户当前收藏的商机
       noMoreFavorites: false,//已经没有更多的收藏
       isShowReflash: true,//是否显示“新线索为你刷新”那一栏
       hasMoreHistoryBizopp : true,//是否还有更多的历史商机
       showhistoryId : 'none',//历史查看到
       reScrollToTop : 0,//控制商机公海view滚到顶
       isShowUpdateTips : false,//是否显示刷新后的提示栏
       hasNewBizopp: true,//是否有新的商机
       noMoreLockedBizopps: false,//是否有更多的被锁商机
       lockedCount: 0,//锁定的商机数目
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    pageBeforeLoadRun(this);

    // 注入商机常量
    injectBizoppConstants(this);

    // 注入分销商信息
    common.injectData(this);
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
        let that = this;
      //还原数据
      if (app.globalData.tempdata.refresh){

          let optList = [
              { name: '价格实惠', isActive: false },
              { name: '性价比高', isActive: false },
              { name: '国际品牌', isActive: false },
              { name: '现货为主', isActive: false },
              { name: '10天到位', isActive: false },
              { name: '正常工期', isActive: false },
              { name: '商务', isActive: false },
              { name: '休闲', isActive: false },
              { name: '工业', isActive: false },
              { name: '中式', isActive: false },
              { name: '现代', isActive: false },
              { name: '简约', isActive: false },
              { name: '互联网', isActive: false },
              { name: '消费品', isActive: false },
              { name: '金融', isActive: false },
              { name: '事业单位', isActive: false },
              { name: '广告传媒', isActive: false },
              { name: '餐饮', isActive: false },
              { name: '旅游', isActive: false },
          ];

          this.setData({
              needsList: optList,
              nullVal: '',
              selectImgArr: []
          });  


          app.globalData.tempdata.refresh = false;
      }    


    if(this.data.isDataInjected){

        if (updateSaleinfoObj.id !== 'none'){
            that.refreshOneBizopp(updateSaleinfoObj.id);
            this.resetUpdateSaleinfoObj();
        }
    }

  },
  onDataInjected: function (option) {
    let that = this;
    let barTitle = '获取报价';
    if(this.data.role ==this.data.ROLE_DISTRIBUTOR){
      // 请求最近推荐过的历史商机，如果没有则请求推荐商机
      rq({
        url: baseURL +'bizopp/latest',
        success: function(res){
          let bizopps = res.data.data;
          if (!bizopps || bizopps.length == 0)
            that.onTapRrefreshBtn();
          else
            that.setData({
              bizoppsInSea: bizopps
            })
        }
      })
      this.reqKeyCount();
      barTitle = '销售线索';
    }
    wx.setNavigationBarTitle({
      title: barTitle,
    })
  },
  //删除选中的图片
  delImgFn : function(e){
      var ind = e.currentTarget.dataset.ind,
          arr = this.data.selectImgArr;

       arr.splice(ind,1); 

       let isHide = arr.length >= 4 ? true : false;

        this.setData({
            selectImgArr : arr,
            isHedeAddImgBtn: isHide 
        });
  },
  //选择图片
  selectImgFn : function(){
      let self = this,
          imgArr = self.data.selectImgArr,
          thisImgNum = maxUploadImgLen - imgArr.length;
        if (imgArr.length >= maxUploadImgLen ){
            wx.showToast({
                title: '上传图片最多' + maxUploadImgLen+'张',
                icon : 'none'
            });
            return;
        }

        wx.chooseImage({
            count: thisImgNum,
            success: function(res) {

                imgArr = imgArr.concat(res.tempFilePaths);
           
                let isHide = imgArr.length >= maxUploadImgLen ? true : false;

                self.setData({
                    selectImgArr: imgArr,
                    isHedeAddImgBtn: isHide
                });

            }
        })
  },
  //选择客户需求
  selectNeeds : function(e){
      let arr = this.data.needsList,
          ind = e.currentTarget.dataset.ind,
          name = arr[ind].name+';',
          temp_name,
          temp = ';'+needStr,
          isSel = arr[ind].isActive;

       if (isSel){
            
           if (needStr != ''){
               temp_name = ';'+name;
               if (temp.indexOf(temp_name) !== -1){
                   temp = temp.slice(1);
                   needStr = temp.split(name).join('');
               }
           }

       } 
       else{
           needStr += name;
       }

       arr[ind].isActive = !isSel;

       this.setData({
           needsList : arr
       });

  },
  formSubmit : function(e){

    let uploadImg = [],
        selectImgArr = this.data.selectImgArr,
        uploadImg_i = selectImgArr.length,
        formId = e.detail.formId,
        orderNum,
        phoneNum = e.detail.value.phoneNum,
        data = {
            phone: phoneNum,
            needs: needStr,
            imgPaths: uploadImg
        },
        submitFn = function () {
            rq({
                url: baseURL + 'solution/save',
                withoutToken: false,
                method: 'POST',
                data: JSON.stringify(data),
                success: function (r) {
                
                    orderNum = r.data.data;
                    let time = common.getFormatTime('show');

                    rq({
                        url: baseURL + 'accessToken',
                        success: function (r) {

                            common.sentServerNotice({
                                rq : rq,
                                template_id :'RQdIs2RqmYGiq9MImXFPNDAFvXNuzTMbRW_r7QHPE9E',
                                formId: formId,
                                accessToken : r.data.data,
                                pageInd : 'pages/index/index',
                                emphasis_keyword: "keyword1.DATA",
                                data: {
                                    "keyword1": {
                                        "value": '全套服务',
                                        "color": "#ff0000"
                                    },
                                    "keyword2": {
                                        "value": '成功',
                                        "color": "#173177"
                                    },
                                    "keyword3": {
                                        "value": orderNum,
                                        "color": "#173177"
                                    },
                                    "keyword4": {
                                        "value": time,
                                        "color": "#173177"
                                    },
                                    "keyword5": {
                                        "value": '我们将在3个工作日内联系您，请耐心等待',
                                        "color": "#ff0000"
                                    }
                                }
                            });

                        }
                    });

                    wx.navigateTo({
                        url: "../buySuccess/buySuccess?pageType=全套服务",
                    });

                },
                complete: function(){
                    wx.hideLoading();
                }

            });
        },
        upFn = function(){
            
            if (uploadImg_i<=0){
                submitFn();
                return;
            }

            wx.uploadFile({
                url: baseURL + 'solution/imageupload', 
                filePath: selectImgArr[uploadImg_i-1],
                name: 'file',
                success: function (res) {
                    let data = JSON.parse(res.data);
                    console.log(data);
                    uploadImg.push(data.data);
                    console.log('ok');
                },
                fail : function(){
                    console.log('失败');
                },
                complete : function(){
                    uploadImg_i--;
                    upFn();
                }
            });

        };

    if (!common.formCheck.isPhone(phoneNum)){
        wx.showToast({
            title: '手机号错误',
            icon : 'none'
        });
         return;
    }     

    if (uploadImg_i <= 0){
        wx.showToast({
            title: '请上传户型图',
            icon : 'none'
        });
        return;
    }

    wx.showLoading({
        title: '正在上传文件',
    });
    upFn();

  },


  /****************** 以下是商机相关 *******************/
  /**
   * 切换标签页
   * 切换标签页通过设置curIndex会导致swiper滑动，swiper滑动再触发onSwiperChange
   */
  swichTab: function (e) {
    let ind = e.currentTarget.dataset.ind,
      that = this;

    if(ind == this.data.curIndex){
        return;
    } 

    this.setData({
      curIndex: ind
    });
  },

  /**
   * 销售线索swiper切换时触发
   */
  onSwiperChange:function(e){
    this.setData({
      curIndex: e.detail.current
    });

    if (this.data.curIndex == INDEX_MY_FAVORITES) {
      this.data.bizoppsInFavorites = [];
      this.reqMyFavorites(0, REQ_FAVOR_SIZE);
    } else if (this.data.curIndex == INDEX_MY_BIZOPPS) {
      this.data.bizoppsTracked = [];
      this.reqMyTrackingBizopps();
    }
  },

  /**
   * 搜索框
   */
  inputKeyWord: function (e) {

    let keyWord = e.detail.value,
      str = '';

    str = keyWord.length > 0 ? 'background-image:none' : '';

    this.setData({
      searchStr: str
    })
  },

  /**
   * 根据id从data里拿到对应的bizopp
   */
  getBizoppByIdFromPageData: function (bizoppId) {
    let bizopps = [];
    let curIndex = this.data.curIndex;
    let curIndex2 = this.data.curIndex2;
    if (curIndex == INDEX_BIZOPP_SEA)
      bizopps = this.data.bizoppsInSea;
    else if (curIndex == INDEX_MY_BIZOPPS) {
      if (curIndex2 == 0)
        bizopps = this.data.bizoppsTracked;
      else
        bizopps = this.data.bizoppsLocked;
    } else if (curIndex == INDEX_MY_FAVORITES) {
      bizopps = this.data.bizoppsInFavorites;
    }
    for (var i = 0; i < bizopps.length; i++) {
      var bizopp = bizopps[i];
      if (bizopp.id == bizoppId)
        return bizopp;
    }
    return null;
  },

  resetUpdateSaleinfoObj: function () {
    updateSaleinfoObj.id = 'none';
    updateSaleinfoObj.ind1 = 'none';
    updateSaleinfoObj.ind2 = 'none';
  },

  /**
   * 根据id刷新某一商机
   */
  refreshOneBizopp: function (bizoppId) {
    let that = this;
    let bizopps = [];
    // 先根据当前是哪个tab确定是哪个列表
    let curIndex = this.data.curIndex;
    let curIndex2 = this.data.curIndex2;
    if (curIndex == INDEX_BIZOPP_SEA)
      bizopps = this.data.bizoppsInSea;
    else if (curIndex == INDEX_MY_BIZOPPS) {
      if (curIndex2 == 0)
        bizopps = this.data.bizoppsTracked;
      else
        bizopps = this.data.bizoppsLocked;
    } else if (curIndex == INDEX_MY_FAVORITES) {
      bizopps = this.data.bizoppsInFavorites;
    }
    // 遍历找出对应的商机进行刷新
    for (var i = 0; i < bizopps.length; i++) {
      var bizopp = bizopps[i];
      if (bizopp.id == bizoppId) {
        rq({
          url: baseURL + 'bizopp/simple/' + bizoppId,
          success: function (res) {
            let bizopp2 = res.data.data;
            if (bizopp2.expiredTime) {
              bizopp2.expiredTimeNoYear = bizopp2.expiredTime.slice(5);//不带年份的过期日期，方便显示
            }
            bizopps[i] = bizopp2
            if (curIndex == INDEX_MY_BIZOPPS) {
              // 锁定||从我的商机里删除
              if (curIndex2 == 0) {
                if (!bizopp2.mine || bizopp2.noExpiry)
                  bizopps.splice(i, 1)
                if (bizopp2.noExpiry)
                  that.setData({ lockedCount: that.data.lockedCount + 1 })
              }
              else
                if (!bizopp2.mine)
                  bizopps.splice(i, 1)
            }
            that.refreshView();
          }
        })
        break;
      }

    }
  },

  /**
   * 主动刷新一下商机视图，目前是商机页面刷新视图的最终去处
   * 这个函数目前是很暴力的，会刷新所有，同时请求钥匙数目
   */
  refreshView: function () {
    this.setData({
      bizoppsInSea: this.data.bizoppsInSea,
      bizoppsTracked: this.data.bizoppsTracked,
      bizoppsLocked: this.data.bizoppsLocked,
      bizoppsInFavorites: this.data.bizoppsInFavorites,
    });
    this.reqKeyCount();//请求钥匙数目
  },

  /**
   * 请求推荐商机
   */
  reqRecommendBizopp: function () {
    let that = this;
    let bizopps = this.data.bizoppsInSea;
    rq({
      url: baseURL + 'bizopp/recommend',
      method: 'GET',
      showLoading: true,
      success: function (res) {
        let newBizopps = res.data.data;
        let num = newBizopps.length;
        if (newBizopps && newBizopps.length > 0) {
          // console.log("当前商机列表1 ", that.data.bizopps)
          
          if (!bizopps || bizopps.length == 0)
            bizopps = newBizopps;
          else {
              that.setData({
                  showhistoryId: bizopps[0].id
              })
              bizopps = newBizopps.concat(bizopps);//接到数组前方
          }
            
          that.setData({
            bizoppsInSea: bizopps,
          })   
        }
        that.setData({
          updateNum: num,
        })   
      },
      complete:function(){

        that.setData({
          isShowUpdateTips: true,
          isShowReflash: false,
          hasNewBizopp: false
        });
        wx.hideTabBarRedDot({
          index: 2
        })

        // 定时器--有新商机
        setTimeout(() => {
          that.setData({
            hasNewBizopp: true
          });
        }, 2 * 60 * 1000)
        // 定时器关闭刷新后的提示
        setTimeout(function () {
          that.setData({
            isShowUpdateTips: false,
            isShowReflash: true
          })
        }, 2500) 
      }
    })
  },

  /**
   * 点击商机公海--刷新按钮
   */
  onTapRrefreshBtn : function(){

        this.setData({
            reScrollToTop : 0
        })

        let that = this;
        
        setTimeout(function(){
            that.reqRecommendBizopp();
        }, 500)
  },

  /**
   * 请求钥匙数量
   */
  reqKeyCount: function(){
    let that = this;
    rq({
      url: baseURL + 'bizopp/key',
      success: function (res) {
        let count = res.data.data;
        that.setData({
          keyCount: count
        });
      }
    })
  },

  /**
   * 商机公海视图滚动到底层时触发
   */
  onBizoppSeaViewScrollToLower: function(){
    if (this.data.hasMoreHistoryBizopp)
      this.reqHistoryBizopp();
  },

  /**
   * 获取历史商机
   */
  reqHistoryBizopp: function () {
    let that = this;
    let bizopps = this.data.bizoppsInSea;
    if (!bizopps || bizopps.length == 0) {
      console.log('>?????')
      return;
    }

    var seq = bizopps[bizopps.length - 1].sequence;
    rq({
      url: baseURL + 'bizopp/history/' + seq,
      method: 'GET',
      success: function (res) {
        let history = res.data.data;
        if (!history || history.length == 0) {
          that.setData({
            hasMoreHistoryBizopp: false
          })
          wx.showToast({
            title: '已无更多历史推荐记录',
            icon: 'none'
          })
          return;
        }

        bizopps = bizopps.concat(res.data.data)
        
        that.setData({
          bizoppsInSea: bizopps
        })
        // console.log("当前商机列表 ", that.data.bizoppsInSea)
      }
    })
  },

  /**
   * 点击收藏按钮时触发的事件
   */
  onTapFavoritesBtn: function (e) {
    let that = this;
    let bizoppId = e.currentTarget.dataset.bizoppid;
    let bizopp = this.getBizoppByIdFromPageData(bizoppId)
    if (bizopp.inFavorites) {
      let onSuccess = function (res) {//取消收藏成功后，本地进行一定的逻辑处理
        that.refreshView();
      }
      // 取消收藏
      removeBizoppFromFavorites(bizopp, onSuccess);
    } else {
      let onSuccess = function (res) {
        that.refreshView();
      }
      //添加收藏
      addBizoppToFavorites(bizopp, onSuccess);
    }
  },

  /**
   * 点击追踪商机按钮
   */
  onTapTrackBtn: function (e) {
    let that = this;
    let bizoppId = e.currentTarget.dataset.bizoppid;
    let bizopp = this.getBizoppByIdFromPageData(bizoppId)


    if (bizopp.mine){
      this.viewBizoppDetail(bizoppId);
      return;
    }else{
      var onSuccess = function (res) {
        wx.showToast({
          title: '成功'
        })
        // that.refreshOneBizopp(bizoppId);
        that.viewBizoppDetail(bizoppId);
      };
      var onFail = function (res) {
        that.refreshOneBizopp(bizoppId);
      }
      let viewOnly = that.data.distributorInfo.level <= that.data.DIST_LV_EXPERIENCE;
      trackBizopp(bizopp, viewOnly, onSuccess, onFail);
    }
  },

  /**
   * 点击商机视图
   * 进而调用查看商机详情
   */
  onTapBizoppView(e) {
    let bizoppId = e.currentTarget.dataset.bizoppid;
    this.viewBizoppDetail(bizoppId);
  },

  /**
   * 查看商机详情
   */
  viewBizoppDetail: function (bizoppId) {
    updateSaleinfoObj.id = bizoppId;//记录下需要被刷新的商机id
    updateSaleinfoObj.ind1 = this.data.curIndex;
    updateSaleinfoObj.ind2 = this.data.curIndex2;
    // 跳转到详情页
    wx.navigateTo({
      url: 'bizoppDetail/bizoppDetail?bizoppId=' + bizoppId,
    })    
  },

  /**
   * 切换我的商机下面的的标签
   * 已抢占+已锁定
   */
  swichTabUnderMyBizopp: function (e) {
    let ind = e.currentTarget.dataset.ind
    
    if(ind == this.data.curIndex2){
        return;
    }

    this.setData({
      curIndex2: parseInt(ind),
    });

    // 点击我的商机-》已锁定，总会reset并重新请求
    if (this.data.curIndex2 == 1){
      this.data.bizoppsLocked = [];
      this.setData({
        noMoreLockedBizopps: false
      });
      this.reqMyLockedBizopps();
    }
  },

  /**
   * 请求当前追中的商机
   */
  reqMyTrackingBizopps: function () {
    let that = this;
    rq({
      url: baseURL + 'bizopp/myBizs',
      method: 'GET',
      showLoading: false,
      success: function (res) {
        let lockedCount = res.data.data.lockedCount;
        that.setData({
          lockedCount: lockedCount
        });
        let bizopps = res.data.data.bizsData;
        for (var i = 0; i < bizopps.length; i++) {
          let bizopp = bizopps[i]
          if (bizopp.expiredTime)
            bizopp.expiredTimeNoYear = bizopp.expiredTime.slice(5)//去掉年
        }
        that.setData({
          bizoppsTracked: res.data.data.bizsData,
          trackCapacity: res.data.data.capacity,
        });
      }
    })
  },

  /**
   * 我的商机==》已锁定视图滚动到底时触发的事件
   */
  onMyLockedBizoppViewScrollToLower:function(){
    if (!this.data.noMoreLockedBizopps)
      this.reqMyLockedBizopps();
  },

  /**
   * 请求我的商机--》已锁定
   */
  reqMyLockedBizopps: function () {
    let that = this;
    let bizopps = that.data.bizoppsLocked;
    rq({
      url: baseURL + 'bizopp/lock/' + bizopps.length+'/10',
      method: 'GET',
      showLoading: false,
      success: function (res) {
        let moreBizopps = res.data.data;
        if (moreBizopps && moreBizopps.length > 0){
          bizopps = bizopps.concat(moreBizopps);//拼接上去
          that.setData({
            bizoppsLocked: bizopps,
          });
        }else{
          that.setData({
            noMoreLockedBizopps: true,
          });
        }
      }
    })
  },

  /**
   * 点击锁定商机按钮触发的事件
   */
  onTapLockBtn: function (e) {
    let that = this;
    let bizoppId = e.currentTarget.dataset.bizoppid;
    let bizopp = this.getBizoppByIdFromPageData(bizoppId)
    if (this.data.distributorInfo.level > this.data.DIST_LV_EXPERIENCE) {
      wx.showModal({
        title: '消耗1把钥匙，锁住商机',
        content: '商机被您锁住后，倒计时将会关闭，永久锁住在您的商机列表',
        confirmText: '锁住商机',
        success: function (res) {
          if (res.confirm) {
            // 锁定成功的回调  这里默认是在【我的商机/已抢占】，锁定则移除
            let onSuccess = function () {
              let bizopps = that.data.bizoppsTracked;
              for (var i = 0; i < bizopps.length; i++) {
                if (bizopps[i] === bizopp) {
                  bizopps.splice(i, 1);
                  that.refreshView();
                  break;
                }
              }

              wx.showToast({
                title: '锁定成功',
                mask: false,
                duration: 2500
              })

              // 更新锁定数量
              that.setData({
                lockedCount: that.data.lockedCount + 1
              })
            }
            lockBizopp(bizopp, onSuccess);
          }
        }
      })
    } else {
      wx.showModal({
        title: '等级不够，无法锁住商机',
        content: '体验分销商无法锁住商机，升级分销商等级，锁住商机，独家拥有',
        showCancel: false,
        confirmText: '知道了'
      })
    }
  },

 /**
   * 点击删除商机按钮触发的事件
   */
  onTapUntrackBtn: function (e) {
      
    let that = this;
    let bizoppId = e.currentTarget.dataset.bizoppid;
    let bizopp = this.getBizoppByIdFromPageData(bizoppId)
    let onSuccess = function () {
      let bizopps = that.data.bizoppsTracked;
      if (that.data.curIndex2 == 1)
          bizopps = that.data.bizoppsLocked;
      for (var i = 0; i < bizopps.length; i++) {
        if (bizopps[i] === bizopp) {
          bizopps.splice(i, 1);
          that.refreshView();
          break;
        }
      }
    }
    untrackBizopp(bizopp, onSuccess);
  },

  /**
   * 分页的方式请求我的收藏
   */
  reqMyFavorites: function (fromm, size) {
    let that = this;
    let bizoppsInFavorites = that.data.bizoppsInFavorites;
    rq({
      url: baseURL + 'bizopp/collect/' + fromm + '/' + size,
      method: 'GET',
      showLoading: false,
      success: function (res) {
        bizoppsInFavorites = bizoppsInFavorites.concat(res.data.data);
        that.setData({
          bizoppsInFavorites: bizoppsInFavorites
        });
        let noMoreFavorites = false;
        if (res.data.data.length < size)
          noMoreFavorites = true;
        that.setData({ noMoreFavorites: noMoreFavorites })
      }
    })
  },

/**
 * 我的收藏视图滚动到底时触发的事件
 */
  onMyFavoritesViewScrollToLower: function () {
    let bizoppsInFavorites = this.data.bizoppsInFavorites;
    if (this.data.noMoreFavorites)
      return;
    this.reqMyFavorites(bizoppsInFavorites.length, REQ_FAVOR_SIZE);
  }
})


const BIZOPP_STATUS_TRACKED = 5;
/**
 * 注入商机常量
 */
function injectBizoppConstants(page) {
  console.log('注入商机常量');
  page.setData({
    BIZOPP_STATUS_TRACKED: BIZOPP_STATUS_TRACKED,
  })
}

/**
 * 抢占商机
 */
function trackBizopp(bizopp, viewOnly, onSuccess, onFail, onComplete) {
  let that = this;
  let bizoppId = bizopp.id;
  if (bizopp.mine)
    return;
  if (bizopp.status == BIZOPP_STATUS_TRACKED) {
    wx.showModal({
      content: '商机已被其他人抢占，您无法抢占该商机',
      confirmText: '知道了',
      showCancel: false
    })
    return;
  } else {
    var onTrackError = function(code, msg){
      // 处理追踪商机的结果
      if (code == 410) {
        wx.showModal({
          title: "开启线索的钥匙不够",
          content: '获得该线索需要消耗一把钥匙，您的钥匙数额不够，无法查看线索。您可以通过完成订单，获得钥匙奖励。',
          showCancel: false,
          confirmText: '知道了'
        })
      } else if (code == 420) {
        wx.showModal({
          title: "分销商等级不够，无法查看",
          content: '该级别的线索需要更高级的分销商权限才能查看，建议联系客服升级。',
          showCancel: false,
          confirmText: '知道了'
        })
      } else if (code == 430) {
        wx.showModal({
          title: "抢占数量达到上限",
          content: '您可以在“我的商机”列表删除不需要的商机，或者提升分销商等级获得更大的商机抢占上限。',
          showCancel: false,
          confirmText: '知道了'
        })
      } else if (code == 440) {
        wx.showModal({
          content: '商机已被其他人抢占，您无法抢占该商机。',
          showCancel: false,
          confirmText: '知道了'
        })
        // 更新商机状态为已抢占
        if (bizopp)
          bizopp.status = BIZOPP_STATUS_TRACKED
      }

      if (typeof (onFail) == 'function')
        onFail();
    }

    // 查看能否进行跟踪
    rq({
      url: baseURL + 'bizopp/check/'+bizoppId,
      method: 'GET',
      success: function (res) {
        let title = '消耗1把钥匙，抢占商机';
        let content = '商机被您抢占后，其他人无法再抢占。您可以在“我的商机”中跟进商机。';
        let confirmText = '抢占商机';
        if (viewOnly) {
          title = '消耗1把钥匙，查看商机';
          content = '体验分销商只能查看商机，升级成为更高级别分销商，抢占商机，独家拥有。';
          confirmText = '查看商机';
        }

        wx.showModal({
          title: title,
          content: content,
          confirmText: confirmText,
          success: function (res) {
            if (res.confirm) {
              rq({
                url: baseURL + 'bizopp/grab/' + bizoppId,
                method: 'POST',
                noErrorLog: true,
                success: function (res) {
                  let code = res.data.meta.code;
                  let msg = res.data.meta.msg;
                  if (typeof (onSuccess) == 'function')
                    onSuccess(res);
                },
                errorcb: function (res) {
                  let code = res.data.meta.code;
                  let msg = res.data.meta.msg;
                  onTrackError(code, msg)
                },
                complete: function (res) {
                  if (typeof (onComplete) == 'function')
                    onComplete(res);
                }
              })
            }
          }
        })
      },
      errorcb: function (res) {
        let code = res.data.meta.code;
        let msg = res.data.meta.msg;
        onTrackError(code, msg)
      },
    })

  }
}


/**
 * 取消对商机的追踪
 */
function untrackBizopp(bizopp, onSuccess) {
  wx.showModal({
    title: '移除商机',
    content: '移除后，商机会回到商机公海，您将不再私有该商机',
    confirmText: '移除',
    success: function (res) {
      if (res.confirm) {
        rq({
          url: baseURL + 'bizopp/remove/' + bizopp.id,
          method: 'DELETE',
          showLoading: true,
          success: function (res) {
            console.log(res);
            wx.showToast({
              title: '移除商机成功',
              mask: true,
              duration: 1000
            })
            // 成功回调
            if (typeof (onSuccess) == 'function')
              onSuccess();
          }
        })
      }
    }
  })
}

/**
 * 添加商机到搜藏
 */
function addBizoppToFavorites(bizopp, onSuccess) {
  let that = this;
  rq({
    url: baseURL + 'bizopp/collect/' + bizopp.id,
    method: 'POST',
    success: function (res) {
      bizopp.inFavorites = true;
      bizopp.favoritesCount = bizopp.favoritesCount ? bizopp.favoritesCount + 1 : 1;
      wx.showToast({
        title: '已收藏',
      });
      // 成功回调
      if (typeof (onSuccess) == 'function')
        onSuccess();
    }
  })
}

/**
 * 取消对商机的收藏
 */
function removeBizoppFromFavorites(bizopp, onSuccess) {
  let that = this;
  rq({
    url: baseURL + 'bizopp/collect/' + bizopp.id,
    method: 'DELETE',
    success: function (res) {
      bizopp.inFavorites = false;
      bizopp.favoritesCount = bizopp.favoritesCount ? bizopp.favoritesCount - 1 : 0;
      wx.showToast({
        title: '取消收藏',
      });
      // 成功回调
      if (typeof (onSuccess) == 'function')
        onSuccess();
    }
  })
}

/**
 * 锁定商机
 */
function lockBizopp(bizopp, onSuccess) {
  rq({
    url: baseURL + 'bizopp/lock/' + bizopp.id,
    method: 'POST',
    showLoading: true,
    success: function (res) {
      bizopp.noExpiry = true;
      // 成功回调
      if (typeof (onSuccess) == 'function')
        onSuccess();
    }
  })
}
module.exports = {
  injectBizoppConstants: injectBizoppConstants,
  addBizoppToFavorites: addBizoppToFavorites,
  removeBizoppFromFavorites: removeBizoppFromFavorites,
  trackBizopp: trackBizopp,
  untrackBizopp: untrackBizopp,
  lockBizopp: lockBizopp
}
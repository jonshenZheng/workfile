var commJS = require('../../common/common.js')
var bizoppJS = require('../totalsolution.js')
let app = getApp(),
  rq = app.bzRequest,
  pageBeforeLoadRun = app.pageBeforeLoadRun,
  baseURL = app.globalData.svr,
  imgBaseURL = app.globalData.baseImgUrl;

Page({

  /**
   * 页面的初始数据
   */
  data: {
      toView : 'pageV1',
      bizoppId: null,
      bizopp: null,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

    pageBeforeLoadRun(this);

    this.setData({
      bizoppId: options.bizoppId
    })
    commJS.injectData(this);
    bizoppJS.injectBizoppConstants(this);
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.reqBizoppDetail(this.data.bizoppId);
  },

  onUnload: function () {
    clearInterval(this.expiryCountdownHandler);
  },
  /**
   * 启动商机倒计时
   */
  startExpiryCountdownIfNecessary: function () {
    let bizopp = this.data.bizopp;
    
    if (bizopp.mine && !bizopp.noExpiry) {
      console.log('startExpiryCountdownIfNecessary ' + bizopp.expiredTime)
      let expiryDate = new Date(bizopp.expiredTime.replace(/\-/g, "/"));//
      let that = this;

      if (this.expiryCountdownHandler)
        clearInterval(this.expiryCountdownHandler);

      this.expiryCountdownHandler = commJS.countdown(expiryDate, function (res) {
        that.setData({
          expiryCountdown: res
        });
        // console.log(res)
        if(res.isOver){
          wx.showToast({
            title: '商机已过期',
            icon: 'loading',
            mask: true,
            duration: 1500
          })
          setTimeout(()=>{
            wx.navigateBack({})            
          }, 1500)
        }
      });
    }
  },

  /**
   * 请求商机详情
   */
  reqBizoppDetail: function (bizoppId) {
    let that = this;

    rq({
      url: baseURL + 'bizopp/detail/' + bizoppId,
      method: 'GET',
      success: function (res) {
        that.setData({
          bizopp: res.data.data
        })
        that.startExpiryCountdownIfNecessary();
      }
    })
  },
  /**
   * 点击收藏按钮
   */
  onTapFavoritesBtn: function (e) {
    let that = this;
    let bizopp = this.data.bizopp
    if (bizopp.inFavorites) {
      let onSuccess = function (res) {
        that.setData({
          bizopp: bizopp
        });
      }
      bizoppJS.removeBizoppFromFavorites(bizopp, onSuccess);
    } else {
      let onSuccess = function (res) {
        that.setData({
          bizopp: bizopp
        });
      }
      bizoppJS.addBizoppToFavorites(bizopp, onSuccess);
    }
  },
  /**
   * 点击追踪按钮
   */
  onTapTrackBtn: function (e) {
    let that = this;
    var onSuccess = function (res) {
      wx.showToast({
        title: '成功'
      })
      that.setData({
        bizopp: res.data.data
      });// 更新商机详情view
      that.startExpiryCountdownIfNecessary();//开启倒计时
    }
    let viewOnly = this.data.distributorInfo.level <= this.data.DIST_LV_EXPERIENCE;
    bizoppJS.trackBizopp(this.data.bizopp, viewOnly, onSuccess);
  },
  onTapUntrackBizoppBtn: function(){
    let that = this;
    let bizopp = this.data.bizopp;
    let onSuccess = function(){
      setTimeout(() => {
        wx.navigateBack({});
      }, 1000)
    }
    bizoppJS.untrackBizopp(bizopp, onSuccess);
  },
  onTapLockBizoppBtn(){
    let that = this;
    let bizopp = this.data.bizopp;
    
    if (this.data.distributorInfo.level > this.data.DIST_LV_EXPERIENCE){
      wx.showModal({
        title: '消耗1把钥匙，锁住商机',
        content: '商机被您锁住后，倒计时将会关闭，永久锁住在您的商机列表',
        confirmText: '锁住商机',
        success: function(res){
          if (res.confirm) {
            let onSuccess = function () {
              that.setData({
                bizopp: bizopp
              })
            }
            bizoppJS.lockBizopp(bizopp, onSuccess)
          }
        }
      })
    }else{
      wx.showModal({
        title: '等级不够，无法锁住商机',
        content: '体验分销商无法锁住商机，升级分销商等级，锁住商机，独家拥有',
        showCancel: false,
        confirmText: '知道了'
      })
    }
  },
  onTapAddTrackRecordBtn:function(){
    wx.navigateTo({
      url: 'trackRecord/trackRecord?bizoppId='+this.data.bizopp.id,
    })
  },
  onTapRemoveTrackRecordBtn(e) {
    let that = this;
    var recordId = e.currentTarget.dataset.recordid;

    wx.showModal({
      title: '删除根据记录',
      content: '您确定要删除该条根据记录吗？',
      confirmText:'删除',
      success: function(res){
        if (res.confirm) {
          rq({
            url: baseURL + 'bizopp/record/' + that.data.bizoppId + '/' + recordId,
            method: 'DELETE',
            showLoding: true,
            success: function (res) {
              wx.showToast({
                title: '删除成功',
              });
              // 进行移除
              let trackRecords = that.data.bizopp.trackRecords;
              for (var i = 0; i < trackRecords.length; i++){
                if (trackRecords[i].id == recordId){
                  trackRecords.splice(i, 1);
                  that.setData({
                    bizopp: that.data.bizopp
                  })
                  break;
                }
              }
            }
          })
        }
      }
    })
  },
})
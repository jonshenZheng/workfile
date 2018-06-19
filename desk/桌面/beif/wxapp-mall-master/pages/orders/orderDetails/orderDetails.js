let app = getApp(),
  rq = app.bzRequest,
  baseRqUrl = app.globalData.svr,
  commJS = require("../../common/common.js"),
  orderJS = require("../orders.js");

Page({

  /**
   * 页面的初始数据
   */
  data: {
    id: null,
    order: null,
    baseImgUrl: app.globalData.baseImgUrl,
  },

  onLoad: function (options) {
    this.setData({
      id: options.id
    });
    orderJS.injectConstants(this)
    commJS.injectData(this, options)
  },

  onReady: function () {
    this.requestOrderDetail();
  },

  /**
   * 在onShow的时候假如在global里存在updateVisitorOrder数据
   * 那么就把这块数据局部更新过来，这种方式的目的在于:减少一次因为需要刷新页面订单详情导致的服务器请求，
   * 通过把在其它页面的修改买家订单状态的信息同步过来,同时不必担心请求订单详情时导致的脏数据可能
   */
  onShow: function () {
    let tmpData = app.tmpData;
    if (tmpData.updateVisitorOrder) {
      this.data.order.visitOrderStatus = tmpData.updateVisitorOrder.status;
      this.data.order.visitOrderStatusName = tmpData.updateVisitorOrder.statusName;
      this.data.order.discountedPrice = tmpData.updateVisitorOrder.discountedPrice;
      this.setData({
        order: this.data.order
      })
      delete tmpData.updateVisitorOrder;
    }
  },

  requestOrderDetail: function () {
    let that = this,
      data = this.data;
    rq({
      url: baseRqUrl + 'order/detail/' + this.data.id,
      showLoading: true,
      success: function (res) {
        let order = res.data.data;
        orderJS.dealWithOrders([order]);
        order.finalFactoryPrice = order.totalFactoryPrice;
        
        order.couponInfo = order.couponInfo?order.couponInfo: '未使用优惠券';
        that.setData({ order: order });

        // 查询优惠券  这里默认role数据已经注入
        if (data.role == data.ROLE_DISTRIBUTOR 
          && data.order.orderStatus == data.ORDER_STATUS_TO_BE_SUBMIT) {
          let prodIdCountPairs = that.getProdIdCountPairs();
          
          rq({
            url: baseRqUrl + 'coupon/available',
            method: 'POST',
            data: {
              shopId: data.shop.shopId,
              produceInfos: prodIdCountPairs
            },
            showLoading: true,
            success: function (res) {
              let coupons = res.data.data.coupons
              that.data.availableCoupons = [];
              that.data.unavailableCoupons = [];
              for (var i = 0; i < coupons.length; i++) {
                let coupon = coupons[i]
                if (coupon.available)
                  that.data.availableCoupons.push(coupon);
                else
                  that.data.unavailableCoupons.push(coupon);
              }
              that.setData({
                availableCoupons: that.data.availableCoupons,
                unavailableCoupons: that.data.unavailableCoupons
              })

              that.clearOrderCouponInfo();
            }
          })
        }
      }
    })
  },

  getProdIdCountPairs:function(){
    let prodIdCountPairs = [];
    let order = this.data.order
    for (var i = 0; i < order.items.length; i++) {
      let prod = order.items[i];
      prodIdCountPairs.push({
        skuId: prod.skuId,
        count: prod.count
      })
    }
    return prodIdCountPairs
  },
  /**
   * 点击更新游客订单状态按钮
   */
  onTapUpdateVisitorOrderStatusBtn: function () {
    let id = this.data.id;

    //这里设置全局的tmpData用来传递信息
    getApp().tmpData.updateVisitorOrder = {
      id: id,
      originPrice: this.data.order.origPrice,
      status: this.data.order.visitOrderStatus,
      discountedPrice: this.data.order.discountedPrice,
      statusName: this.data.order.visitOrderStatusName,
    }

    wx.navigateTo({
      url: 'updateVisitorOrder/updateVisitorOrder'
      + '?id=' + id
      + '&originPrice=' + this.data.order.origPrice
      + '&status=' + this.data.order.visitOrderStatus
      + '&discountedPrice=' + this.data.order.discountedPrice,
    })
  },
  /**
   * 点击联系客服按钮
   */
  onTapContactKFBtn: function () {
    let servicePhone = getApp().globalData.phoneNumKf;
    if (this.data.role != this.data.ROLE_DISTRIBUTOR)
      servicePhone = this.data.order.servicePhone;
    wx.makePhoneCall({
      phoneNumber: servicePhone,
    })
  },
  /**
   * 点击联系客户按钮
   */
  onTapContactClientBtn: function () {
    wx.makePhoneCall({
      phoneNumber: this.data.order.phone,
    })
  },
  /**
   * 点击提交到白泽按钮
   */
  onTapSubmitOrder2BzBtn: function () {
    let that = this;
    let data = {
      orderId: that.data.order.id,
    }
    if(this.data.curCoupon){
      data.couponId = this.data.curCoupon.id
    }

    wx.showModal({
      title: '您确定要提交订单吗？',
      content: '建议您和下单客户联系并确认过订单后提交。提交后，我们将在1个工作日内联系您。',
      confirmText: '确认提交',
      success: function (res) {
        if (res.confirm) {
          rq({
            url: baseRqUrl + 'order/status/commit',
            data: data,
            method: 'PUT',
            success: function () {
              that.requestOrderDetail();
              wx.showToast({
                title: '提交成功',
                icon: 'success',
                duration: 1500
              })
            }
          })
        } 
      }
    })
  },
  /**
   * 点击删除订单按钮
   */
  onTapDeleteOrderBtn: function () {
    let that = this;
    wx.showModal({
      title: '提示',
      content: '确认取消该订单？',
      success: function (res) {
        if (res.confirm) {
          rq({
            url: baseRqUrl + 'order/status/delete/' + that.data.order.id,
            method: 'PUT',
            success: function () {
              wx.showLoading({
                title: '取消成功',
                icon: 'none'
              })
              setTimeout(wx.navigateBack, 500);
            }
          })
        }
      }
    })
  },
  /**
   * 点击确认收货按钮
   */
  onTapConfirmReceiptBtn: function () {
    let that = this;

    wx.showModal({
      title: '提示',
      content: '这是一个模态弹窗',
      success: function (res) {
        if (res.confirm) {
          rq({
            url: baseRqUrl + 'order/status/finish/' + that.data.order.id,
            method: 'PUT',
            showLoading: true,
            success: function () {
              that.requestOrderDetail();
              wx.showToast({
                title: '已确认收货',
                icon: 'success',
                duration: 2000
              })
            }
          })
        } 
      }
    })
  },
  /**
   * 点击查看物流按钮
   */
  onTapViewLogisticsBtn: function () {
    console.log('查看物流')
    rq({
      url: baseRqUrl + 'order/logistics/' + this.data.order.id,
      success: function (res) {
        let data = res.data.data;
        wx.showModal({
          title: data.logisticsCompany,
          content: '物流单号：' + data.logisticsCode,
          showCancel: false,
          complete: function () {
            wx.setClipboardData(data.logisticsCod);
            wx.showToast({
              title: '已复制物流单号到剪切板',
              icon: 'none'
            })
          }
        })
      }
    })
  },
  /**
   * 点击选择优惠券按钮
   */
  onTapChooseCouponBtn: function () {
    let data = this.data;
    if (data.role == data.ROLE_DISTRIBUTOR && data.order.orderStatus == data.ORDER_STATUS_TO_BE_SUBMIT) {
      console.log('显示可用优惠券')
      this.setData({
        showCoupon: true
      })
    }
  },
  onSelectCoupon: function (e) {
    let that = this,
      coupon = e.detail.selectedCoupon,
      order = this.data.order;

    if (!coupon || !coupon.available) {//未进行选择
      order.finalFactoryPrice = order.totalFactoryPrice;
      this.setData({
        order: order,
        curCoupon: null
      });
      this.clearOrderCouponInfo();
    } else {
      rq({
        url: baseRqUrl + 'coupon/calculate',
        method: 'POST',
        data: {
          shopId: this.data.shop.shopId,
          orderId: order.id,
          couponId: coupon.id
        },
        success: function (res) {
          if (res.data.data.result) {//成功使用
            that.setData({
              curCoupon: coupon,
            })
            order.finalFactoryPrice = res.data.data.price;
            order.couponInfo = res.data.data.couponInfo;
            that.setData({
              order:order
            })
          }
        }
      })
    }
  },
  clearOrderCouponInfo:function(){
    let data = this.data,
      order = this.data.order,
      availableCoupons = this.data.availableCoupons,
      unavailableCoupons = this.data.unavailableCoupons;

    if (data.role == data.ROLE_DISTRIBUTOR
      && order.orderType == data.ORDER_TYPE_VISITOR
      && data.order.orderStatus == data.ORDER_STATUS_TO_BE_SUBMIT){
      if (availableCoupons.length > 0)
        order.couponInfo = '有' + availableCoupons.length+'张优惠券可用'
      else
        order.couponInfo = '无可用优惠券'

      this.setData({
        order: order,
        curCoupon: null
      })
    }
  }
})
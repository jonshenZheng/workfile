// pages/orders/orderdetails/updateVisitorOrder/updateVisitorOrder.js
let app = getApp(),
  rq = app.bzRequest,
  baseRqUrl = app.globalData.svr,
  commJS = require("../../../common/common.js");

Page({

  /**
   * 页面的初始数据
   */
  data: {
    id: null,
    originPrice: 0,
    statusOptions:[
      {
        value: 1,
        text: '待付款'
      },
      {
        value: 5,
        text: '待收货'
      }
    ]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({
      id: options.id,
      originPrice: options.originPrice,
      status: options.status,
      discountedPrice: options.discountedPrice,
    });
    this.oldValue = options;
  },

  onTapStatusOption: function(e){
    let status = e.currentTarget.dataset.status;
    this.setData({
      status: status
    })
  },
  onInputDiscountedPrice: function(e){
    this.setData({
      discountedPrice: e.detail.value
    })
  },
  onUnload:function(){
    let data={
      id: this.data.id,
      status: this.data.status,
      discount: parseInt(this.data.discountedPrice)
    }

    // 数据没有更改直接return
    if(data.status == this.oldValue.status 
      && data.discount == this.oldValue.discountedPrice)
      return

    // 设置全局的tmpData用来反向传递信息，以便前一界面使用
    let info = getApp().tmpData.updateVisitorOrder;
    info.status= data.status;
    info.discountedPrice = data.discount;
    switch (info.status){
      case 1:
        info.statusName = '待付款'
        break;
      case 5:
        info.statusName = '待收货'
        break;
    }

    rq({
      url: baseRqUrl + 'order/visit',
      data: data,
      method: 'PUT',
      success: function(res){
        wx.showToast({
          title: '修改买家订单状态成功',
          icon: 'none',
          duration: 2000
        })
      }
    })
  }
})
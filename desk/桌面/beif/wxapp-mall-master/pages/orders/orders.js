// page/component/orders/orders.js

let app = getApp(),
  rq = app.bzRequest,
  baseRqUrl = app.globalData.svr,
  commJS = require("../common/common.js");

Page({
  data: {
    btnff: '',
    orders: [],
    tabs: [],
    baseImgUrl: app.globalData.baseImgUrl,
    curTabIndex: -1, //当前选中的tab的索引
  },
  onLoad: function (o) {
    injectConstants(this)
    commJS.injectData(this, o);
  },
  onShow: function () {
    if (this.expiredOrderData) {// 当存在过期的订单数据的时候，执行一次请求单一订单数据
      this.updateSingleOrder(this.expiredOrderData.id);
    }
  },

  onDataInjected: function () {
    let data = this.data;
    // 不同角色显示不同标签栏
    if (this.data.role == this.data.ROLE_DISTRIBUTOR) {
      this.setData({
        tabs: [
          {
            code: data.ORDER_STATUS_ALL,
            text: "全部"
          },
          {
            code: data.ORDER_STATUS_TO_BE_SUBMIT,
            text: "待提交"
          },
          {
            code: data.ORDER_STATUS_TO_BE_PAID,
            text: "待付款"
          },
          {
            code: data.ORDER_STATUS_TO_BE_RECEIPT,
            text: "待发货"
          },
          {
            code: data.ORDER_STATUS_TO_BE_FINISHED,
            text: "已完成"
          }
        ]
      });
    } else {
      this.setData({
        tabs: [
          {
            code: data.ORDER_STATUS_ALL,
            text: "全部"
          },
          {
            code: data.ORDER_STATUS_TO_BE_PAID,
            text: "待付款"
          },
          {
            code: data.ORDER_STATUS_TO_BE_RECEIPT,
            text: "待收货"
          },
          {
            code: data.ORDER_STATUS_TO_BE_FINISHED,
            text: "已完成"
          }
        ]
      });
    }
    this.switchTab(0)
  },
  // /**
  //  * 页面相关事件处理函数--监听用户下拉动作
  //  */
  // onPullDownRefresh: function () {

  // },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    if(this.data.noMoreOrders)
      return
    let tabs = this.data.tabs;
    let orderStatus = this.data.tabs[this.data.curTabIndex].code
    this.requestOrders(orderStatus)
  },
  /**
   * 请求某一订单状态下的订单列表
   */
  requestOrders: function (orderStatus) {
    let self = this;

    let url = baseRqUrl;
    url = url + 'order/' + orderStatus;
    url = url + '?pageSize=5&startRow=' + this.data.orders.length

    rq({
      url: url,
      withoutToken: false,
      showLoading: true,
      success: function (r) {
        let curOrders = self.data.orders;
        let moreOrders = r.data.data;
        self.dealWithOrders(r.data.data);        

        //还有更多的订单
        if (moreOrders.length > 0) {
          // 移除掉moreOrders里根curOrders里重叠的部分
          if (curOrders.length > 0)
            for (var i = 0; i < moreOrders.length; i++) {
              let order = moreOrders[i];
              if (order.id == curOrders[curOrders.length - 1].id) {
                moreOrders.splice(0, i + 1)
                break;
              }
            }
          curOrders = curOrders.concat(moreOrders) ;// moreOrders跟orders做一个去重的合并
          self.setData({
            orders: curOrders
          });
        }else{
          self.setData({
            noMoreOrders: true //没有更多的订单了
          })
        }
      }
    })
  },
  /**
   * 更新单个订单
   */
  updateSingleOrder: function (id) {
    let that = this;
    rq({
      url: baseRqUrl + 'order/detail/' + id,
      showLoading: true,
      success: function (res) {
        let order = res.data.data;
        that.dealWithOrders([order]);
        for(var i =0; that.data.orders.length; i++){
          let o = that.data.orders[i];
          if(o.id == order.id){
            if (order.orderStatus == that.data.ORDER_STATUS_DELETED)
              that.data.orders.splice(i, 1)//删除
            else
              that.data.orders[i] = order;
            that.setData({
              orders:that.data.orders
            })
            break;
          }
        }
      }
    })
  },
  onTapTab: function (e) {
    let index = e.currentTarget.dataset.index;
    if (index == this.data.curTabIndex)//点击当前tab
      return;
    this.switchTab(index);
  },
  switchTab: function (index) {
    this.setData({ curTabIndex: index });
    let tabs = this.data.tabs;
    this.setData({
      orders: [],//清空订单
      noMoreOrders: false//重置
    })
    this.requestOrders(tabs[index].code);
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
    let arr = this.data.orders,
      oind = e.currentTarget.dataset.oind,
      ind = e.currentTarget.dataset.imgind;

    if (e.detail.errMsg.indexOf('noPic.png') === -1) {
      arr[oind].items[ind].icon = '../../image/noPic.png';
      this.setData({
        orders: arr
      })
    }
  },
  dealWithOrders: dealWithOrders,
  showStatusDetailFn: function (e) {
    let ind = e.currentTarget.dataset.ind,
      arr = this.data.orders,
      isShow = arr[ind].statusDetail.isShow,
      self = this;

    if (isShow) {
      arr[ind].statusDetail.isShow = false;
      this.setData({
        orders: arr
      })
    }
    else {

      arr[ind].statusDetail.isShow = true;
      rq({
        url: baseRqUrl + 'orderStatus/' + arr[ind].id,
        withoutToken: false,
        success: function (r) {

          arr[ind].statusDetail.info = r.data.data;
          self.setData({
            orders: arr
          })
        }
      });
    }
  },
  connkf: function () {
    wx.showModal({
      content: '是否拨打客服热线',
      success: function (res) {
        if (res.confirm) {
          wx.makePhoneCall({
            phoneNumber: app.globalData.phoneNumKf,
          })
        }
      }
    })
  },
  /**
   * 点击订单视图，跑去显示订单详情
   */
  onTapOrderView: function (e) {
    let that = this;
    let idx = e.currentTarget.dataset.idx;
    let order = this.data.orders[idx];
    wx.navigateTo({
      url: './orderDetails/orderDetails?id=' + order.id,
      success: function () {
        order.browse = true;
        that.setData({
          orders: that.data.orders
        });
        that.expiredOrderData = order;//记录订单为数据过期
      }
    })

  },
})
/**
 * 处理下订单数据
 */
function dealWithOrders(arr) {
  if (!arr.length) {
    return;
  }

  let i = arr.length,
    itm,
    itm_i;

  for (; i--;) {
    //订单类型
    switch (arr[i].orderType) {
      case 1:
        arr[i].type = "游客订单";
        break;
      case 5:
        arr[i].type = "采购订单";
        break;
    }

    //显示状态详情
    arr[i]['statusDetail'] = {};
    arr[i]['statusDetail']['isShow'] = false;
    arr[i]['statusDetail']['info'] = [];

    //处理图片路径
    itm = arr[i].items;
    itm_i = itm.length;
    if (itm_i < 1) {
      continue;
    }
  }
}

/**
 * 往页面中注入常量
 */
function injectConstants(page) {
  page.setData({
    ORDER_TYPE_VISITOR: 1,
    ORDER_TYPE_PURCHASE: 5,

    ORDER_STATUS_ALL: 100,//全部
    ORDER_STATUS_DELETED: 99,//已删除
    ORDER_STATUS_TO_BE_SUBMIT: 0,//待提交
    ORDER_STATUS_TO_BE_PAID: 1,//待付款
    ORDER_STATUS_TO_BE_RECEIPT: 5,//待收货
    ORDER_STATUS_TO_BE_FINISHED: 15,//已完成
  })
}
module.exports = {
  dealWithOrders: dealWithOrders,
  injectConstants: injectConstants
}
let app = getApp(),
  rq = app.bzRequest,
  commJS = require("../common/common.js"),
  baseImgUrl = app.globalData.baseImgUrl,
  pageBeforeLoadRun = app.pageBeforeLoadRun,
  baseURL = app.globalData.svr;

// pages/placeorder/placeorder.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    products: [],
    address: null,
    count: 0,
    totalPrice: 0,
    finalPrice: 0,//实收
    totalFactoryPrice: 0,
    finalFactoryPrice: 0,//实收
    curCoupon: null,//选中的优惠券
    availableCoupons:[],//可用的优惠券
    unavailableCoupons: [],//不可用的优惠券    
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    pageBeforeLoadRun(this);  
    let self = this;

    let tempCount = 0,
      price = 0,
      factoryPrice = 0,
      i = 0,
      orderProducts = app.tmpData.orderProducts,
      len = app.tmpData.orderProducts.length;

    //是否为立即购买 假如为立即购买则后续调用的下单api不一样
    if (options.instantPurchase)
      this.isInstantPurchase= true;

    //统计家具件数和总价
    for (; i < len; i++) {
      let count = orderProducts[i].count;
      tempCount += count;
      price += count * orderProducts[i].price;
      if (orderProducts[i].factoryPrice)//理论上假如是游客，这个值是undefined
        factoryPrice += count * orderProducts[i].factoryPrice;
    }

    this.setData({
      products: orderProducts,
      count: tempCount,
      totalPrice: price,
      finalPrice: price,
      totalFactoryPrice: factoryPrice,
      finalFactoryPrice: factoryPrice,
      address: wx.getStorageSync("RECEIVE_ADDRESS") // 上一次地址--读缓存
    });

    commJS.injectData(this);
  },
  onShow: function () {
      if (this.isgotoLocationPage) {
          this.initAddress()
          delete this.isgotoLocationPage
      }
  },
  onDataInjected: function () {
    let that = this;
    // 查询可用的优惠券 当为分销商时
    if (this.data.role == this.data.ROLE_DISTRIBUTOR){
      let prodIdCountPairs = this.getProdIdCountPairs();
      rq({
        url: baseURL + 'coupon/available',
        method: 'POST',
        data: {
          shopId: this.data.shop.shopId,
          produceInfos: prodIdCountPairs
        },
        showLoading: true,
        success: function (res) {
          let coupons = res.data.data.coupons
          
          for(var i = 0; i < coupons.length; i++){
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
        }
      })
    }
  },
  /**
   * 获得订单里商品id-count对
   */
  getProdIdCountPairs:function(){
    let prodIdCountPairs = [];
    for (var i = 0; i < this.data.products.length; i++) {
      let prod = this.data.products[i];
      prodIdCountPairs.push({
        skuId: prod.skuId,
        count: prod.count
      })
    }
    return prodIdCountPairs
  },
  /**
   * 当点击选择地址按钮
   */
  onTapChooseAddressBtn: function () {
      let self = this;
      this.isgotoLocationPage = true;
      wx.navigateTo({
          url: '../addrList/addrList',
      });
  },
  initAddress: function () {
      let addressList = wx.getStorageSync('ADDRESS_LIST');
      if (addressList) {
          for (var i = 0; i < addressList.length; i++) {
              if (addressList[i].isSelect) {
                  this.setAddress(addressList[i])
                  break
              }
          }
      }
  },
  /**
   * 设置地址，保存到page.data中，同时进行cache
   * @param data格式为从小程序內建的获取用户地址功能拿到的数据格式
   */
  setAddress: function (data) {
    console.log(data)
    let address = {
      cityName: data.cityName,
      countyName: data.countyName,
      detailInfo: data.detailInfo,
      nationalCode: data.nationalCode,
      postalCode: data.postalCode,
      provinceName: data.provinceName,
      phone: data.telNumber,
      linkman: data.userName
    };
    this.setData({ address: address });
    wx.setStorageSync("RECEIVE_ADDRESS", address)
  },
  /**
   * 检查订单是否合法
   * 也即是phone linkman provinceName等数据均不为空
   */
  isAddressValid: function () {
    let address = this.data.address;
    if (!address) {
      wx.showToast({
        title: '请填写收货地址',
        icon: 'none'
      })
      return false;
    }

    if (!address.phone || !address.linkman || !address.provinceName
      || !address.cityName || !address.countyName || !address.detailInfo || !address.postalCode)
      return false;

    return true;
  },
  /**
   * 点击选择优惠券按钮
   */
  onTapChooseCouponBtn: function () {
    this.setData({
      showCoupon: true
    })
  },

  /**
   * 优惠券选择
   * 目前只支持使用一张优惠券
   * 目前只限分销商使用
   */
  onSelectCoupon: function (e){
    let that = this;

    let coupon = e.detail.selectedCoupon;

    if (!coupon || !coupon.available){//未进行选择
      this.setData({
        curCoupon: null,
        savedMoney: 0,
        finalPrice: this.data.totalPrice,
      })
      if (that.data.role == that.data.ROLE_DISTRIBUTOR) {
        that.setData({
          finalFactoryPrice: that.data.totalFactoryPrice,
        })
      }
    }else{
      let prodIdCountPairs = this.getProdIdCountPairs();
      rq({
        url: baseURL + 'coupon/calculate',
        method: 'POST',
        data: {
          shopId: this.data.shopOfView.shopId,
          produceInfos: prodIdCountPairs,
          couponId: coupon.id
        },
        success: function(res){
          console.log(res)
          if(res.data.data.result){//成功使用
            that.setData({
              curCoupon: coupon,
            })
            if(that.data.role == that.data.ROLE_DISTRIBUTOR){
              that.setData({
                finalFactoryPrice: res.data.data.price,
                savedMoney: that.data.totalFactoryPrice - res.data.data.price
              })
            }else{
              that.setData({
                finalPrice: res.data.data.price,
                savedMoney: that.data.totalPrice - res.data.data.price
              })
            }
          }
          else{
              wx.showToast({
                  title: res.data.data.failMsg,
                  icon : 'none'
              });
          }
        }
      })    
    }
  },
  /**
   * 下单
   */
  submitOrder: function (e) {
    if (!this.isAddressValid())
      return;

    let that = this;

    var url, data;
    if (this.isInstantPurchase) {
      url = baseURL + 'order/buySoon';
      let product = this.data.products[0];//立即购买只支持单一商品
      data = {
          'wxServiceNoticeFormId': e.detail.formId,
        'pid': product.prodId,
        'skuId': product.skuId,
        'address': this.data.address,
        'shopId': this.data.shopOfView.shopId,
        'count': product.count
      }
    } else {
      url = baseURL + 'order';

      let cartItemIds = [];
      let products = this.data.products;
      for (let i = 0; i < products.length; i++) {
        cartItemIds.push(products[i].id);
      }
      if (cartItemIds.length == 0)
        return;
      console.log(cartItemIds);
      data = {
        'cartIds': cartItemIds,
        'address': this.data.address,
        'shopId': this.data.shopOfView.shopId
      }
    }
    if(this.data.curCoupon)
      data.couponId = this.data.curCoupon.id

    rq({
      url: url,
      method: 'post',
      withoutToken: false,
      data: data,
      showLoading: true,
      errorcb: function (r) {
      },
      success: function (r) {

        let servicePhone = r.data.data.servicePhone;
        // 页面跳转
        wx.redirectTo({
          url: '../buySuccess/buySuccess?servicePhone=' + servicePhone,
        })

      }
    })
  }
})
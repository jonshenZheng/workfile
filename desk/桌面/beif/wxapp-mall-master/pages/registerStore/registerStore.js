let app = getApp(),
  rq = app.bzRequest,
  baseRqUrl = app.globalData.svr,
  common = require("../common/common.js");

Page({
  data: {
    getCodeText: 0,
    hideInp: false,
    registryData: {},
  },
  onLoad(options) {
    common.injectData(this, options);
  },
  onDataInjected: function (opt) {
    let that = this;
    if (this.data.role == this.data.ROLE_DISTRIBUTOR) {
      if (this.data.distributorInfo.level == this.data.DIST_LV_ON_TRAIL)// 当且仅当试用期的经销商
        rq({
          url: baseRqUrl + 'shop/info',
          method: 'GET',
          success: function (res) {
            let registryData = res.data.data;
            registryData.ratio = registryData.discount;
            that.setData({
              registryData: registryData
            })
          }
        })
      else
        wx.reLaunch({
          url: '../user/user',
        })
    }
  },
  onInputShopName: function (e) {
    let registryData = this.data.registryData;
    let shopName = e.detail.value;
    //shopName = shopName.trim();
    if (shopName.length > 20)//小于20个字符
      shopName = shopName.substr(0, 20)
    registryData.shopName = shopName;
    this.setData({
      registryData: registryData
    });
  },
  onInputDistributorName: function (e) {
    let registryData = this.data.registryData;
    let distributorName = e.detail.value;
    distributorName = distributorName.trim();
    if (distributorName.length > 20)//小于20个字符
      distributorName = distributorName.substr(0, 20)
    registryData.distributorName = distributorName;
    this.setData({
      registryData: registryData
    });
  },
  onInputPhone: function (e) {
    let registryData = this.data.registryData;
    let phone = e.detail.value;
    phone = phone.trim();
    if (phone.length > 11)//小于11个字符
      phone = phone.substr(0, 11)
    registryData.phone = phone;
    this.setData({
      registryData: registryData
    });
  },
  getCaptcha: function () {
    let that = this;
    let registryData = this.data.registryData;
    let phone = registryData.phone;
    if (!phone) {
      wx.showToast({
        title: '请填写手机号码',
        icon: 'none'
      });
      return;
    }

    if (!common.formCheck.isPhone(phone)) {
      wx.showToast({
        title: '手机号格式不对',
        icon: 'none'
      });
      return;
    }

    let url = baseRqUrl + 'shop/captcha/' + phone;
    rq({
      url: url,
      fail: function () {
        wx.showToast({
          title: '发送失败',
        });
      },
      success: function () {
        that.setData({ getCodeText: '60s' });

        let timer = setInterval(function () {
          let text = that.data.getCodeText,
            cd = parseInt(text),
            t;
          cd = cd - 1;

          if (cd < 1) {
            t = cd;
            clearInterval(timer);
          }
          else {
            t = cd + 's';
          }

          that.setData({ getCodeText: t });
        }, 1000);
      }
    });
  },
  onInputCaptcha: function (e) {
    let registryData = this.data.registryData;
    let captcha = e.detail.value;
    captcha = captcha.trim();
    if (captcha.length > 20)//小于20个字符
      captcha = captcha.substr(0, 20)
    registryData.captcha = captcha;
    this.setData({
      registryData: registryData
    });
  },
  onRegionChange: function (e) {
    let registryData = this.data.registryData;
    registryData.province = e.detail.value[0];
    registryData.city = e.detail.value[1];
    registryData.county = e.detail.value[2];
    this.setData({
      registryData: registryData,
    })
  },
  onInputRatio: function (e) {
    let registryData = this.data.registryData;
    let ratio = e.detail.value;
    if (ratio > 10000)
      ratio = 10000
    registryData.ratio = ratio;
    this.setData({
      registryData: registryData
    });
  },
  onInputPassword: function (e) {
    let registryData = this.data.registryData;
    let pwd = e.detail.value;
    pwd = pwd.trim();
    if (pwd.length > 16)//小于16个字符
      pwd = pwd.substr(0, 16)
    if (e.target.dataset.type == '1')
      registryData.pwd = pwd;
    else
      registryData.pwd2 = pwd;
    this.setData({
      registryData: registryData
    });
  },
  validateData: function () {
    let registryData = this.data.registryData;
    if (!registryData.shopName) {
      wx.showToast({
        title: '店铺名不能为空',
        icon: 'none'
      })
      return false;
    }
    registryData.shopName = registryData.shopName.trim()

    if (!registryData.distributorName) {
      wx.showToast({
        title: '姓名不能为空',
        icon: 'none'
      })
      return false;
    }

    if (!registryData.phone) {
      wx.showToast({
        title: '手机号不能为空',
        icon: 'none'
      })
      return false;
    }

    if (!common.formCheck.isPhone(registryData.phone)) {
      wx.showToast({
        title: '手机号格式不对',
        icon: 'none'
      });
      return false;
    }

    if (!registryData.captcha) {
      wx.showToast({
        title: '请输入验证码',
        icon: 'none'
      })
      return false;
    }

    if (!registryData.province || !registryData.city || !registryData.county) {
      wx.showToast({
        title: '请选择城市',
        icon: 'none'
      })
      return false;
    }

    if (!registryData.ratio) {
      wx.showToast({
        title: '请设置比例',
        icon: 'none'
      })
      return false;
    }

    if (registryData.ratio <= 100) {
      wx.showToast({
        title: '比例需大于100',
        icon: 'none'
      })
      return false;
    }

    if (!registryData.pwd) {
      wx.showToast({
        title: '请输入密码',
        icon: 'none'
      })
      return false;
    }

    let pwdlen = registryData.pwd.length
    if (pwdlen < 6 || pwdlen > 16) {
      wx.showToast({
        title: '密码长度错误',
        icon: 'none'
      })
      return false;
    }
    if (!registryData.pwd2) {
      wx.showToast({
        title: '请输入确认密码',
        icon: 'none'
      })
      return false;
    }

    if (registryData.pwd !== registryData.pwd2) {
      wx.showToast({
        title: '密码不一致',
        icon: 'none'
      })
      return false;
    }

    return true;
  },
  onTapOpenShopBtn: function (e) {
    let that = this;
    let isFormal = e.target.dataset.formal == '1';
    let data = this.data.registryData;
    data.discount = data.ratio;
    if (!this.validateData()) {
      return;
    }

    var tik = 0;
    let queryOpenFormalShopSuccess = function (shopId) {//需要一直查询是否开店成功
      rq({
        url: baseRqUrl + 'shop/formal',
        method: 'PUT',
        showLoding: true,
        success: function (res) {
          let success = res.data.data;
          if (success)
            that.onRegisterSuccess(isFormal);
          else {
            if (tik > 600)
              wx.showToast({
                title: '请联系客服',
                icon: 'none'
              })
            else {
              tik++;
              setTimeout(() => {
                queryOpenFormalShopSuccess(shopId);
              }, tik < 10 ? 1000 : 5000)
            }
          }
        }
      })
    }

    // 这里的业务逻辑是：
    // 1) 不管是不是试用，先给用户整成试用分销商，
    // 2) 再判断用户是想试用还是成为正式，正式则继续发起微信支付
    // 3) 正式->如果微信支付被取消，那么跳转成为临时分销商
    // 4）总是会跳转到user页面，同时刷新信息
    rq({
      url: baseRqUrl + 'shop/openShop',
      method: 'POST',
      data: data,
      success: function (res1) {
        let shopId = res1.data.data.shopId;
        if (!isFormal) {
          that.onRegisterSuccess(isFormal);//试用则直接跳转
        } else {//正式则发起微信支付
          rq({
            url: baseRqUrl + 'distri/pay',
            success: function (res2) {
              let paymentData = res2.data.data;
              console.log(paymentData)
              wx.requestPayment({
                'timeStamp': paymentData.timeStamp,
                'nonceStr': paymentData.nonceStr,
                'package': paymentData.package,
                'signType': paymentData.signType,
                'paySign': paymentData.sign,
                success: function () {
                  wx.showToast({
                    title: '支付成功',
                    icon: 'none'
                  });
                  setTimeout(() => {
                    wx.showLoading();
                    queryOpenFormalShopSuccess(shopId);
                  }, 1000);
                },
                fail: function () {
                  wx.showToast({
                    title: '支付失败',
                    icon: 'none'
                  });
                  that.onRegisterSuccess(false);
                }
              })
            }

          })
        }
      },
      errorcb: function (r) {
        wx.showToast({
          title: r.data.meta.msg,
          icon: 'none'
        });
      }
    })
  },
  onRegisterSuccess: function (isFormal) {
    wx.showToast({
      title: (isFormal ? '' : '试用') + '店铺注册成功',
      icon: 'none'
    });
    setTimeout(
      () => {
        wx.showLoading({
          title: '正在跳转到店铺',
        });
        getApp().login(() => {
          wx.reLaunch({
            url: '../user/user',
          })// 直接relaunch 防止任何意外
        });//需要重新再登录一遍
      }
      , 500);
  }
})
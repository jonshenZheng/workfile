// page/component/new-pages/user/user.js
let app = getApp(),
  rq = app.bzRequest,
  baseURL = app.globalData.svr,
  backUrl,
  backUrlWay;
Page({
    data:{
        agreeProtocol : true,
        disabled: true,
        iSdisabled: 'disabled',
        phoneNum : '',
        codeNum : '',
        appName : app.globalData.appName,
        getCodeCD : 0,
    },
    onLoad : function(parm){
        backUrl = parm.backUrl;
        backUrlWay = parm.backWay;
    },
    getPhoneNumber: function (e) {
        console.log(e.detail.errMsg)
        console.log(e.detail.iv)
        console.log(e.detail.encryptedData)
    }, 
    getCode : function(){        
        let that = this;
        if (!this.data.phoneNum){
            wx.showModal({
                title: '提示',
                content: '请输入手机号',
                success: function (res) {
                    if (res.confirm) {
                        //console.log('用户点击确定')
                    } else if (res.cancel) {
                        //console.log('用户点击取消')
                    }
                }
            })
            return;
        }

        if (!this.checkPhoneFn(this.data.phoneNum)) {
            return;
        }
        
        this.setData({
            disabled: false,
            iSdisabled : ''
        })

        rq({
            url: baseURL+'captcha/' + this.data.phoneNum,
            withoutToken: false,
            success:function(res){
              if (res.statusCode != 200)
                return;
              that.setData({ getCodeCD:60});
              var handler = setInterval(function(){
                let cd = that.data.getCodeCD;
                cd = cd - 1;
                that.setData({ getCodeCD: cd });
                if(cd < 1)
                  clearInterval(handler);
              }, 1000)
            }
        });
    },
    checkPhoneFn : function(v){
        if (!this.checkPhone(this.data.phoneNum)) {
            wx.showModal({
                content: '请输入正确的手机号',
                showCancel : false,
            })

            return false;
        }

        return true;
    },
    checkPhone : function(v){
        return /^1(3\d|47|(5[0-3|5-9])|(7[0|7|8])|(8[0-3|5-9]))-?\d{4}-?\d{4}$/.test(v);
    },
    getPhone : function(e){
        let v = e.detail.value;
        this.setData({
            phoneNum : v
        })
    },
    inputCodeNum : function(e){
        this.setData({
            codeNum: e.detail.value
        })
    },
    agreeProtocolFn : function(){
        
        let isSel = this.data.agreeProtocol;
        if (isSel){
            isSel = false;
        }
        else{
            isSel = true;
        }

        this.setData({
            agreeProtocol: isSel
        })
    },
    login : function(){        
        if (!this.data.phoneNum){
            wx.showModal({
                content: '请输入手机号',
                showCancel : false
            })
            return;
        }
        if (!this.checkPhoneFn(this.data.phoneNum)) {
            return;
        }

        if (!this.data.codeNum){
            wx.showModal({
                content: '请输入验证码',
                showCancel : false
            })
            return;
        }


        if (!this.data.agreeProtocol){
            wx.showModal({
                content: '请同意协议',
                showCancel : false 
            })
            return;
        }

        rq({
            method : 'put',
            withoutToken: false,
            url: getApp().globalData.svr+'captcha/'+this.data.phoneNum+'/'+this.data.codeNum,
            success : function(r){               
                const needRegPhoneNumKey = getApp().globalData.needRegPhoneNumKey;
                wx.setStorageSync(needRegPhoneNumKey, false);
                wx.showToast({
                    title: '注册成功',
                    mask:true
                });
                setTimeout(function () {

                    //backUrlWay 值有0，1，2，分别代表 wx.navigateTo  wx.switchTab,2代表webview 暂时不做
                    
                    if (!backUrl){
                        backUrl = '../index/index';
                        backUrlWay = 1;
                    }

                    switch (backUrlWay) {
                        case '0': wx.navigateTo({
                            url: backUrl,
                        });
                            break;
                        case '1': wx.switchTab({
                            url: backUrl,
                        });
                            break;
                        case '2':
                            break;
                        default: wx.navigateTo({
                            url: backUrl,
                        });
                    }

                    //wx.navigateBack();
                }, 1000);
                 
            },
            errorcb : function(e){
                wx.showToast({
                    title: e.data.meta.msg || '注册失败',
                    icon: 'none'
                })
            },
            fail : function(){
                wx.showToast({
                    title: '注册失败',
                    icon : 'none'
                })
            }
        })        
    }
})
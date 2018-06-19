// page/component/sereach/sereach.jslet 
let app = getApp(),
    rq = app.bzRequest,
    commJs = require('../common/common.js'),
    baseURL = app.globalData.svr,
    packageId = '';
Page({

    data: {
        showpanCtInd: '',
        showpanCt: [
            { isshow: '' },
            { isshow: '' }
        ],
        baseImgUrl: getApp().globalData.baseImgUrl,
        packageName: '',
        goodsList: []
    },
    onimgfail: function (e) {

        let arr = this.data.goodsList,
            self = this;

        commJs.loadimgfail(arr, e, 'goodsList', 'path', self);

    },
    onLoad: function (e) {
        console.log(e);
        let that = this;
        packageId = e.id;
        rq({
          url: baseURL + 'package/' + packageId,
            success: function (res) {
                
                commJs.checkImgExist(res.data.data.produces,'path');

                that.setData({
                    packageName: res.data.data.groupName,
                    goodsList: res.data.data.produces
                });
                wx.setNavigationBarTitle({
                    title: res.data.data.groupName,
                });
                
            }
        });
    },
    onShareAppMessage: function () {
      return {
        title: '[有人@我] 这套 "' + this.data.packageName +'" 简直太棒了!',
        path: '/pages/package/package?id=' + packageId,
        success: function (res) {
          // 转发成功
        },
        fail: function (res) {
          // 转发失败
        }
      }
    },
    formSubmitFn2: function (e) {
        let arr = this.data.category,
            arr_ind = this.data.curIndex,
            fid = arr[arr_ind].fid,
            towLveInd = arr[arr_ind]['detail']['towlevel']['sel_ind'];

        if (e.detail.value.minPriceV || e.detail.value.minPriceV === '0' || e.detail.value.maxPriceV || e.detail.value.maxPriceV === '0') {
            if ((!e.detail.value.minPriceV && e.detail.value.minPriceV !== '0') && (!e.detail.value.maxPriceV && e.detail.value.maxPriceV !== '0')) {
                wx.showModal({
                    title: '提示',
                    content: '搜索内容不能为空',
                });
                return;
            }

            if (towLveInd || towLveInd === 0) {
                arr[arr_ind].detail.towlevel.sel_ind = '';
                arr[arr_ind].detail.towlevel.list[towLveInd].isSel = '';
            }

            this.getProdData(fid, '', '', '', e.detail.value.minPriceV, e.detail.value.maxPriceV, 1, arr, arr_ind)
        }
        else {

            if ((!e.detail.value.lengthV && e.detail.value.lengthV !== '0') && (!e.detail.value.widthV && e.detail.value.widthV !== '0') && (!e.detail.value.heightV && e.detail.value.heightV !== '0')) {
                wx.showModal({
                    title: '提示',
                    content: '搜索内容不能为空',
                });
                return;
            }

            if (towLveInd || towLveInd === 0) {
                arr[arr_ind].detail.towlevel.sel_ind = '';
                arr[arr_ind].detail.towlevel.list[towLveInd].isSel = '';
            }

            this.getProdData(fid, e.detail.value.lengthV, e.detail.value.widthV, e.detail.value.heightV, '', '', 1, arr, arr_ind)
        }

        this.hidepanFn();

    },
    hidepanFn: function () {

        let arr = this.data.showpanCt;
        arr[this.data.showpanCtInd].isshow = '';

        this.setData({
            showpanCtInd: '',
            showpanCt: arr
        });

    },
    showpanFn: function (e) {

        let ind = e.currentTarget.dataset.ind,
            arr = this.data.showpanCt,
            temp,
            len = arr.length;

        for (; len--;) {
            if (len != ind) {
                arr[len].isshow = '';
            }
            else {
                if (arr[ind].isshow == 'show') {
                    arr[ind].isshow = '';
                    temp = '';
                }
                else {
                    arr[ind].isshow = 'show';
                    temp = ind;
                }
            }
        }

        this.setData({
            showpanCtInd: temp,
            showpanCt: arr
        });

    },

})
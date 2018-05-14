let app = getApp(),
    rq = app.bzRequest,
    baseUrl = app.globalData.svr,
    commJS = require("../common/common.js"),
    start_x,
    config = {
        pageSize: 8,
    };
Page({
    data: {
        isSelALL: '',
        totalMoney: 0,
        baseImgUrl: app.globalData.baseImgUrl,
        selNum: 0,
        coloData: []
    },
    tstart : function(e){
        start_x = e.changedTouches[0].clientX;
    },
    tend : function (e) {
        
        let arr = this.data.coloData,
            wid = e.changedTouches[0].clientX - start_x,
            ind = e.currentTarget.dataset.ind;
    
        if (wid<-20){
            arr[ind].isShowDel = 'show';
        }
        else if (wid > 20){
            arr[ind].isShowDel = '';
        }
        
        this.setData({
            coloData: arr
        });


    },

    onimgfail: function (e) {
        let arr = this.data.coloData,
            self = this;

        commJS.loadimgfail(arr, e, 'coloData', 'icon', self);
    },
    dealwithCollection: function (arr) {

        if (!arr.length) {
            return
        }

        let i = arr.length;

        for (; i--;) {
            arr[i]['isSel'] = false;
            arr[i]['isShowDel'] = false;
        }

    },

    onReady() {

        //commJS.isRegister('../collection/collection', 0);

        let self = this;

        rq({
            url: baseUrl + 'collection',
            withoutToken: false,
            success: function (r) {

                let data = r.data.data;

                self.dealwithCollection(data);
                
                commJS.checkImgExist(data,'icon');

                self.setData({
                    coloData: data
                })

            }

        })


    },
    onShow: function () {

    },
    delItemFn: function (e) {

        let ind = e.currentTarget.dataset.ind,
            arr = this.data.coloData,
            isShow = arr[ind].isShowDel;

        if (isShow == 'show') {
            arr[ind].isShowDel = '';
        }
        else {
            arr[ind].isShowDel = 'show';
        }

        this.setData({
            coloData: arr
        })

    },
    delDataItemFn: function (e) {

        let ind = e.currentTarget.dataset.ind,
            arr = this.data.coloData,
            self = this,
            collInd = arr[ind].id;

        function delFail() {
            wx.showToast({
                title: '删除失败',
            });
        }

        rq({
            method: 'delete',
            withoutToken: false,
            url: baseUrl + 'collection/' + collInd,
            success: function (r) {
                if (r.data.meta.code == 200) {
                    arr.splice(ind, 1);

                    self.setData({
                        coloData: arr
                    })

                    self.contMoney();
                }
                else {
                    delFail();
                }
            },
            fail: function () {
                delFail();
            }
        })

    },

    contMoney: function () {

        let arr = this.data.coloData,
            i = arr.length,
            total = 0,
            cNum = 0;

        if (i < 1) {
            return
        }

        for (; i--;) {
            if (arr[i].isSel == 'on') {
                total += arr[i].price;
                cNum++;
            }
        }

        this.setData({
            totalMoney: total,
            selNum: cNum,
        })

    },
    selOneFn: function (e) {
        let ind = e.currentTarget.dataset.ind,
            arr = this.data.coloData,
            i = arr.length,
            isSel = arr[ind].isSel,
            isSelAllV = 'on';

        if (isSel == 'on') {
            arr[ind].isSel = '';
        }
        else {
            arr[ind].isSel = 'on';
        }

        if (i < 1) {
            return;
        }
        for (; i--;) {
            if (arr[i].isSel !== 'on') {
                isSelAllV = '';
                break;
            }
        }

        this.setData({
            isSelALL: isSelAllV,
            coloData: arr
        })

        this.contMoney();

    },

    selAllFn: function () {

        let arr = this.data.coloData,
            isSelAll = this.data.isSelALL,
            i = arr.length;

        if (i < 1) {
            return;
        }

        if (isSelAll == 'on') {
            isSelAll = '';
            for (; i--;) {
                arr[i].isSel = '';
            }
        }
        else {
            isSelAll = 'on';
            for (; i--;) {
                arr[i].isSel = 'on';
            }
        }

        this.setData({
            isSelALL: isSelAll,
            coloData: arr
        });

        this.contMoney();

    },
    addCartFn: function () {

    }

})
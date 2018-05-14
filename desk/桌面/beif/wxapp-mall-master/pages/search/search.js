// page/component/sereach/sereach.js
let app = getApp(),
  rq = app.bzRequest,
  baseURL = app.globalData.svr,
  commJs = require('../common/common.js'),
  sentdata,
  pageSize = 15;

Page({
 
    data: {
        showpanCtInd: '',
        showpanCt: [
            { isshow: '' },
            { isshow: '' }
        ],
        minPrice : '',
        maxPrice : '',
        minPrice_befor: '',
        maxPrice_befor: '',

        length : '',
        width : '',
        height: '',
        length_befor: '',
        width_befor: '',
        height_befor: '',

        oldSereachForm : {},
        baseImgUrl: getApp().globalData.baseImgUrl,
        goodsList:[],

    },
    dealwithGoodsList : function(arr){
        arr['hasMore'] = arr.prodIntros.length < pageSize ? false : true;
        arr['startPage'] = 0;
    },
    onimgfail : function(e){

        let arr = this.data.goodsList,
            ind = e.currentTarget.dataset.imgind;

        if (e.detail.errMsg.indexOf('noPic.png') === -1) {
            arr.prodIntros[ind].path = '../../image/noPic.png';
            this.setData({
                goodsList: arr
            })
        }
    },
    sortPrice: function (e) {
        let ind = e.currentTarget.dataset.ind,
            val = e.detail.value,
            maxP = this.data.maxPrice,
            minP = this.data.minPrice,
            temp;

        if (ind === '0') {
            minP = val;
        }
        else {
            maxP = val;
        }

        if (maxP !== '' && minP !== '') {
            if (Number(minP) > Number(maxP)) {
                temp = minP;
                minP = maxP;
                maxP = temp;
            }
        }

        this.setData({
            maxPrice: maxP,
            minPrice: minP
        })

    },
    onLoad:function(e){

        sentdata = { keyWords: app.globalData.searchResultId, width: '', depth: '', Heigth: '', minMoney: '', maxMoney: '', 'from': 0, 'size' : pageSize };
        
      let searchResult= app.globalData.searchResult;
      if (!searchResult.prodIntros){
          return
      }
      this.dealwithGoodsList(searchResult);
        
      commJs.checkImgExist(searchResult.prodIntros,'path');
      this.setData({
          goodsList: searchResult,
      });

    },
    formSubmitFn2: function (e) {
        
        let arr = this.data.goodsList;
            
        if (e.detail.value.minPriceV || e.detail.value.minPriceV === '0' || e.detail.value.maxPriceV || e.detail.value.maxPriceV === '0') {

            this.setData({
                minPrice: e.detail.value.minPriceV,
                maxPrice: e.detail.value.maxPriceV,
                minPrice_befor: e.detail.value.minPriceV,
                maxPrice_befor: e.detail.value.maxPriceV,
            });

            sentdata['minMoney'] = e.detail.value.minPriceV;
            sentdata['maxMoney'] = e.detail.value.maxPriceV;
            sentdata['from'] = 0;

            this.getProdData(arr, '');
        }
        else {

            this.setData({
                length: e.detail.value.lengthV,
                width: e.detail.value.widthV,
                height: e.detail.value.heightV,
                length_befor: e.detail.value.lengthV,
                width_befor: e.detail.value.widthV,
                height_befor: e.detail.value.heightV,
            });

            sentdata['width'] = e.detail.value.lengthV;
            sentdata['depth'] = e.detail.value.widthV;
            sentdata['Heigth'] = e.detail.value.heightV;
            sentdata['form'] = 0;
            
            this.getProdData( arr, '');
        }

        this.hidepanFn();

    },
    hidepanFn: function (e) {
        
        let arr = this.data.showpanCt;
        arr[this.data.showpanCtInd].isshow = '';

        if (e) {

            let isPrice = e.currentTarget.dataset.cansle == '1' ? true : false;

            if (isPrice) {

                this.setData({
                    maxPrice: this.data.maxPrice_befor,
                    minPrice: this.data.minPrice_befor,
                    showpanCtInd: '',
                    showpanCt: arr
                });

            }
            else {
                this.setData({
                    length: this.data.length_befor,
                    width: this.data.width_befor,
                    height: this.data.height_befor,
                    showpanCtInd: '',
                    showpanCt: arr
                });
            }

        }
        else{
            this.setData({
                showpanCtInd: '',
                showpanCt: arr
            });
        }

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
    upload: function () {
    
        let self = this,
            arr = this.data.goodsList,
            hasMore = arr.hasMore,
            oldProd,
            sPage = sentdata.startPage,
            cbFn;

        if (!hasMore) {
            return;
        }

        oldProd = [].concat(arr.prodIntros);

        cbFn = function (oldForm) {

            if (arr.prodIntros){
                arr.prodIntros = oldProd.concat(arr.prodIntros);
            }

            self.setData({
                goodsList: arr
            })
        }

        sentdata['startPage'] = sPage + 1;

        this.getProdData( arr, '', cbFn);

    },
    getProdData: function (arr, arr_ind, cbFn) {

        let self = this;
        debugger
        rq({
            url: baseURL + 'keyword/search',
            data: sentdata,
            header: { 'content-type': 'application/json' },
            method: 'POST',
            showLoading: true,
            errorcb: function () {
                setTimeout(function () {
                    wx.showToast({
                        title: '搜索失败',
                        icon: 'none'
                    });

                }, 100);

            },
            success: function (pdimg) {
                debugger
                if (!pdimg.data.data.prodIntros) {
                    arr.hasMore = false;
                    arr.prodIntros = [];
                }
                else {

                    let pdarr = pdimg.data.data.prodIntros;

                    if (pdarr.length < pageSize) {
                        arr.hasMore = false;
                    }
                    else {
                        arr.hasMore = true;
                    }

                    commJs.checkImgExist(pdarr, 'path');
                    arr.prodIntros = [].concat(pdarr);

                }

                if (typeof cbFn === 'function') {
                    cbFn();
                }
                else {

                    self.setData({
                        goodsList: arr
                    })
                }

            },
            complete: function () {
                wx.hideLoading();
            }
        })

    },
    /*重置规格*/
    resetSize: function (e) {

        this.setData({
            length: '',
            width : '',
            height : '',
            length_befor: '',
            width_befor: '',
            height_befor: '',
        });
    }
   
})
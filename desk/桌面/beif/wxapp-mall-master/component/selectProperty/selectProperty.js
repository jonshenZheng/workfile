let app = getApp(),
    rq = app.bzRequest,
    baseURL = app.globalData.svr,
    pageBeforeLoadRun = app.pageBeforeLoadRun,
    commJS = require("../../pages/common/common.js");

Component({
    properties: {
        goodsSelection : {
            type : Object,
            value : {}
        },
        goodsDetail : {
            type: Object,
            value : {}
        },
        bHideSelectView : {
            type : Boolean,
            value : true,
        },
        shopofview : {
            type : Object,
            value: {}
        },
        prodid : {
            type:String,
            value : ''
        },
        btnfirstname : {
            type:String,
            value : ''
        },
        btnsecondname : {
            type : String,
            value : ''
        },
        btnfirstfn : {
            type: Function,
            value:function(){}
        },
        btnsecondfn : {
            type : Function,
            value : function(){}
        },
        hideNum: {
            type: Boolean,
            value: false,
        },

    },
    data: {
        ROLE_DISTRIBUTOR: commJS.ROLE_DISTRIBUTOR,
        baseURL : getApp().globalData.svr,
        isRangePrice: false,
        showMaxPrice: 0,
        showMinPrice: 0,
        showMaxFactoryPrice: 0,
        showMinFactoryPrice: 0,
        selectedPropertyStr : '',
        purchaseQuantity: 1,//用户设置的购买数量,每点一次加入购车,就会放入bHideSelectView个商品
        minPurchaseQuantity: 1,
        maxPurchaseQuantity: 999,
        btnff: '',
        //bHideSelectView: true,//是否显示选择的view
    },
    attached : function(){
        pageBeforeLoadRun(this);
    },

    ready : function(){
      commJS.injectData(this)
    },

    methods: {
        /**
         * 规格选择弹出框隐藏
        */
        hideSelectView: function () {
            this.setData({
                //isShowPop: false,
                bHideSelectView: true
            })

            this.triggerEvent('closeproperty');
        },
        showSelectView : function(){
            this.setData({
                bHideSelectView: false
            })
        },
        onimgfail: function (e) {

            let objName = e.currentTarget.dataset.objname,
                ind = e.currentTarget.dataset.imgind,
                arr = this.data.goodsDetail;

            switch (objName) {
                case 'pics': if (e.detail.errMsg.indexOf('noPic.png') === -1) {
                    arr.pics[ind] = '../../image/noPic.png';
                }
                    break;
                case 'icon': if (e.detail.errMsg.indexOf('noPic.png') === -1) {
                    arr.basicInfo.icon = '../../image/noPic.png';
                }
                    break;
            }

            this.setData({
                goodsDetail: arr
            });

        },
        /**
   * 选择商品规格
   * @param {Object} e
   */
        selectGoods: function (e) {
            var that = this;
            var properties = that.data.goodsSelection.properties;
            const propertyIndex = e.currentTarget.dataset.propertyIndex;
            const propertyValueIndex = e.currentTarget.dataset.propertyValueIndex;
            const propertyDisabled = e.currentTarget.dataset.propertyDisabled;

            //首先属性应该是可选的,不可选则直接返回
            if (propertyDisabled) {
                console.log('propertyDisabled');
                return;
            }

            // 取消该属性下的所有值的选中状态+设置当前选中状态
            let prevStatus = properties[propertyIndex].values[propertyValueIndex].selected
            var childs = properties[propertyIndex].values;
            for (var i = 0; i < childs.length; i++) {
                properties[propertyIndex].values[i].selected = false;
            }
            properties[propertyIndex].values[propertyValueIndex].selected = !prevStatus;

            // 检查当下的选择
            var checkRes = this.checkSelection();
            let selectedPropertyStr = checkRes.selectedPropertyStr;
            let selectedPropertyIndexs = checkRes.selectedPropertyIndexs;

            let selectedPropertyIndexs2 = selectedPropertyIndexs.slice(),
                selectedPI_v = 0,
                selectedPI_i = 0,
                priceRangeObj,
                selectedPI_len = selectedPropertyIndexs.length;

            for (; selectedPI_i < selectedPI_len; selectedPI_i++) {
                selectedPI_v += selectedPropertyIndexs2[selectedPI_i];
                if (selectedPropertyIndexs2[selectedPI_i] == -1) {
                    selectedPropertyIndexs2[selectedPI_i] = '\\d';
                }
            }


            // 重新计算disable
            let compositions = this.data.goodsSelection.composition;
            let maxPrice = 0,
                minPrice = compositions[0].price;

            //当第i个属性未确定,其余均取当前选择的结果,那么看第i个属性所有的值有哪些是存在于组合的
            for (var i = 0; i < selectedPropertyIndexs.length; i++) {
                let tmpCompProp = selectedPropertyIndexs.slice(0);
                // 将未选中项替换为对应的正则\\d+
                for (var j = 0; j < tmpCompProp.length; j++) {
                    if (j != i && tmpCompProp[j] == -1)
                        tmpCompProp[j] = '\\d+';
                }
                // 遍历第i个属性的所有取值
                let propValue = properties[i].values;
                for (var j = 0; j < propValue.length; j++) {
                    tmpCompProp[i] = j;//第i个属性取第j个值
                    var exp = new RegExp('^' + tmpCompProp.toString() + "$");//生成对应的正则
                    let disabled = true;
                    for (var k = 0; k < compositions.length; k++) {
                        let compProp = compositions[k].properties;
                        let meet = exp.test(compProp.toString());//判断

                        if (meet) {
                            disabled = false;
                            break;
                        }
                    };
                    propValue[j].disabled = disabled;
                }
            }

            let kefuMsg = '产品名：' + this.data.goodsDetail.basicInfo.name + '规格：' + selectedPropertyStr;

            priceRangeObj = this.getPriceRange(selectedPropertyIndexs2, compositions);

            if (checkRes.skuId) {
                // 更新选择
                that.setData({
                    goodsSelection: that.data.goodsSelection,
                    selectedPropertyStr: selectedPropertyStr,
                    sendkefuMsg: kefuMsg,
                    isRangePrice: false,
                    showMaxPrice: 0,
                    showMinPrice: 0,
                    showMaxFactoryPrice: 0,
                    showMinFactoryPrice: 0,
                });
            }
            else {
                // 更新选择
                that.setData({
                    goodsSelection: that.data.goodsSelection,
                    selectedPropertyStr: selectedPropertyStr,
                    sendkefuMsg: kefuMsg,
                    isRangePrice: true,
                    showMaxPrice: priceRangeObj.maxPrice,
                    showMinPrice: priceRangeObj.minPrice,
                    showMaxFactoryPrice: priceRangeObj.maxFactoryPrice,
                    showMinFactoryPrice: priceRangeObj.minFactoryPrice,
                });
            }

            

            console.log(this.data.btnObj);

            // 更新商品详情
            var skuId = checkRes.skuId;
            if (skuId) {
                
                var url = this.data.baseURL + 'produce/skudetail/' + this.properties.shopofview.shopId + '/' + this.properties.prodid + '/' + skuId;

                wx.showLoading()
                rq({
                    url: url,
                    header: { "with-selection": "false" },
                    success: function (r) {
                        if (!r.data.data.goodsDetail.pics.length) {
                            r.data.data.goodsDetail.pics[0] = '';
                        }
                        commJS.checkImgExist(r.data.data.goodsDetail.pics);
                        r.data.data.goodsDetail.basicInfo.icon = commJS.checkImgExist(r.data.data.goodsDetail.basicInfo.icon);
                        that.setData({
                            goodsDetail: r.data.data.goodsDetail,
                        });

                        let data = {};
                        data.purchaseQuantity = that.data.purchaseQuantity;
                        data.selectedPropertyStr = selectedPropertyStr;
                        data.goodsDetail = that.data.goodsDetail;
                        data.goodsSelection = that.data.goodsSelection;
                        that.triggerEvent('updatedata', data);


                    },
                    complete: function () {
                        wx.hideLoading();
                    }
                })

            }
            else{
                let data = {};
                data.purchaseQuantity = this.data.purchaseQuantity;
                data.selectedPropertyStr = selectedPropertyStr;
                data.goodsDetail = this.data.goodsDetail;
                data.goodsSelection = this.data.goodsSelection;
                this.triggerEvent('updatedata', data);
            }
        },

        /**
   * 检查当前的选择是否合法
   * 注意!!!这个方法会更新selectedPropertyStr
   * 返回skuid,空串则非法
   */
        checkSelection: function () {
            // 获取所有的选中规格尺寸数据
            var properties = this.data.goodsSelection.properties
            var needSelectNum = properties.length;
            var curSelectNum = 0;
            var selectedPropertyIndexs = [];
            var selectedPropertyStr = "";
            for (var i = 0; i < properties.length; i++) {
                var childs = properties[i].values;
                var s = false;
                for (var j = 0; j < childs.length; j++) {
                    if (childs[j].selected) {
                        curSelectNum++;
                        s = true;
                        selectedPropertyIndexs.push(j);
                        // selectedPropertyStr = selectedPropertyStr + properties[i].name + ":" + childs[j].name + "  ";
                        selectedPropertyStr = selectedPropertyStr + childs[j].name + "，";
                    }
                }
                if (!s)
                    selectedPropertyIndexs.push(-1);
            }
            if (selectedPropertyStr.endsWith("，"))
                selectedPropertyStr = selectedPropertyStr.substr(0, selectedPropertyStr.length - 1)

            var skuId = '';
            if (needSelectNum == curSelectNum) {
                let comp = this.data.goodsSelection.composition;
                for (var i = 0; i < comp.length; i++) {
                    let value = comp[i];
                    if (value.properties.toString() == selectedPropertyIndexs.toString()) {
                        skuId = value.id;
                        break;
                    }
                };
            }

            let kefuMsg = '产品名：' + this.data.goodsDetail.basicInfo.name + '规格：' + selectedPropertyStr;

            this.setData({
                selectedPropertyStr: selectedPropertyStr,
                sendkefuMsg: kefuMsg
            });

            return {
                "skuId": skuId,
                "selectedPropertyIndexs": selectedPropertyIndexs,
                "selectedPropertyStr": selectedPropertyStr,
            };
        },
        /**
   * 增加购买数目
   */
        onTapIncrOrDecrQuantityBtn: function (e) {
            let incr = e.currentTarget.dataset.increasement
            var currentQuantity = this.data.purchaseQuantity;
            this.changeQuantity(currentQuantity + Number(incr));
        },
        onInputQuantity: function (e) {

            let val = Number(e.detail.value);
            this.changeQuantity(val);
        },
        changeQuantity: function (val) {
            let min = this.data.minPurchaseQuantity,
                max = this.data.maxPurchaseQuantity;

            if (val < min) {
                val = min;
            }
            else if (val > max) {
                val = max;
            }

            this.setData({
                purchaseQuantity: val
            })

            let data = {};
            data.purchaseQuantity = this.data.purchaseQuantity;
            data.selectedPropertyStr = this.data.selectedPropertyStr;
            data.goodsDetail = this.data.goodsDetail;
            data.goodsSelection = this.data.goodsSelection;
            this.triggerEvent('updatedata', data);

        },
        getPriceRange: function (selectedPropertyIndexs2, compositions) {

            let exp2 = new RegExp('^' + selectedPropertyIndexs2.toString() + "$");
            let i = 0,
                maxPrice = 0,
                minPrice = 0,
                maxFactoryPrice = 0,
                minFactoryPrice = 0,
                isfirst = true,
                len = compositions.length,
                compProp;

            for (; i < len; i++) {

                compProp = compositions[i].properties;

                if (exp2.test(compProp.toString())) {
                    if (isfirst) {
                        isfirst = false;
                        maxPrice = compositions[i].price;
                        minPrice = compositions[i].price;
                        maxFactoryPrice = compositions[i].factoryPrice;
                        minFactoryPrice = compositions[i].factoryPrice;
                        continue;
                    }
                    if (compositions[i].price > maxPrice) {
                        maxPrice = compositions[i].price;
                    }

                    if (compositions[i].price < minPrice) {
                        minPrice = compositions[i].price;
                    }

                    if (compositions[i].factoryPrice > maxFactoryPrice) {
                        maxFactoryPrice = compositions[i].factoryPrice;
                    }

                    if (compositions[i].factoryPrice < minFactoryPrice) {
                        minFactoryPrice = compositions[i].factoryPrice;
                    }

                }

            }

            return {
                minPrice: minPrice,
                maxPrice: maxPrice,
                maxFactoryPrice: maxFactoryPrice,
                minFactoryPrice: minFactoryPrice,
            }


        },
        getProdInfo : function(){
            let data = {},
                res = this.checkSelection();
            data.skuid = res.skuId;
            data.num = this.data.purchaseQuantity;
            data.basicInfo = this.data.goodsDetail.basicInfo;
            data.thisCase = this;
            return data;
        },
        btn1Fn : function(e){
            let data = this.getProdInfo();
            //data.id = this.data.goodsDetail.basicInfo.id;
            //data.num = this.data.purchaseQuantity;
            this.triggerEvent('firstfn', data);
        },
        btn2Fn : function(e){
            let data = this.getProdInfo();
            this.triggerEvent('secondfn', data);
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

    }
});

 

Component({
    properties: {
        coupons : {
            type : Array,
            value:[]
        },
        isMulti : {
            type : Boolean,
            value : false
        },
        showCoupon:{
          type: Boolean,
          value: false
        }
    },
    data : {
        COUPON_STATUS_NOTHAVE: 0,//未领用
        COUPON_STATUS_HAVE: 1,//持有
        COUPON_STATUS_USED: 2,//已使用
        COUPON_STATUS_EXPIRED: 5,//过期
        COUPON_STATUS_CANCELD: 9,//作废
    },
    methods: {
        showCouponPop: function () {
            this.setData({
                showCoupon: true
            })
        },
        hideCouponPop: function () {
            this.setData({
                showCoupon: false
            })
        },
        selectFn : function (e) {
          let coupons = this.data.coupons,
            len = coupons.length,
                i = 0,
                ind = e.currentTarget.dataset.ind,
                isMulti = this.properties.isMulti;

            if (!isMulti) {//单选 把其余选项置否
                for (; i < len; i++) {
                  if (i == ind && coupons[i].available) {
                      coupons[i].isSelect = !coupons[i].isSelect;
                    }
                    else {
                      coupons[i].isSelect = false;
                    }
                }
            }
            else {//多选
                for (; i < len; i++) {
                  if (i == ind && coupons[i].available) {
                      coupons[i].isSelect = !coupons[i].isSelect;
                    }
                }
            }

            this.setData({
              coupons: coupons
            })

            this.confirmSelection();
        },
        confirmSelection : function(e){
            let myEventDetail = {};
            let coupons = this.data.coupons;

            myEventDetail.coupons = coupons;
            for (var i = 0; i < coupons.length; i++) {
              if (coupons[i].isSelect) {
                myEventDetail.selectedCoupon = coupons[i];
                break;
              }
            }
            myEventDetail.handle = this;

            this.triggerEvent('selectcoupon', myEventDetail);
        }     
    }
});

 
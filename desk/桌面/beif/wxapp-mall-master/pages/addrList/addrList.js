
let isEdit = false,
    Editind,
    common = require("../common/common.js");;
const ADDRESS_LIST = 'ADDRESS_LIST';

Page({

    /**
     * 页面的初始数据
     */
    data: {
        addAddr : false,
        addrList : [],
        AddrInfo:{
            isSelect: false,
            cityName: '',
            countyName: '',
            detailInfo: '',
            nationalCode: '',
            postalCode: '',
            provinceName: '',
            telNumber: '',
            userName: ''
        }
    },

    /**
     * 生命周期函数--监听页面加载
     */
    onLoad: function (options) {
        
        let addrList = wx.getStorageSync(ADDRESS_LIST);

        addrList = addrList ? addrList : [];

        this.setData({
            addrList: addrList
        });

    },
    editAddr : function(e){
        let ind = e.currentTarget.dataset.ind;
        isEdit = true;
        Editind = ind;
        this.setData({
            AddrInfo: this.data.addrList[ind],
            addAddr : true
        });
    },

    onRegionChange: function (e) {
        let registryData = this.data.AddrInfo;
        registryData.provinceName = e.detail.value[0];
        registryData.cityName = e.detail.value[1];
        registryData.countyName = e.detail.value[2];
        this.setData({
            AddrInfo: registryData,
        })
    },

    onInputDistributorName: function (e) {
        let registryData = this.data.AddrInfo;
        let distributorName = e.detail.value;
        distributorName = distributorName.trim();
        if (distributorName.length > 20)//小于20个字符
            distributorName = distributorName.substr(0, 20)
        registryData.userName = distributorName;
        this.setData({
            AddrInfo: registryData
        });
    },
    onInputPhone: function (e) {
        let registryData = this.data.AddrInfo;
        let phone = e.detail.value;
        phone = phone.trim();
        if (phone.length > 11)//小于11个字符
            phone = phone.substr(0, 11)
        registryData.telNumber = phone;
        this.setData({
            AddrInfo: registryData
        });
    },

    onInputpostalCode : function(e) {
        let registryData = this.data.AddrInfo;
        let postalCode = e.detail.value;
        postalCode = postalCode.trim();
        registryData.postalCode = postalCode;
        this.setData({
            AddrInfo: registryData
        });
    },
    onInputDetailed_addr : function(e){
        let registryData = this.data.AddrInfo;
        let det = e.detail.value;
        det = det.trim();
        registryData.detailInfo = det;
        this.setData({
            AddrInfo: registryData
        });
    },

    submitFn : function(){
        if (!this.checkInfo()){
            return;
        }

        let addrList = this.data.addrList,
            len = addrList.length,
            i = 0,
            AddrInfo = this.data.AddrInfo;

        for(;i<len;i++){
            addrList[i].isSelect = false;
        }

        AddrInfo.isSelect = true;

        if (isEdit){
            this.data.addrList[Editind] = this.data.AddrInfo;
            this.setData({
                addrList: this.data.addrList
            });
        }
        else{
            this.data.addrList.unshift(this.data.AddrInfo);
            this.setData({
                addrList: this.data.addrList
            });
        }

        wx.setStorageSync(ADDRESS_LIST, this.data.addrList);
        wx.showLoading({
            title: '',
            mask: true,
        });
        setTimeout(function(){
            wx.hideLoading();
            wx.navigateBack({
            });
        },200);

    },

    resetSelInd : function(ind){
        let addrList = this.data.addrList,
            len = addrList.length,
            i = 0;

        for (; i < len; i++) {
            if (i === ind){
                addrList[i].isSelect = true;
            }
            else{
                addrList[i].isSelect = false;
            }
            
        }
    },

    selectAddr : function(e){
        let ind = e.currentTarget.dataset.ind;
        this.resetSelInd(ind);
        this.setData({
            addrList: this.data.addrList
        });
        wx.setStorageSync(ADDRESS_LIST, this.data.addrList);
        wx.showLoading({
            title: '',
            mask: true,
        })

        setTimeout(function () {
            wx.hideLoading();
            wx.navigateBack({
            });

        }, 200);

    },

    checkInfo : function(){

        let AddrInfo = this.data.AddrInfo;

        if (AddrInfo.userName == ''){
            wx:wx.showToast({
                title: '请填写姓名',
                icon: 'none',
            });
            return;
        }

        if (AddrInfo.telNumber == ''){
            wx: wx.showToast({
                title: '请填写手机',
                icon: 'none',
            });
            return;
        }

        if (!common.formCheck.isPhone(AddrInfo.telNumber)) {
            wx: wx.showToast({
                title: '手机号格式不对',
                icon: 'none',
            });
            return;
        }

        if (!AddrInfo.provinceName) {
            wx: wx.showToast({
                title: '请选择地区',
                icon: 'none',
            });
            return;
        }

        if (!AddrInfo.detailInfo) {
            wx: wx.showToast({
                title: '请填写详细地址',
                icon: 'none',
            });
            return;
        }

        if (!AddrInfo.postalCode) {
            wx: wx.showToast({
                title: '请填写邮政编码',
                icon: 'none',
            });
            return;
        }

        if (AddrInfo.postalCode.length < 6) {
            wx: wx.showToast({
                title: '邮政编码错误',
                icon: 'none',
            });
            return;
        }


        return true;

    },
    addAddrFn : function(){
        isEdit = false;
        let AddrInfo = {
        };

        this.setData({
            AddrInfo: AddrInfo,
            addAddr : true
        })

    },
    

    /**
     * 生命周期函数--监听页面初次渲染完成
     */
    onReady: function () {
        
    },

    /**
     * 生命周期函数--监听页面显示
     */
    onShow: function () {
        
    },

    /**
     * 生命周期函数--监听页面隐藏
     */
    onHide: function () {
        
    },

    /**
     * 生命周期函数--监听页面卸载
     */
    onUnload: function () {
        
    },

})
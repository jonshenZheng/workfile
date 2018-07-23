// pages/profitsetting/profitsetting.js
let app = getApp(),
  req = app.bzRequest,
  baseRqUrl = app.globalData.svr,
  pageBeforeLoadRun = app.pageBeforeLoadRun,
  common = require("../common/common.js"),
  TAB_ALL_ID = '0';
const MSG_SET_PROFIT_SUCCESS = '设置价格成功';
const MSG_SET_PROFIT_FAIL = '设置价格失败';

Page({

  /**
   * 页面的初始数据
   */
  data: {
    profitSettings: [],
    index1: -1,//第一层选中的类别索引  初始值-1
    modified: false, //记录是否更新了数据
    prevProfitSettingsLv1: []
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    pageBeforeLoadRun(this);  
    common.injectData(this, options);
  },
  onDataInjected: function (options) {
    let that = this;
    req({
      url: baseRqUrl + 'shop/shopPrice',
      success: function (res) {
        let profitSettings = res.data.data;
        // profitSettings.unshift({ name: "全部", priceRate: 115 }) //放入全部这个数据
        that.setData({
          profitSettings: profitSettings
        });
        
        //计算一个跳转到哪个页面
        let tabIdx = 0;
        if(options.categoryCode){
          for(let i =0;i < profitSettings.length; i++){
            if(common.isSameCategory(options.categoryCode, profitSettings[i].prodTypeCode)){
              tabIdx = i;
              break;
            }
          }
        }
        that.switchToTab(tabIdx);
      }
    })
  },

  onTapTab1: function (e) {
    let that = this;
    let index = e.currentTarget.dataset.index;
    if (index != this.data.index1) {
      if (this.data.modified) {
        wx.showModal({
          content: '您有未保存的价格设置，是否为您保存？',
          cancelText: '不保存',
          confirmText: '保存',
          success: function (res) {
            if (res.confirm) {
              console.log('用户点击确定')
              that.saveSettings({
                'rollback': true,
                'success': function () {
                  that.switchToTab(index);
                }
              });
            } else if (res.cancel) {
              console.log('用户点击取消')
              that.rollbackSettings();
              that.switchToTab(index);
            }
          }
        })
      } else {
        this.switchToTab(index);
      }
    }
  },
  switchToTab: function (index) {
    this.setData({
      index1: index,
      modified: false
    });

    // 缓存住先前的收益
    let profitSettingsLv1 = this.data.profitSettings[index];
    let prevProfitSettingsLv1 = []
    if (profitSettingsLv1.children) {
      for (var i = 0; i < profitSettingsLv1.children.length; i++) {
        prevProfitSettingsLv1.push(profitSettingsLv1.children[i].priceRate);
      }
      this.setData({
        prevProfitSettingsLv1: prevProfitSettingsLv1
      })
    }
  },

  onInputPorfitRatio: function (e) {
    let index1 = this.data.index1;
    let profitSettings = this.data.profitSettings;
    let settingsLv1 = profitSettings[index1];
    let curVale = parseFloat(e.detail.value);

    if (curVale > 10000)
      curVale = 10000
    if(curVale < 0)
      curVale = 100

    if (settingsLv1.id != TAB_ALL_ID) {//非全部项
      let index2 = e.target.dataset.index;
      let prevValue = profitSettings[this.data.index1].children[index2].priceRate;
      if (prevValue != curVale) {
        profitSettings[this.data.index1].children[index2].priceRate = curVale;
        this.setData({
          profitSettings: profitSettings,
          modified: true
        })
      }
    } else {//全部项
      profitSettings[0].priceRate = curVale;
      this.setData({
        profitSettings: profitSettings,
        modified: true
      })
    }
  },

  validateData: function(){
    let data = this.data
    let setting = data.profitSettings[data.index1];
    if (!data.modified && setting.id != TAB_ALL_ID){
      wx.showToast({
        title: '请先更改价格设置',
        icon:'none'
      })
      return false;
    }
    
    // 不能存在为空的价格设置
    if (setting.id == TAB_ALL_ID){
      if (!setting.priceRate) {
        wx.showToast({
          title: '价格设置不能为空',
          icon: 'none'
        })
        return false;
      }
    }else{
      for (var i = 0; i < setting.children.length; i++){
        if (!setting.children[i].priceRate) {
          wx.showToast({
            title: '价格设置不能为空',
            icon: 'none'
          })
          return false;
        }
      }
    }

    return true;
  },
  onTapSaveBtn: function (e) {
    // if (this.data.modified || this.data.profitSettings[this.data.index1].id == TAB_ALL_ID) {
    
    this.saveSettings();
  },
  rollbackSettings: function () {
    let that = this;
    let index1 = this.data.index1;
    let profitSettings = that.data.profitSettings;
    let settingsLv1 = that.data.profitSettings[index1];

    if (settingsLv1.id != TAB_ALL_ID) {
      let prev = that.data.prevProfitSettingsLv1;

      for (var i = 0; i < prev.length; i++)
        settingsLv1.children[i].priceRate = prev[i]
      that.setData({
        profitSettings: profitSettings
      })
    }
  },
  saveSettings: function (OBJECT) {
    if (!this.validateData()) 
      return;

    let that = this;
    let index1 = this.data.index1;
    let profitSettings = that.data.profitSettings;
    let settingsLv1 = that.data.profitSettings[index1];
    
    if (settingsLv1.id == TAB_ALL_ID) {
      let failCallback = function (res) {//失败-->toast
        wx.showToast({
          icon: 'none',
          title: MSG_SET_PROFIT_FAIL,
        })
      };
      req({
        url: baseRqUrl + 'shop/shopPrice/all',
        method: 'POST',
        data: {
          "priceRate": settingsLv1.priceRate
        },
        success: function (res) {//成功-->刷新所有的比例;设置modified;toast
          wx.showToast({
            title: MSG_SET_PROFIT_SUCCESS,
          })
          for (var i = 1; i < profitSettings.length; i++) {
            let settings1 = profitSettings[i];
            for (var j = 0; j < settings1.children.length; j++) {
              let settings2 = settings1.children[j];
              settings2.priceRate = settingsLv1.priceRate;
            }
          };
          that.setData({
            profitSettings: profitSettings,
            modified: false
          });
          if (OBJECT && OBJECT.success)
            OBJECT.success();
        },
        fail: failCallback,
        errorcb: failCallback
      })
    } else {
      let modification = [];
      let prev = that.data.prevProfitSettingsLv1;
      for (var i = 0; i < prev.length; i++) // 计算出修改项
        if (prev[i] != settingsLv1.children[i].priceRate)
          modification.push({
            'id': settingsLv1.children[i].id,
            'priceRate': settingsLv1.children[i].priceRate
          });
      if (modification.length == 0)
        return;

      console.log(modification)
      let failCallback = function (res) {//失败-->toast；【回滚】
        wx.showToast({
          icon: 'none',
          title: MSG_SET_PROFIT_FAIL,
        })
        if (OBJECT && OBJECT.rollback) {
          that.rollbackSettings();
        }
      };
      req({
        url: baseRqUrl + 'shop/shopPrice/multi',
        method: 'PUT',
        data: modification,
        success: function (res) {//成功-->设置modified;toast
          wx.showToast({
            title: MSG_SET_PROFIT_SUCCESS,
          });
          that.setData({
            modified: false
          });
          if (OBJECT && OBJECT.success)
            OBJECT.success();
        },
        fail: failCallback,
        errorcb: failCallback
      })
    }
  }
})
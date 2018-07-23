let app = getApp(),
  rq = app.bzRequest,
  baseURL = app.globalData.svr,
  pageBeforeLoadRun = app.pageBeforeLoadRun,
  imgBaseURL = app.globalData.baseImgUrl;

Page({

  /**
   * 页面的初始数据
   */
  data: {
    countWordNum: 0,
    isOver: false,
    wordMaxNum: 100,
    bizoppId: null,
    statusList: [{
      'code': 10,
      'name': '电话联系'
    }, {
      'code': 20,
      'name': '平面规划'
      }, {
        'code': 30,
      'name': '报价议价'
    }, {
      'code': 40,
      'name': '客户决策'
      }, {
        'code': 50,
      'name': '合同流程'
    }, {
      'code': 60,
      'name': '已签约'
      }, {
        'code': 0,
      'name': '无效'
    }],
    statusIndex: 0,
    trackRecord:{}
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {

    pageBeforeLoadRun(this);

    this.setData({
      bizoppId: options.bizoppId
    });
    this.setRecordStatus(0);
  },
  /**
   * picker更改
   */
  onPickerChange: function(e) {
    let statusIndex = parseInt(e.detail.value)
    this.setRecordStatus(statusIndex)
  },
  /**
   * 设置记录状态
   * 更新状态index;更新trackRecord里的title；更新trackRecord里的status
   */
  setRecordStatus: function (statusIndex) {
    this.setData({
      statusIndex: statusIndex
    })

    let status = this.data.statusList[statusIndex]
    this.data.trackRecord.title = '跟进记录-' + status.name;
    this.data.trackRecord.status = status.code;
    this.setData({
      trackRecord: this.data.trackRecord
    })
  },

  /**
   * 标题输入的响应函数
   */
  onInputTitle: function(e) {
    this.data.trackRecord.title = e.detail.value
  },

  /*统计输入正文的字数*/
  countTextAearNumFn: function (e) {
    let len = e.detail.value.length,
      isOver = false;

    if (len > this.data.wordMaxNum) {
      isOver = true;
    }

    this.setData({
      countWordNum: len,
      isOver: isOver
    });
  },
  /**
   * 正文输入的响应函数
   */
  onInputContent: function(e) {
    this.data.trackRecord.content = e.detail.value
    this.countTextAearNumFn(e)
  },
  /**
   * 点击保存按钮
   */
  onTapSaveBtn: function () {
    console.log(this.data.trackRecord)
    let trackRecord = this.data.trackRecord;
    if (!trackRecord.title || !trackRecord.title.trim()) {
      wx.showToast({
        title: '标题不能为空',
        icon: 'none'
      })
      return;
    } else if (this.data.countWordNum == 0){
      wx.showToast({
        title: '正文内容不能为空',
        icon: 'none'
      })
      return;
    } else if (this.data.isOver){
      wx.showToast({
        title: '正文内容超过' + this.data.wordMaxNum+'字',
        icon: 'none'
      })
      return;
    }
    trackRecord.title = trackRecord.title.trim()
    rq({
      url: baseURL + 'bizopp/record/'+this.data.bizoppId,
      data: this.data.trackRecord,
      method:'POST',
      success: function(res){
        wx.showToast({
          title: '保存成功',
          mask: true,
          duration: 1500
        });
        setTimeout(()=>{
          wx.navigateBack({})
        }, 1500);
        
      }
    })
  },
})
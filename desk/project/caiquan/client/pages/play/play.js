const toutalTime = 10;



// pages/play/play.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
      timeNum: toutalTime,
      inputNum : '',
      showAgain : false,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
  
  },

  replay : function(){
        //
        this.setData({
            timeNum: toutalTime,
            inputNum: '',
            showAgain: false,
        });

        this.onReady();
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
        let timeNum = toutalTime,
            that = this,
            timeHandle;

        timeHandle = setInterval(function(){

            timeNum--;

            that.setData({
                timeNum: timeNum
            });

            if (timeNum<=0){

                clearInterval(timeHandle);

                if (that.data.inputNum === '') {
                    wx.showToast({
                        title: '你选择弃权',
                        icon: 'none',
                    })

                    setTimeout(function(){
                        that.setData({
                            showAgain: true
                        });
                    },300)

                    return;
                }
                
                wx.showLoading({
                    title: '获取结果中',
                    mask: true
                })
            }


        },1000)


  },

  getNum : function(e){

        let num = e.detail.value || '';
        
        this.setData({
            inputNum: num
        })
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

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
  
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  
  }
})
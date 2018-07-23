
let startX,                 //触摸开始x坐标
    startY,                 //触摸开始y坐标
    curx,                   //滑动时x坐标
    cury,                   //滑动时y坐标
    wp_wid,                 //滑动区域的宽度
    wp_hei,                 //滑动区域的高度
    it_wid,                 //滑块的宽度
    it_hei,                 //滑块的高度
    limit_x_beg = 0,        //x轴的区域起始边界
    limit_x_end = 0,        //x轴的区域结束边界    
    limit_y_beg = 0,        //y轴的区域起始边界
    limit_y_end = 0;        //y轴的区域结束边界

Page({

  /**
   * 页面的初始数据
   */
  data: {
    left:0,
    top:0
  },

  startFn : function(e){
      startX = e.touches[0].pageX;
      startY = e.touches[0].pageY;
      curx = this.data.left;
      cury = this.data.top;
  },

  moveFn : function(e){
      
    let pointX = e.touches[0].pageX,
        pointY = e.touches[0].pageY,
        l = 0,
        t = 0;

    //console.log('pointX :' + pointX + ' curx :' + curx + ' wpX:' + wpX);    

    l = pointX - startX + curx;
    t = pointY - startY + cury;

    //console.log('pointX :' + pointX + ' pointY:' + pointY + ' startX :' + startX + ' startY:' + startY +' l:'+l+' t:'+t); 

    //边界处理
    if (l < limit_x_beg){
        l = limit_x_beg;
    }
    else if (l > limit_x_end){
        l = limit_x_end;
    }

    if (t < limit_y_beg) {
        t = limit_y_beg;
    }
    else if (t > limit_y_end) {
        t = limit_y_end;
    }


    this.setData({
        left : l,
        top : t
    });

  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    
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

    let that = this; 

    wx.createSelectorQuery().select('#areaBox').boundingClientRect(function (rect) {
        
        wp_wid = rect.width;
        wp_hei = rect.height;

        // wpX = rect.left,
        // wpY = rect.top;

        wx.createSelectorQuery().select('#areaBox-it').boundingClientRect(function (rect) {

            it_wid = rect.width;
            it_hei = rect.height;

            limit_x_end = wp_wid - it_wid;
            limit_y_end = wp_hei - it_hei;

        }).exec();

    }).exec();

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
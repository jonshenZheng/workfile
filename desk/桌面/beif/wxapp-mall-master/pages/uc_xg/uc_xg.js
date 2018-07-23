
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
    limit_y_end = 0,        //y轴的区域结束边界
    cvPercent = 0.6,         //超过这个节点的比例就覆盖
    cvlimit = 0,            //超过这个高度就直接遮罩分类层
    cvHei = 0,              //要被覆盖的节点高度
    animateNameKey = 'animate',
    animateTime = 500,
    islock = false;         //禁止拖拉

Page({

  /**
   * 页面的初始数据
   */
  data: {
    height: 'auto',  
    scaleY : 1,
    animateName : '',
    showBg : false,
    opacity : 0
  },

  startFn : function(e){

    if (islock){
        return;
    }

      startY = e.touches[0].pageY;
  },

  moveFn : function(e){

      if (islock) {
          return;
      }
      
    let pointY = e.touches[0].pageY,
        cy = 1,
        t= 0,
        cname = '',
        pc = 0,
        that = this;

    t = -(pointY - startY);

    //console.log('pointX :' + pointX + ' pointY:' + pointY + ' startX :' + startX + ' startY:' + startY +' l:'+l+' t:'+t); 

    //边界处理

    if (t > cvlimit) {
        t = cvHei;
        islock = true;
        cname = animateNameKey;
    }
    else if (t < 0) {
        t = 0;
    }

    pc = t / cvHei;

    cy = cy - (pc*0.4);

    t = (cvHei-t) + 'px';

    this.setData({
        scaleY : cy,
        height : t,
        animateName: cname,
        showBg : true,
        opacity: 0.2 + (pc*0.2)
    });

    // if (cname){
    //     setTimeout(function(){
    //         that.setData({
    //             animateName : ''
    //         });
    //     }, animateTime);
    // }


  },

  shouqiFn : function(){
      this.setData({
          animateName: '',
          scaleY: 1,
          height: 'auto',
          showBg : false,
          opacity : 0.2
      });
      islock = false;
  },

  endFn : function(){

    let that = this;
    if (!islock) {
        this.setData({
            animateName: animateNameKey,
            scaleY: 1,
            height: cvHei+'px',
            showBg: false,
            opacity: 0.2
        })
    }

    setTimeout(function(){
        that.setData({
            animateName : ''
        })
    }, animateTime)

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
        wp_hei = rect.height;
        wx.createSelectorQuery().select('#areaBox-it').boundingClientRect(function (rect) {

            it_hei = rect.height;
            limit_y_end = wp_hei - it_hei;

        }).exec();

    }).exec();

    wx.createSelectorQuery().select('#cvAarea').boundingClientRect(function (rect) {
        cvHei = rect.height;
        cvlimit = rect.height * cvPercent;
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
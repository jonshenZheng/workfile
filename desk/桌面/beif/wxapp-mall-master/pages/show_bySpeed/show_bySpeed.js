
let scrollLock = false,
    oldDereact = -1,
    isHide = false,
    animateTime = 300,
    animateLock = false,
    scrollTime = 500;

Page({

  /**
   * 页面的初始数据
   */
  data: {
      hideIt : false
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    
  },

  scrollFn : function(e){

        console.log('deltaY:' + e.detail.deltaY + '  scrollTop:' + e.detail.scrollTop)

        
        if (e.detail.scrollTop > 0 && e.detail.scrollTop <= 80){
            isHide = false;
            this.setValFn();
        }
        else if (e.detail.scrollTop > 80){

            if (e.detail.deltaY > 0) {

                //if (e.detail.deltaY > 20 && oldDereact === 1 && isHide) {
                if (e.detail.deltaY > 10 && isHide && !animateLock) {

                    isHide = false;

                    this.setValFn();
                }

                // oldDereact = 1;

            }
            else {

                //if (e.detail.deltaY < -20 && oldDereact === 1 && isHide){
                if (e.detail.deltaY < -10 && !isHide && !animateLock) {

                    isHide = true;

                    this.setValFn();
                }

                // oldDereact = -1;

            }


        }



  },
  setValFn : function(){

      animateLock = true;  

      this.setData({
          hideIt: isHide
      })

      setTimeout(function(){

          animateLock = false; 

      },animateTime);

  },

  upload : function(){

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
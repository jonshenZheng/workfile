
let shareTitle = '[有人@我] 这里有十万款办公家具产品，简直太牛了',
    hasShare;

Page({
  data: {
      url:''
  },
  onLoad:function(e){

      if (e.hasShare === 'false'){
        wx.hideShareMenu();
      }
      else{
          shareTitle = e.shareTitle;
      }

      if(e.pageTitle){
          wx.setNavigationBarTitle({
              title: e.pageTitle,
          });
      }

    console.log(e)
    this.setData({
      url: e.url
    });


  },
  onShareAppMessage(options) {
      //console.log(options.webViewUrl);
      return {
          title: shareTitle,
          path: 'pages/webview/webview?url=' + options.webViewUrl,
      }
  }
})
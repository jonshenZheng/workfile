Page({
  data: {
      url:''
  },
  onLoad:function(e){
    console.log(e)
    this.setData({
      url: e.url
    });
  },
  onShareAppMessage(options) {
      //console.log(options.webViewUrl);
      return {
          title: '广州国际家具博览会',
          path: 'pages/webview/webview?url=' + options.webViewUrl,
      }
  }
})
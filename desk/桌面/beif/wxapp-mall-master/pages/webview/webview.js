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
        title: '[有人@我] 这里有十万款办公家具产品，简直太牛了',
          path: 'pages/webview/webview?url=' + options.webViewUrl,
      }
  }
})
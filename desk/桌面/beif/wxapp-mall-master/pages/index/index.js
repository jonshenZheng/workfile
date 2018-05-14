var common = require('../common/common.js')
let app = getApp(),
  rq = app.bzRequest,
  baseURL = app.globalData.svr,
  storageKey = 'index',
  imgBaseURL = app.globalData.baseImgUrl;
// wx.navigateTo({
//   url: 'page/component/register/register',
// })
Page({
  data: {
    promotions: [
    ],
    btnff : '',
    windowSize : '',
    firstImgSrc : '',
    indicatorDots: false,
    imgBaseURL: imgBaseURL,
    recommend : [],
    autoplay: false,
    interval: 3000,
    duration: 800,
    hidesereachClass : '',
    popHideClass : 'hide',
    smPopHideClass : 'hide',
    PopImgSrc_big: '',
    PopImgSrc_small : '',
    homePopUri: '',
    hotSearches: [{ 'keyword': '1111' }, { 'keyword': '222' }, { 'keyword': '333' }],
  },
  onimgfail: function (e) {
    
      let objName = e.currentTarget.dataset.objname,
          arr,
          key,
          self = this;

        switch (objName){
            case 'recommend': arr = this.data.recommend;
                              key = 'pic';  
                break;
            case 'promotions': arr = this.data.promotions;
                               key = 'imgUrl';
                break;
        }

        common.loadimgfail(arr, e, objName, key, self);
  },
  onLoad : function(e){

    //第一屏图片
      let winWid = wx.getSystemInfoSync().windowWidth;
      let sizeTtype,
          ImgSrc;

      if (winWid > 640) {
          sizeTtype = 'bigSize';
          ImgSrc = 'https://baize-webresource.oss-cn-shenzhen.aliyuncs.com/weixin/image/pic_index_mainPicture.png';
      }
      else {
          sizeTtype = 'midSize';
          ImgSrc = 'https://baize-webresource.oss-cn-shenzhen.aliyuncs.com/weixin/image/pic_index_mainPicture_large.png';
      }

      //活动弹窗
      let bigPopImgSrc,
          smallPopImgSrc,
          popUrl,
          hideBigPop,
          hideBigPop_sm,
          showInp,
          that = this;

      rq({
          url: baseURL+'homePage/activity',
            success : function(r){
                
                if (typeof r.data.data != 'object' || r.data.data.length == 0){
                    return;
                }

                bigPopImgSrc = imgBaseURL+r.data.data[0].bigImg;
                if (r.data.data[0].showSmallImg){
                    smallPopImgSrc = imgBaseURL + r.data.data[0].smallImg;
                }
                popUrl = r.data.data[0].uri;

                hideBigPop = bigPopImgSrc ? '' : 'hide';

                hideBigPop_sm = smallPopImgSrc ? '' : 'hide';

                showInp = hideBigPop !== 'hide' ? 'hide' : '';

                that.setData({
                    hidesereachClass: showInp,
                    popHideClass: hideBigPop,
                    smPopHideClass: hideBigPop_sm,
                    PopImgSrc_big: bigPopImgSrc,
                    PopImgSrc_small: smallPopImgSrc,
                    homePopUri: popUrl,
                }); 


            }
      });

      this.setData({
          windowSize: sizeTtype,
          firstImgSrc: ImgSrc,
      }); 

    //获取 推荐产品 本地缓存
    /*let RecommendStorage = wx.getStorageSync(recommendName);

    if (!RecommendStorage){
        RecommendStorage = {}
        RecommendStorage['version'] = '';
        RecommendStorage['recommend'] = [];
    }

    this.setData({
        recommend: RecommendStorage.recommend
    });*/
    let pageStorage = common.getSorageByPage(storageKey, this);  

    //设置导航栏标题文字
    wx.setNavigationBarTitle({
        title : app.globalData.appName
    });

        rq({
            url: baseURL + 'ad',
            success: function (res) {

                let promotions = res.data.data;
                common.checkImgExist(promotions, 'imgUrl');

                common.setStorageByPage(storageKey, that ,'promotions', pageStorage , promotions);
                                                
            //   that.setData({
            //       promotions: promotions
            //   });
            }
        });

      rq({
          url: baseURL + 'recommend/getRecommend',
          success: function (r) {

              if (r.data.meta && r.data.meta.code == 200) {

                common.checkImgExist(r.data.data.recommends, 'pic');

                common.setStorageByPage(storageKey, that, 'recommend', pageStorage, r.data.data.recommends);

              }
          }
      })  
  },
  closeBigPopFn : function(){
      this.setData({
          hidesereachClass : '',
          popHideClass: 'hide'
      });
  },
  onShareAppMessage: function () {
    return {
      title: '我在这里找到了项目需要的办公家具，又做成了一单',
      path: '/pages/index/index',
      success: function (res) {
        // 转发成功
      },
      fail: function (res) {
        // 转发失败
      }
    }
  },
  btnStartFn : function(e){
      let n = e.currentTarget.dataset.cname;
      common.btnStartFn(this,n);
  },
  btnEndFn: function () {
      common.btnEndFn(this);
  },
  onShow: function (e) {

  },
  onTapCtrlProtoUri:function(e){
      
    common.resolveCtrlProtoUri(e.currentTarget.dataset.uri);
    // common.resolveCtrlProtoUri("wx-navigate://../package/package?id=group1");
  },
  onSearchKeywordInput: function (e) {
    this.setData({
      searchKeyword: e.detail.value
    });
  },
  onTapSearchButton: function () {
    var keyword = this.data.searchKeyword;
    if (keyword != null) {
      this.search(keyword);
    }
  },
  search: function (e) {
    console.log('搜索');
    let Regx = /^\s+|\s+$/g; 
    console.log(e);
    console.log(e.detail.value.sereachText);
    
    let keyword;
    if (e.detail.value.sereachText){
        keyword = e.detail.value.sereachText;
    }
    else{
        keyword = e.detail.value;
    }
    
    if (!keyword || typeof keyword !== 'string' ){
        return;
    }

    keyword = keyword.replace(Regx,'');

    if (keyword != '') {
      console.log("search: " + keyword)
      app.bzRequest({
        url: app.globalData.svr + 'keyword/search',
        data: { 'keyWords': keyword },
        header: { 'content-type': 'application/json' },
        method: 'POST',
        showLoading : true,
        errorcb : function(){
            setTimeout(function(){
                wx.showToast({
                    title: '搜索失败',
                    icon: 'none'
                });

            },100);

        },
        success: function (res) {
            
            app.globalData.searchResult = res.data.data;
            app.globalData.searchResultId = keyword;
            wx.navigateTo({
                url: '../search/search',
            })
        },
        complete :function(){
            wx.hideLoading();
        }
      })
    }
  },
  intocateg: function () {
    wx.switchTab({
      url: '../category/category'
    })
  },
  onTapHotSearchKeyword: function (e) {
    console.log(e.currentTarget.dataset.search);
    let search = e.currentTarget.dataset.search;
    // if(search)
    //   {
    //     this.
    //   }
  },
  onTapSearchImageButton: function (e) {
    let that = this;
    //1 打开界面让用户选择图片
    wx.chooseImage({
      count : 1,
      success: function (res) {
        //用户选择了图片  
        var tempFilePaths = res.tempFilePaths  //图片  
        console.log(tempFilePaths);
        //这里因为chooseImage会默认关闭loading,所以需要延迟执行上传图片
        setTimeout(function(){
            wx.showLoading();
            //2 上传图片获得相应id(因为wx.uploadFile接口对响应时间的限定,只能先获得id再请求)
            wx.uploadFile({
              url: baseURL + 'imageSearch/upload', //仅为示例，非真实的接口地址  
                filePath: tempFilePaths[0],
                name: 'image', //文件对应的参数名字(key)  
                success: function (res) {
                    console.log(res)
                    let data = JSON.parse(res.data);
                    if (data.meta.code == 200) {
                        let imgId = data.data;
                        //3 根据id请求搜索结果
                        rq({
                          url: baseURL + 'imageSearch/' + imgId,
                          showLoading : true,
                          data:{
                            'pageSize': 15
                          },
                          success: function (res2) {
                            app.globalData.searchResult = res2.data.data;
                            wx.navigateTo({
                              url: '../search/search',
                            })
                          },
                          complete:function(){
                            wx.hideLoading();
                          }
                        });
                    } else {
                      wx.hideLoading();
                        wx.showModal({
                            title: '错误',
                            content: data.meta.msg,
                        })
                    }
                },
                fail: function (data) {
                  wx.hideLoading();
                    wx.showModal({
                        title: '错误',
                        content: data.meta.msg,
                    })
                }
            })
        },100);
        
      },
      complete : function(){
          common.btnEndFn(that);
      }
    })
  }
})
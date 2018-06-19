// pages/totalsolution/totalsolution.js
var common = require('../common/common.js')
let app = getApp(),
    rq = app.bzRequest,
    baseURL = app.globalData.svr,
    storageKey = 'index',
    maxUploadImgLen = 4,
    imgBaseURL = app.globalData.baseImgUrl,
    needStr = '';

Page({

  /**
   * 页面的初始数据
   */
  data: {
      vedioSrc: imgBaseURL + 'weixin/video/introduce.mp4',
       needsList : [
           { name: '价格实惠', isActive : false },
           { name: '性价比高', isActive: false },
           { name: '国际品牌', isActive: false },
           { name: '现货为主', isActive: false },
           { name: '10天到位', isActive: false },
           { name: '正常工期', isActive: false },
           { name: '商务', isActive: false },
           { name: '休闲', isActive: false },
           { name: '工业', isActive: false },
           { name: '中式', isActive: false },
           { name: '现代', isActive: false },
           { name: '简约', isActive: false },
           { name: '互联网', isActive: false },
           { name: '消费品', isActive: false },
           { name: '金融', isActive: false },
           { name: '事业单位', isActive: false },
           { name: '广告传媒', isActive: false },
           { name: '餐饮', isActive: false },
           { name: '旅游', isActive: false },
       ],
       nullVal : '',
       selectImgArr : [], 
       isHedeAddImgBtn : false,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    // common.injectData(this, options)
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  
      //还原数据
      if (app.globalData.tempdata.refresh){

          let optList = [
              { name: '价格实惠', isActive: false },
              { name: '性价比高', isActive: false },
              { name: '国际品牌', isActive: false },
              { name: '现货为主', isActive: false },
              { name: '10天到位', isActive: false },
              { name: '正常工期', isActive: false },
              { name: '商务', isActive: false },
              { name: '休闲', isActive: false },
              { name: '工业', isActive: false },
              { name: '中式', isActive: false },
              { name: '现代', isActive: false },
              { name: '简约', isActive: false },
              { name: '互联网', isActive: false },
              { name: '消费品', isActive: false },
              { name: '金融', isActive: false },
              { name: '事业单位', isActive: false },
              { name: '广告传媒', isActive: false },
              { name: '餐饮', isActive: false },
              { name: '旅游', isActive: false },
          ];

          this.setData({
              needsList: optList,
              nullVal: '',
              selectImgArr: []
          });  


          app.globalData.tempdata.refresh = false;
      }    
  },

  // /**
  //  * 用户点击右上角分享
  //  */
  // onShareAppMessage: function () {
  //   let data = getCurrentPages()[0].data;
  //   let path = '/pages/totalsolution/totalsolution';
  //   path = common.suffixUriWithShopId(this, path);
  //   console.log(path)
  //   return {
  //     title: '[有人@我] 这里有十万款办公家具产品，简直太牛了',
  //     path: path,
  //     imageUrl: "https://baize-webresource.oss-cn-shenzhen.aliyuncs.com/weixin/image/share-myshop.png",
  //     success: (res) => {
  //       console.log("转发成功", res);
  //     },
  //     fail: (res) => {
  //       console.log("转发失败", res);
  //     }
  //   }
  // },
  //删除选中的图片
  delImgFn : function(e){
      var ind = e.currentTarget.dataset.ind,
          arr = this.data.selectImgArr;

       arr.splice(ind,1); 

       let isHide = arr.length >= 4 ? true : false;

        this.setData({
            selectImgArr : arr,
            isHedeAddImgBtn: isHide 
        });
  },
  //选择图片
  selectImgFn : function(){
      let self = this,
          imgArr = self.data.selectImgArr,
          thisImgNum = maxUploadImgLen - imgArr.length;
        if (imgArr.length >= maxUploadImgLen ){
            wx.showToast({
                title: '上传图片最多' + maxUploadImgLen+'张',
                icon : 'none'
            });
            return;
        }

        wx.chooseImage({
            count: thisImgNum,
            success: function(res) {

                imgArr = imgArr.concat(res.tempFilePaths);
           
                let isHide = imgArr.length >= maxUploadImgLen ? true : false;

                self.setData({
                    selectImgArr: imgArr,
                    isHedeAddImgBtn: isHide
                });

            }
        })
  },
  //选择客户需求
  selectNeeds : function(e){
      let arr = this.data.needsList,
          ind = e.currentTarget.dataset.ind,
          name = arr[ind].name+';',
          temp_name,
          temp = ';'+needStr,
          isSel = arr[ind].isActive;

       if (isSel){
            
           if (needStr != ''){
               temp_name = ';'+name;
               if (temp.indexOf(temp_name) !== -1){
                   temp = temp.slice(1);
                   needStr = temp.split(name).join('');
               }
           }

       } 
       else{
           needStr += name;
       }

       arr[ind].isActive = !isSel;

       this.setData({
           needsList : arr
       });

  },
  formSubmit : function(e){

    let uploadImg = [],
        selectImgArr = this.data.selectImgArr,
        uploadImg_i = selectImgArr.length,
        formId = e.detail.formId,
        orderNum,
        phoneNum = e.detail.value.phoneNum,
        data = {
            phone: phoneNum,
            needs: needStr,
            imgPaths: uploadImg
        },
        submitFn = function () {
            rq({
                url: baseURL + 'solution/save',
                withoutToken: false,
                method: 'POST',
                data: JSON.stringify(data),
                success: function (r) {
                
                    orderNum = r.data.data;
                    let time = common.getFormatTime('show');

                    rq({
                        url: baseURL + 'accessToken',
                        success: function (r) {

                            common.sentServerNotice({
                                rq : rq,
                                template_id :'RQdIs2RqmYGiq9MImXFPNDAFvXNuzTMbRW_r7QHPE9E',
                                formId: formId,
                                accessToken : r.data.data,
                                pageInd : 'pages/index/index',
                                emphasis_keyword: "keyword1.DATA",
                                data: {
                                    "keyword1": {
                                        "value": '全套服务',
                                        "color": "#ff0000"
                                    },
                                    "keyword2": {
                                        "value": '成功',
                                        "color": "#173177"
                                    },
                                    "keyword3": {
                                        "value": orderNum,
                                        "color": "#173177"
                                    },
                                    "keyword4": {
                                        "value": time,
                                        "color": "#173177"
                                    },
                                    "keyword5": {
                                        "value": '我们将在3个工作日内联系您，请耐心等待',
                                        "color": "#ff0000"
                                    }
                                }
                            });

                        }
                    });

                    wx.navigateTo({
                        url: "../buySuccess/buySuccess?pageType=全套服务",
                    });

                },
                complete: function(){
                    wx.hideLoading();
                }

            });
        },
        upFn = function(){
            
            if (uploadImg_i<=0){
                submitFn();
                return;
            }

            wx.uploadFile({
                url: baseURL + 'solution/imageupload', 
                filePath: selectImgArr[uploadImg_i-1],
                name: 'file',
                success: function (res) {
                    let data = JSON.parse(res.data);
                    console.log(data);
                    uploadImg.push(data.data);
                    console.log('ok');
                },
                fail : function(){
                    console.log('失败');
                },
                complete : function(){
                    uploadImg_i--;
                    upFn();
                }
            });

        };

    if (!common.formCheck.isPhone(phoneNum)){
        wx.showToast({
            title: '手机号错误',
            icon : 'none'
        });
         return;
    }     

    if (uploadImg_i <= 0){
        wx.showToast({
            title: '请上传户型图',
            icon : 'none'
        });
        return;
    }

    wx.showLoading({
        title: '正在上传文件',
    });
    upFn();

  }
})
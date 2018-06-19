let app = getApp(),
  rq = app.bzRequest,
  commJS = require("../../pages/common/common.js");

Component({
  properties: {

  },
  data: {
    shown: false
  },
  methods: {
    onTapShowMyShopBtn: function () {
      commJS.goBackToMyShop();
    }
  }
});


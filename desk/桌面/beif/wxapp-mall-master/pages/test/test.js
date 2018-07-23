// pages/test/test.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    list: [{
        content: '000',
        color: 'blue'
      },
      {
        content: '1',
        color: '#00BB00'
      },
      {
        content: '2',
        color: 'red'
      },
      {
        content: '3',
        color: 'blue'
      },
      {
        content: '4',
        color: 'green'
      },
      {
        content: '5',
        color: 'gray'
      },
      {
        content: '6',
        color: 'purple'
      },
      {
        content: '7',
        color: 'orange'
      },
      {
        content: '8',
        color: 'white'
      },
      {
        content: '9',
        color: 'pink'
      },
      {
        content: '9',
        color: 'pink'
      },
      {
        content: '9',
        color: 'pink'
      },
      {
        content: '9',
        color: 'pink'
      },
      {
        content: '9',
        color: 'pink'
      },
      {
        content: '9',
        color: 'pink'
      }
    ],
    expandableViewHeight: 0
  },

  scroll: function(e) {
    let detail = e.detail
    let that = this;
    let expandableViewMaxHeight = 50;

    var playAnim = function (show) {
      let expandableViewHeight = expandableViewMaxHeight;
      let speed = 1.5;
      if (show)
        expandableViewHeight = 0;

      return setInterval(
        () => {
          if (show)
            expandableViewHeight += speed;
          else
            expandableViewHeight -= speed;
          expandableViewHeight = expandableViewHeight < 0 ? 0 : expandableViewHeight;
          expandableViewHeight = expandableViewHeight > expandableViewMaxHeight ? expandableViewMaxHeight:expandableViewHeight;
          that.setData({
            expandableViewHeight: expandableViewHeight
          })
          let stop = show ? expandableViewHeight >= expandableViewMaxHeight : (expandableViewHeight <=0)
          if (stop) {
            clearInterval(that.animHandler);
            that.animHandler = null

          }
        }, 10
      )
    }

    let deltaYThreshold = 2;
    if (!that.animHandler) {
      if (e.detail.deltaY < -deltaYThreshold && that.data.expandableViewHeight <= 0) {
        let expandableViewHeight = 0;
        that.animHandler = playAnim(true)
      } else if (e.detail.deltaY > deltaYThreshold && that.data.expandableViewHeight >= expandableViewMaxHeight) {
        let expandableViewHeight = expandableViewMaxHeight;
        that.animHandler = playAnim(false)
      }
    }
  },

  onTap: function(e) {
    let detail = e.detail
    console.log(e)
  }
})
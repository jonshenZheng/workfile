Component({
    properties: {
        // 这里定义了innerText属性，属性值可以在组件使用时指定
        innerText: {
            type: String,
            value: '弹窗',
        }
    },
    data: {
        // 这里是一些组件内部数据
        someData: {
            ishide : true,
        },
        ishide: true,
    },
    methods: {
        // 这里是一个自定义方法
        customMethod: function () { },
        togglePop : function(){
            let isHide = !this.data.ishide;
            this.setData({
                ishide: isHide
            });
            var myEventDetail = {
                val: isHide
            }; // detail对象，提供给事件监听函数
            var myEventOption = {}; // 触发事件的选项
            
            this.triggerEvent('myevent', myEventDetail, myEventOption);
        }
    }
});

 
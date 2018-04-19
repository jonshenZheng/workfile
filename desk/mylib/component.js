/*数量增减按钮

	功能说明：1.可以手动输入数量 或者只能通过按钮来增减数量
			  2.手动输入过滤掉非数字的东西，不符合的值默认给1
			  3.能设置最大最小值

*/

var tpl_detial = '',
	count = 1,
	max = 999,
	isOnlyRead = true;
	min = 1;

tpl_detial += '<div class="easyLib-num-box clearfix">';
		
	if(count>min){
		tpl_detial += '<a class="num-jian fl noselect" onclick="changeNum(this)">-</a>';	
	}
	else{
		tpl_detial += '<a class="num-jian fl hui noselect" onclick="changeNum(this)">-</a>';
	}
	
	tpl_detial += '<div class="num-input fl">';

		if(isOnlyRead){
			tpl_detial += '<input class="count-inp-js" type="text" readonly="true" value="'+count+'" />';
		}
		else{
			tpl_detial += '<input class="count-inp-js" type="text" onblur="setCountNum(this,true)" onkeyup="setCountNum(this)" onafterpaste="setCountNum(this)" value="'+count+'" />';
		}

		tpl_detial += '</div>';

	if(count >= max){
		tpl_detial += '<a class="num-jia fl hui noselect" onclick="changeNum(this)">+</a>';
	}
	else{
		tpl_detial += '<a class="num-jia fl noselect" onclick="changeNum(this)">+</a>';
	}

tpl_detial += '</div>';


//点击增减按钮处理函数
function changeNum(self){
	
	var $btn = $(self),
		$btn_add,
		$btn_cur,
		$valEl,
		val,
		change = 1,
		max = 999;

	if($btn.hasClass('hui')){
		return;
	}	

	if($btn.hasClass('num-jian')){
		change = -1;
		$btn_cur = $btn;
		$btn_add = $btn.siblings('.num-jia');
	}

	if(!$btn.hasClass('num-jian')){
		$btn_add = $btn;
		$btn_cur = $btn.siblings('.num-jian');
	}

	$valEl = $btn.siblings('.num-input').find('input');
	val = parseInt($valEl.val());

	val += change;

	$btn_add.removeClass('hui');
	$btn_cur.removeClass('hui');

	if(val <= 1){
		$btn_cur.addClass('hui');
	}
	else if(val >= max){
		$btn_add.addClass('hui');
	}
	
	$valEl.val(val);

}

//手动输入数量
function setCountNum(self,isBlur){
		
	var $el = $(self),
		val = $el.val(),
		$prent = $el.parent(),
		$addBtn = $prent.siblings('.num-jia'),
		$curBtn = $prent.siblings('.num-jian'),
		max = 999;
	
	if(val.length==1){
		val = val.replace(/[^1-9]/g,'');
	
	}else{
		val = val.replace(/\D/g,'');
	}	
	
	if(val == '' && !isBlur){
		$el.val(val);
		return;
	}
	
	if(val == '' || isNaN(val)){
		val = 1;
	}
	
	val = parseInt(val);
	
	$addBtn.removeClass('hui');
	$curBtn.removeClass('hui');
	
	if(val <= 1){
		$curBtn.addClass('hui');
	}
	else if(val >= max){
		$addBtn.addClass('hui');
		val = max;
	}
	
	$el.val(val);
	
}






/*数量增减按钮 end*/



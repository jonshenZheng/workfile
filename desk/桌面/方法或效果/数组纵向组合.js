/* 
* @Author: RainCloud
* @Date:   2018-03-12 17:46:40
* @Last Modified by:   RainCloud
* @Last Modified time: 2018-03-12 17:48:23
*/

var list = [
        ['a1','a2','a3'],
        ['b1','b2','b3','b4'],
        ['c1','c2','c3'],
        ['d1','d2']
    ];

var total_valArr = [],
    results = [],
    result = {},
    hasVal,
    ajust = 0;

function concatObj(addinObj,Obj){
    for(var k in Obj){
        addinObj[k] = Obj[k];
    }
    return addinObj;
}

function doExchange(arr, depth){
	//过滤数组为[]这种的情况
    if( arr[depth] && arr[depth].length === 0){
        if(arr[depth+1]){
            ajust++;
            doExchange(arr,depth+1);
        }
        else{
            total_valArr.push(concatObj({},result));
        }
    }
    else{

        for (var i = 0; i < arr[depth].length; i++) {
            result[depth] = arr[depth][i];
            if (depth != arr.length - 1) {
                doExchange(arr, depth + 1);
            } else {
                total_valArr.push(concatObj({},result));
            }
        }

    }
}

doExchange(list,0);

console.log(total_valArr);
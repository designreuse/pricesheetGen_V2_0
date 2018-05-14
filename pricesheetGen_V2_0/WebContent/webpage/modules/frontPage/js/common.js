/**
 * Created by hezhao on 2016/2/3.
 */

/**
 * 后退
 */
function history_back(){
    history.back();
}

/**
 * 手机号码输入时隔3位一个空格 再隔4位一个空格的效果
 */
function doPhoneFilter(value) {
    var temp = [];
    temp[0] = value.slice(0, 3);
    temp[1] = value.slice(3, 7);
    temp[2] = value.slice(7);
    return temp.join(" ");
}

/**
 * 银行卡号加*显示
 */
function doBankCardFilter(value){
	var temp = [];
    temp[0] = value.slice(0, 4);
    temp[1] = "******";
    temp[2] = value.substring(value.length-4);
    return temp.join("");
}

/**
 * 卡券码隔4位一个空格
 */
function doCouponFilter(value){
	var temp = [];
    temp[0] = value.slice(0, 4);
    temp[1] = value.slice(4);
    return temp.join(" ");
}
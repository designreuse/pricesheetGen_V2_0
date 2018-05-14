'use strict';

/**
 * MyApp module
 */

var app = angular.module('myApp', [ 'ngRoute', 'ngCookies' ,'tm.pagination']);
// 注册路由
app.config([ '$routeProvider', "$httpProvider", "$locationProvider",
  function($routeProvider, $httpProvider, $locationProvider) {
  $routeProvider
	.when('/', {templateUrl : 'index_content.html',controller : 'index'})
	.when('/checkedOfferIndex/:paramer',{templateUrl:'checkedOfferIndex.html',controller:'checkOfferIndex_ctrl'})
	.when('/applyOfferList/:paramer',{templateUrl:'applyOfferList.html',controller:'applyOfferList_ctrl'})
	.when('/aboutUs/:paramer',{templateUrl:'aboutUs.html',controller:'aboutUs_ctrl'})
	.when('/personalData/:paramer',{templateUrl:'personalData.html',controller:'personalData_ctrl'})
	.when('/personalData',{templateUrl:'personalData.html',controller:'personalData_ctrl'})

	/*.when('/login/{url:.*}',{templateUrl:'login_content.html',controller:'loginByCode_ctrl'})*/
	.otherwise({
		redirectTo : "/"
	});
} ]);

// 在此方法内定义的方法、变量可应用于整个模板
app.run(function($location, $rootScope) {
	$rootScope.toaction = function(url) {
		$location.path(url);
	}
});

// 登录成功后跳转到指定路径
app.factory('ToLoginService', function($location) {
	var factory = {};
	factory.to_login = function(url) {
		// 将 / 符号 转义
		url = url.replace("/", "%2F");
		// 跳转到login控制器
		var absUrl = $location.absUrl();
		var url_index = absUrl.lastIndexOf("#/");
		var to_url = absUrl.substring(0, url_index + 2) + "login?url=" + url;
		window.location.href = to_url;
	}
	return factory;
});

// 过滤器，字符串超过指定长度后截取并追加...
app.filter('cut', function() {
	return function(value, wordwise, max, tail) {
		if (!value)
			return '';

		max = parseInt(max, 10);
		if (!max)
			return value;
		if (value.length <= max)
			return value;

		value = value.substr(0, max);
		if (wordwise) {
			var lastspace = value.lastIndexOf(' ');
			if (lastspace != -1) {
				value = value.substr(0, lastspace);
			}
		}
		return value + (tail || ' …');
	};
});

app.factory('MathService', function($location) {
	var factory = {}; 
	factory.is_log = function(cookieStore) {
		if(typeof(cookieStore.get('username')) == "undefined"){
			return false;
		}
		else{
			return true;
		}
	}
	return factory;
});
// 订单跳登录
//app.controller('account_login',
//		function($scope, $http, $cookieStore, $location) {
//			$scope.login = function() {
//				$location.path('/login');
//			}
//
//		});

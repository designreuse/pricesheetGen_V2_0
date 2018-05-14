//    app.controller('DemoController', ['$scope', 'BusinessService', function ($scope, BusinessService) {
app.controller('applyOfferList_ctrl',function($scope, $http, $routeParams, $cookieStore, $location, $sce,MathService) {
	if(MathService.is_log($cookieStore)){
		jQuery("#mine").hover(function(){
			jQuery("#mine").find("div").show(0);
		},function(){
			jQuery("#mine").find("div").hide(0);
		})
		jQuery("#mineD").find("div").hover(function(){
			jQuery(this).addClass("a")
		},function(){
			jQuery(this).removeClass()
		})
		
//		console.log($routeParams);
		console.log($routeParams.udes);
		
		$scope.aboutUs=function(){
			if(MathService.is_log($cookieStore)){	
				$location.path('/aboutUs/'+$cookieStore.get('username'));
			}else{
				 
			}
		};
		$scope.toPersenHtml=function(){
				$location.path('/personalData/'+$cookieStore.get("username"));
		};
		$scope.quietHtml=function(){
			jQuery('#quietModel').modal('hide'); 
			$cookieStore.remove('username');
			$location.path('/index');
		}
		
		var GetAllEmployee = function() {
				var postData = {
					pageIndex : $scope.paginationConf.currentPage,
					pageSize : $scope.paginationConf.itemsPerPage
				}

				$scope.paginationConf.totalItems = 3;
				$scope.persons = [ {
					orderId : "as123xas1",
					spfications : "1",
					model : "1",
					price : "1",
					updateTime : "1",
					saleMan : "1",
					offerAbout : "1"
				}, {
					orderId : "asad2",
					spfications : "2",
					model : "2",
					price : "2",
					updateTime : "2",
					saleMan : "2",
					offerAbout : "2"
				}, {
					orderId : "dqwds3",
					spfications : "3",
					model : "3",
					price : "3",
					updateTime : "3",
					saleMan : "3",
					offerAbout : "3"
				} ];

			}

			// 配置分页基本参数
			$scope.paginationConf = {
				currentPage : 1,
				itemsPerPage : 10,
				perPageOptions: [5, 10, 15, 20, 50],
			};

			/*******************************************************************
			 * 当页码和页面记录数发生变化时监控后台查询 如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
			 ******************************************************************/
			$scope.$watch(
					'paginationConf.currentPage + paginationConf.itemsPerPage',
					GetAllEmployee);
			
			$scope.lookOrderDetail=function(orderId){
				$location.path('/checkedOfferIndex/'+orderId);
			}
			$scope.quitLogin=function(){
				jQuery('#quietModel').modal({
					backdrop : 'static',
					keyboard : false
				});
			}
			$scope.quietHtml=function(){
				jQuery('#quietModel').modal('hide'); 
 				$cookieStore.remove('username');
 				$location.path('/applyOfferList/'+null);
			}
			
			$scope.del=function(id) { 
				jQuery("#delButton").attr("value", id);
				jQuery('#deleMode').modal({
					backdrop : 'static',
					keyboard : false
				});
			}
			$scope.delOrderDetail=function() {
				jQuery('#deleMode').modal('hide'); 
				showmessage('删除成功'); 
				jQuery("#"+jQuery('#delButton').attr('value')+"").remove();
				jQuery('#top_alert').fadeOut(3000);
			}
			function showmessage(text) {
				jQuery('#top_alert').empty().append('<span>' + text + '</span>');
				jQuery('#top_alert').css('display', 'block');
				jQuery('.top_alert').css({
									position : 'absolute',
									left : (jQuery(window).width() - $('.top_alert')
											.outerWidth()) / 3,
									top : (jQuery(window).height() - $('.top_alert')
											.outerHeight())
											/ 8 + jQuery(".content").scrollTop()
								});
			}
	}else{
		$location.path('/index');
	}
		}).filter('to_trusted', [ '$sce', function($sce) {
	return function(text) {
		return $sce.trustAsHtml(text);
	}
} ]);

app.factory('BusinessService', ['$http', function ($http) {
    var list = function (postData) {
        return $http.post('/Employee/GetAllEmployee', postData);
    }

    return {
        list: function (postData) {
            return list(postData);
        }
    }
}]);
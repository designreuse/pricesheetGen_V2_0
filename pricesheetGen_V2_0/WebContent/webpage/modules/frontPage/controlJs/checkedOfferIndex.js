app.controller(
		'checkOfferIndex_ctrl',
		function($scope, $http, $routeParams, $cookieStore, $location, $sce,MathService) {
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
			
			$scope.toMessage=function(){
				if(MathService.is_log($cookieStore)){
					$location.path('/applyOfferList/'+$cookieStore.get('username'));
				}else{
					jQuery("#loginIndex").show(0);
				}
			};
			$scope.loginOrQuit=function(){
				jQuery('#quietModel').modal({
					backdrop : 'static',
					keyboard : false
				});
			};
			
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
		}else{
			$location.path('/index');
		}
			
}).filter('to_trusted', [ '$sce', function($sce) {
	return function(text) {
		return $sce.trustAsHtml(text);
	}
} ]);


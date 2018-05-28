app.controller('personalData_ctrl',function($scope, $http, $routeParams, $cookieStore, $location, $sce,MathService) {
	$scope.bianJi="";
	if(typeof($routeParams.paramer)!="undifend"  || typeof($routeParams.paramer)!="" ){
		$http({
			url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'findUserByPhone?phone='+$routeParams.paramer,
			method:"GET",
			dataType:"json",
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			}
		}).success(function(data, status, headers, config){
			 console.log(data.data);
			 if(data.data.result==1){
				 $scope.name=data.data.data.name; 
				 $scope.companyName=data.data.data.company.name;
				 $scope.companyPhone=data.data.data.company.phone;
				 $scope.companyFox=data.data.data.company.fax; 
				 $scope.phone=data.data.data.phone; 
				 $scope.email=data.data.data.email; 
				 $scope.companyEmail=data.data.data.company.email;  
			 }
		}).error(function(data, status, headers, config){

	    }); 
	
	}else if(MathService.is_log($cookieStore)){
		 $scope.name=$cookieStore.get("custName"); 
		 $scope.companyName=$cookieStore.get("company");
		 $scope.companyPhone=$cookieStore.get("companyPhone");
		 $scope.companyFox=$cookieStore.get("companyFax"); 
		 $scope.phone=$cookieStore.get("phone"); 
		 $scope.email=$cookieStore.get("email"); 
		 $scope.companyEmail=$cookieStore.get("companyEmail"); 
		
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
		
		$scope.quitLogin=function(){
			jQuery('#quietModel').modal({
				backdrop : 'static',
				keyboard : false
			});
		}
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
		$scope.toMessage=function(){
			if(MathService.is_log($cookieStore)){
				$location.path('/applyOfferList/'+$cookieStore.get('username'));
			}else{
				jQuery("#loginIndex").show(0);
			}
		};
		
		$scope.toFirstHtml=function(){
			if(MathService.is_log($cookieStore)){
				$location.path('/');
			}else{
				jQuery("#loginIndex").show(0);
			}
		}
		
		$scope.cancelEditor=function(){
			$scope.bianJi="";
			$scope.password="";
			$scope.rePassword="";
			$scope.userName1="";
			$scope.sex1="";
			$scope.dateOfBirth1="";
			$scope.phone1="";
			$scope.email1="";
			$scope.fox1="";
			$scope.companyName1="";
			jQuery("#editor").hide(0);
			jQuery("#message").show(0);
		};
		
		$scope.editor=function(){
			$scope.bianJi="-->编辑";
			jQuery("#message").hide(0);
			jQuery("#editor").show(0);
		}
	}else{
		$location.path('/index');
	}
}).filter('to_trusted', [ '$sce', function($sce) {
	return function(text) {
		return $sce.trustAsHtml(text);
	}
} ]);

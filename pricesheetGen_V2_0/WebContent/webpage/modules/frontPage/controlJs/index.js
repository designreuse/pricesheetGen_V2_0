
app.controller(
		'index',
		function($scope, $http, $routeParams, $cookieStore, $location, $sce,MathService) {
			if(MathService.is_log($cookieStore)){
				 $scope.custName=$cookieStore.get("custName"); 
				 $scope.company=$cookieStore.get("company");
				 $scope.companyPhone=$cookieStore.get("companyPhone");
				 $scope.companyFax=$cookieStore.get("companyFax");
				 $("#container").hide();
				 $(".first").hide();
				 $("#loginOrQuit").show();
				 $("#loginIndex").hide();
				 $("#signupBox").hide();
			
			}
			$scope.validateCode=function(){
				var code = $scope.code;
				console.log(code);
				var discode = $.trim($('#discode').html());
				if (typeof(code) == 'undefined') {
					$('#codef').html('请输入验证码');
					$('#codel').css('display', 'block');
					return false;
				} else {
					if (code.toUpperCase() != discode.toUpperCase()) {
						$('#codef').html('验证码不正确');
						$('#codel').css('display', 'block');
						return false;
					} else {
						$('#codef').html('');
						$('#codel').css('display', 'none');
					}
				}
			}
			$scope.frontlogin=function(){
				return false;
				var data="userName="+$scope.userName+"&password="+$scope.password;
				 console.log(data);
//				 console.log('http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'frontlogin');
				$http({
					url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'frontLogin',
					method:"POST",
					dataType:"json",
					data:data,
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded'
					}
				}).success(function(data, status, headers, config){
					 console.log(data);
					 $cookieStore.put('username',data.loginName);
					 $cookieStore.put('custName',data.name);
					 $cookieStore.put('company',data.company);
					 $cookieStore.put('companyPhone',data.companyPhone);
					 $cookieStore.put('companyFax',data.fax);
					 $cookieStore.put('email',data.email);
					 $cookieStore.put('phone',data.phone);
					 $cookieStore.put('companyEmail',data.companyEmail);
					 $scope.custName=data.name;
					 $scope.company=data.company;
					 $scope.companyPhone=data.companyPhone;
					 $scope.companyFax=data.fax;
					 $("#container").hide();
					 $(".first").hide();
					 $("#loginOrQuit").show();
					 $("#loginIndex").hide();
					 $("#signupBox").hide();
				}).error(function(data, status, headers, config){
		
			    }); 
			}
			$scope.countdown="获取验证码";
			var flag=0;
			$scope.sendCodeRegister=function(){
				if ($scope.rePhone == null || $scope.rePhone == '') {
					alert("请输入手机号");
				} else {
					if (flag == 0) {
						jQuery("#sendCodeRe").attr("disabled", true);
						flag = 1;
						$scope.countdown = 60;
						var myTime = setInterval(function() {
							$scope.countdown--;
							$scope.$digest();
							// 通知视图模型的变化
							if ($scope.countdown == 0) {
								clearInterval(myTime);
								$scope.countdown = '获取验证码';
								jQuery("#sendCodeRe").attr("disabled",
										false);
								flag = 0;
								$scope.$digest();
							}								}, 1000);
						console.log($scope.rePhone);
					}
				}
				var data="phone="+$scope.rePhone;
				$http({
					url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'getReCode?'+data,
					method:"GET",
					dataType:"json",
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded'
					}
				}).success(function(data, status, headers, config){
					 console.log(data);
					 if(data.result==0){
						alert(data.msg); 
//						$("#reCode").css("background-color","red");
					 }
					 
				}).error(function(data, status, headers, config){
		
			    }); 
			}
			
			$scope.registerUser=function(){
				var phone= $scope.rePhone;
				var code= $scope.reCode;
				var password=$scope.rePassword;
				var rePassword=$scope.reConfirmNewPassword
				if(code==null || code==""){
					alert("请输入验证码");
					return false;
				}
				if(password==null || password==""){
					alert("请输入密码");
					return false;
				}
				if(rePassword==null || rePassword==""){
					alert("请输入确认密码");
					return false;
				}
				if(password!=rePassword){
					alert("密码与确认密码不一致");
					return false;
				}
				var data="phone="+phone+"&code="+code+"&password="+password;
				
				$http({
					url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'registerUser?'+data,
					method:"GET",
					dataType:"json",
					data:data,
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded'
					}
				}).success(function(data, status, headers, config){
					console.log(data);
					if(data.data.result==0){
						alert(data.data.msg); 
					 }else if(data.data.result==1){
						 jQuery('#registerSuccModel').modal({
								backdrop : 'static',
								keyboard : false
						 });
					 }
				}).error(function(data, status, headers, config){
		
			    }); 
			}
			
			$scope.toPersonHtml=function(){
				jQuery('#registerSuccModel').modal('hide'); 
				$location.path('/personalData/'+$scope.rePhone);
			}
			
			$scope.quotationAbout="办公设备";
			var countdownTimer = setInterval(function() { 
				   var  now = new Date();
			        var year = now.getFullYear();       //年
			        var month = now.getMonth() + 1;     //月
			        var day = now.getDate();            //日
			        var hh = now.getHours();            //时
			        var mm = now.getMinutes();          //分
			        var ss=now.getSeconds();			//秒
			        var clock = year + "-";
			        if(month < 10)
			            clock += "0";
			        clock += month + "-";
			        if(day < 10)
			            clock += "0";
			        clock += day + " ";
			        if(hh < 10)
			            clock += "0";
			        clock += hh + ":";
			        if (mm < 10) clock += '0'; 
			        clock += mm+":";
			        if (ss < 10) clock += '0';
			        clock += ss;
			       $scope.quotationDateStr=clock;
				   $scope.$digest();
			}, 1e3);
			
			jQuery("#bg").height($(window).height());
			loginChecked();
			
			$scope.aboutUs=function(){
				if(MathService.is_log($cookieStore)){	
					$location.path('/aboutUs/'+$cookieStore.get('username'));
				}else{
					 
				}
			};
			$scope.toMessage=function(){
				
				if(MathService.is_log($cookieStore)){
					$location.path('/applyOfferList/'+$cookieStore.get('username'));
				}else{
//					jQuery("#loginIndex").show(0);
				}
			};
			$scope.loginOrQuit=function(){
				if(MathService.is_log($cookieStore)){
					jQuery('#quietModel').modal({
						backdrop : 'static',
						keyboard : false
					});
				}else{
//					jQuery("#loginIndex").show(0);
				}
			};
			
			$scope.quietHtml=function(){
				jQuery('#quietModel').modal('hide'); 
 				$cookieStore.remove('username');
 				$location.path('/index');
			}
			
			$scope.toPersenHtml=function(){
				if(MathService.is_log($cookieStore)){
					$location.path('/personalData/'+$cookieStore.get("username"));
				}else{
//					$location.path('/index');
				}
			};
			
			function loginChecked(){
				if(MathService.is_log($cookieStore)){
 					jQuery("#right").addClass("assd");
					var right =jQuery("#right");
					var bottom =jQuery("#bottom");
					
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
					$scope.right = function() {
						if (jQuery("#settlementType").val() != ""
								&& jQuery("#payType").val() != ""
								&& jQuery("#staffId").val() != "") {
							jQuery("#right").removeClass("assd");
							jQuery("#bottom").addClass("assd");
						}
					}
					
					
					jQuery("#bg").hover(function() {
						if(right.hasClass('assd')==false){
							 document.getElementById("rightEditorDiv").style.width=jQuery("#rightEditorDiv").parent().width();
							 document.getElementById("rightEditorDiv").style.height=jQuery("#rightEditorDiv").parent().height();

							jQuery("#rightEditorDiv").show();
						}
						if(bottom.hasClass('assd')==false){
							 document.getElementById("bottomEditorDiv").style.width=jQuery("#bottomEditorDiv").parent().width();
							 document.getElementById("bottomEditorDiv").style.height=jQuery("#bottomEditorDiv").parent().height();

							jQuery("#bottomEditorDiv").show();
				    	 }
				     }, function() {
				    	 if(right.hasClass('assd')==false){
					    	 jQuery("#rightEditorDiv").hover(function() {
					    		 jQuery("#rightEditorDiv").show();
					    	 }, function() {
					    		 jQuery("#rightEditorDiv").hide();
					    	 });
					    	 jQuery("#rightEditorDiv").hide();
				    	 }
				    	 if(bottom.hasClass('assd')==false){
				    		 jQuery("#bottomEditorDiv").hover(function() {
					    		 jQuery("#bottomEditorDiv").show();
					    	 }, function() {
					    		 jQuery("#bottomEditorDiv").hide();
					    	 });
				    		 jQuery("#bottomEditorDiv").hide();
				    	 }
				     });
					 
					 $scope.rightEditor=function(){
						 jQuery("#right").addClass("assd");
						 jQuery("#bottom").removeClass("assd");
						 jQuery("#bottomEditorDiv").hide();
						 jQuery("#rightEditorDiv").hide();
					 }
					 $scope.bottomEditor=function(){
						 jQuery("#right").removeClass("assd");
						 jQuery("#bottom").addClass("assd");
						 jQuery("#bottomEditorDiv").hide();
						 jQuery("#rightEditorDiv").hide();
					 }
					 
					 $scope.submitPriceSheet=function(){
						 jQuery('#pushOrderModel').modal({
								backdrop : 'static',
								keyboard : false
							});
					 };
					 $scope.submitPriceSheetDirect=function(){
						 jQuery('#orderModel').modal({
								backdrop : 'static',
								keyboard : false
							});
					 };
					 $scope.checkedOrder=function(){
						 jQuery('#orderModel').modal('hide'); 
						 jQuery('#pushOrderModel').modal('hide'); 
						 $location.path('/checkedOfferIndex/'+$scope.quotationCode);
					 }
				}else{
		 			
		 		}
			}
			
	}).filter('to_trusted', [ '$sce', function($sce) {
	return function(text) {
		return $sce.trustAsHtml(text);
	}
} ]);

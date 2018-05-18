
app.controller(
		'index',
		function($scope, $http, $routeParams, $cookieStore, $location, $sce,MathService) {
			jQuery("#bottomD").height(jQuery("#bottomD").parent().height());
			
			if(MathService.is_log($cookieStore)){
				$scope.payType="003";
				$scope.settlementType="RMB";
				findUsers();
			}
			$scope.newcountdown="获取验证码";
		function findUsers(){
			$scope.quotationAbout="办公设备";
				console.log($cookieStore.get("username"));
				$http({
					url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'findUserByPhone?phone='+$cookieStore.get("username"),
					method:"GET",
					dataType:"json",
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded'
					}
				}).success(function(data, status, headers, config){
					 if(data.data.result==1){
						 if(data.data.data.company==null || data.data.data.company==""){
							 $scope.username=data.data.data.phone;
							 $scope.successs="该用户未完善资料！";
							 jQuery('#registerSuccModel').modal({
									backdrop : 'static',
									keyboard : false
							 });
						 }else{
//							 console.log(data.data.data);
//							 $scope.phone=data.data.data.phone;
//							 $scope.custName=data.data.data.name; 
//							 $scope.company=data.data.data.company;
//							 $scope.companyPhone=data.data.data.companyPhone;
//							 $scope.companyFax=data.data.data.fax; 
//							 $("#container").show();
//							 $("#left").addClass("left");
//							 jQuery("#rightD").show();
//							 jQuery("#leftD").hide();
//							 jQuery("#bottomD").show();
//							 $(".first").hide();
//							 $("#loginOrQuit").show();
//							 $("#loginIndex").hide();
//							 $("#signupBox").hide();
							 addRightClass('C1');
							 $cookieStore.put('username',data.data.data.phone);
							 $cookieStore.put('custName',data.data.data.name);
							 $cookieStore.put('company',data.data.data.company);
							 $cookieStore.put('companyPhone',data.data.data.companyPhone);
							 $cookieStore.put('companyFax',data.data.data.fax);
							 $cookieStore.put('email',data.data.data.email);
							 $cookieStore.put('phone',data.data.data.phone);
							 $cookieStore.put('companyEmail',data.data.data.companyEmail);
							 
							 if(data.data.data.name!=null && data.data.data.name!=""){
								 $scope.custName=data.data.data.name;
							 }else{
								 $scope.custName="";
								 jQuery("#custName").attr("placeholder","请完善个人资料");
							 }
							 if(data.data.data.company!=null && data.data.data.company!=""){
								 $scope.company=data.data.data.company;
							 }else{
								 $scope.company="";
								 jQuery("#company").attr("placeholder","请完善个人资料");
							 }
							 if(data.data.data.companyPhone!=null && data.data.data.companyPhone!=""){
								 $scope.companyPhone=data.data.data.companyPhone;
							 }else{
								 $scope.companyPhone="";
								 jQuery("#companyPhone").attr("placeholder","请完善个人资料");
							 }
							 if(data.data.data.fax!=null && data.data.data.fax!=""){
								 $scope.companyFax=data.data.data.fax;
							 }else{
								 $scope.companyFax="";
								 jQuery("#companyFax").attr("placeholder","请完善个人资料");
							 }
							 
							 findUsersByUserId();
							 $("#container").show();
							 $("#left").addClass("left");
							 jQuery("#rightD").show();
							 jQuery("#leftD").hide();
							 jQuery("#bottomD").show();
							 $(".first").hide();
							 $("#loginOrQuit").show();
							 $("#loginIndex").hide();
							 $("#signupBox").hide();
							 $scope.quotationAbout="办公设备";
						 }
					 }
					 
				}).error(function(data, status, headers, config){

			    }); 
			}
		function findUsersByUserId(){
			$http({
				url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'findUsersByUserId?phone='+$cookieStore.get("username"),
				method:"GET",
				dataType:"json",
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
					}
				}).success(function(data, status, headers, config){
					$scope.staffIds=data.data.data;
					$scope.staffId=$scope.staffIds[0].id;
					selectStaffs($scope.staffId);
				}).error(function(data, status, headers, config){
		
			    }); 
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
				var phone=$scope.userName;
				var password=$scope.password;
				if(phone==null|| typeof(phone)=="undefined"  || phone=="" ){
					alert("登录名不能为空！");
					return;
				}else{
					var myreg = /^1(3|4|5|7|8)\d{9}$/; 
					var mytelp= /^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}$/;
					if(!myreg.test(phone) && !mytelp.test(phone)) 
					{ 
					    alert('请输入有效的号码！'); 
					    return false; 
					} 
				}
				if(password==null || typeof(password)=="undefined" || password=="" ){
					alert("登录名不能为空！");
					return;
				}
				
				var data="phone="+phone+"&password="+password;
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
					 if(data.data.result==1){
						 if( data.data.data.company==null || data.data.data.company==""){
							 $scope.username=data.data.data.phone;
							 $cookieStore.put('username',data.data.data.phone);
							 $scope.successs="该用户未完善资料！";
							 jQuery('#registerSuccModel').modal({
									backdrop : 'static',
									keyboard : false
							 });
						 }else{
							 $cookieStore.put('username',data.data.data.phone);
							 $cookieStore.put('custName',data.data.data.name);
							 $cookieStore.put('company',data.data.data.company);
							 $cookieStore.put('companyPhone',data.data.data.companyPhone);
							 $cookieStore.put('companyFax',data.data.data.fax);
							 $cookieStore.put('email',data.data.data.email);
							 $cookieStore.put('phone',data.data.data.phone);
							 $cookieStore.put('companyEmail',data.data.data.companyEmail);
							 if(data.data.data.name!=null && data.data.data.name!=""){
								 $scope.custName=data.data.data.name;
							 }else{
								 $scope.custName="请完善个人资料";
							 }
							 if(data.data.data.company!=null && data.data.data.company!=""){
								 $scope.company=data.data.data.company;
							 }else{
								 $scope.company="请完善个人资料";
							 }
							 if(data.data.data.companyPhone!=null && data.data.data.companyPhone!=""){
								 $scope.companyPhone=data.data.data.companyPhone;
							 }else{
								 $scope.companyPhone="请完善个人资料";
							 }
							 if(data.data.data.fax!=null && data.data.data.fax!=""){
								 $scope.companyFax=data.data.data.fax;
							 }else{
								 $scope.companyFax="请完善个人资料";
							 }
							 findUsersByUserId();
							 $("#container").show();
							 $("#left").addClass("left");
							 jQuery("#rightD").show();
							 jQuery("#leftD").hide();
							 jQuery("#bottomD").show();
							 $(".first").hide();
							 $("#loginOrQuit").show();
							 $("#loginIndex").hide();
							 $("#signupBox").hide();
								$scope.quotationAbout="办公设备";
								addRightClass('C1');
								$scope.payType="003";
								$scope.settlementType="RMB";
								selectStaffs($scope.staffId);
						 }
					 }else{
						 alert(data.data.msg);
					 }
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
			function selectStaffs(staffId){
				var data="id="+staffId;
				$http({
					url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'selectStaff?'+data,
					method:"GET",
					dataType:"json",
					data:data,
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded'
					}
				}).success(function(data, status, headers, config){
					if(data.data.result==1){
						if(data.data.data!=null){
							if(data.data.data.phone!=null && data.data.data.phone!=""){
								$scope.cPhone=data.data.data.phone;
							}else{
								$scope.cPhone="无";
							}
							if(data.data.data.mobile!=null && data.data.data.mobile!=""){
								$scope.cMobile=data.data.data.mobile;
							}else{
								$scope.cMobile="无";
							}
							if(data.data.data.email!=null && data.data.data.email!=""){
								$scope.cEmail=data.data.data.email;
							}else{
								$scope.cEmail="无";
							}
							if(data.data.data.company!=null && data.data.data.company.fax!=null &&  data.data.data.company.fax!=""){
								$scope.cFax=data.data.data.company.fax;
							}else{
								$scope.cFax="无";
							}
						}else{
							$scope.cPhone="无";
							$scope.cMobile="无";
							$scope.cEmail="无";
							$scope.cFax="无";
						}
						var options=$("#staffId option:selected").text();
						$scope.cName=options;
					}
				}).error(function(data, status, headers, config){
		
			    });
				
			}
			
			$scope.selectStaff=function(){
				selectStaffs($scope.staffId);
			}
			$scope.registerUser=function(){
				var phone= $scope.rePhone;
				var code= $scope.reCode;
				var password=$scope.rePassword;
				var rePassword=$scope.reConfirmNewPassword
				if(phone==null|| typeof(phone)=="undefined"  ||phone=="" ){
					alert("手机号码不能为空！");
					return;
				}else{
					var myreg = /^1(3|4|5|7|8)\d{9}$/; 
					var mytelp= /^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}$/;
					if(!myreg.test(phone) && !mytelp.test(phone)) 
					{ 
					    alert('请输入有效的号码！'); 
					    return false; 
					} 
				}
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
						 $scope.username=phone;
						 $cookieStore.put('username',phone);
						 $scope.successs="注册成功！";
						 jQuery('#registerSuccModel').modal({
								backdrop : 'static',
								keyboard : false
						 });
					 }
				}).error(function(data, status, headers, config){
		
			    }); 
			}
			
			$scope.toPersonHtml=function(phone){
				jQuery('#registerSuccModel').modal('hide'); 
				$cookieStore.put('username',phone);
				$location.path('/personalData/'+phone);
			}
			
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
//			        if(hh < 10)
//			            clock += "0";
//			        clock += hh + ":";
//			        if (mm < 10) clock += '0'; 
//			        clock += mm+":";
//			        if (ss < 10) clock += '0';
//			        clock += ss;
			       $scope.quotationDateStr=clock;
				   $scope.$digest();
			}, 1e3);
			
			jQuery("#bg").height($(window).height());
			
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
			
			$scope.forgetPassword=function(){
				 jQuery('#forgetPasswordModel').modal({
						backdrop : 'static',
						keyboard : false
				 });
			}
			
			var newFlag=0;
			$scope.newSendCode=function(){
				if ($scope.newPhone == null || $scope.newPhone == '') {
					alert("请输入手机号");
				} else {
					if (newFlag == 0) {
						jQuery("#sendCodeNew").attr("disabled", true);
						newFlag = 1;
						$scope.newcountdown = 60;
						var myTime = setInterval(function() {
							$scope.newcountdown--;
							$scope.$digest();
							// 通知视图模型的变化
							if ($scope.newcountdown == 0) {
								clearInterval(myTime);
								$scope.newcountdown = '获取验证码';
								jQuery("#sendCodeNew").attr("disabled",
										false);
								newFlag = 0;
								$scope.$digest();
							}								}, 1000);
						console.log($scope.newPhone);
					}
				}
				var data="phone="+$scope.newPhone;
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
					 }
					 
				}).error(function(data, status, headers, config){

			    }); 
			}
			//确认手机号及验证码正确
			$scope.confirmPhone=function(){
				var data="phone="+$scope.newPhone+"&code="+$scope.newCode;
				$http({
					url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'confirmPhone?'+data,
					method:"GET",
					dataType:"json",
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded'
					}
				}).success(function(data, status, headers, config){
					 console.log(data);
					 if(data.data.result==1){
						jQuery("#old_phone").hide();
						jQuery("#new_password").show();
					 }else{
						 alert(data.msg); 
					 }
				}).error(function(data, status, headers, config){

			    }); 
				
			}
			//重置密码
			$scope.updatePassword=function(){
				var phone= $scope.newPhone;
				var newPassword=$scope.newPassword;
				var newRePassword=$scope.newRePassword;
				if(typeof(newPassword)=="undefined" || newPassword==""){
					alert("请输入新密码！");
					return false;
				}
				if(typeof(newRePassword)=="undefined" || newRePassword==""){
					alert("请输入确认密码！");
					return false;
				}
				if(newRePassword!=newPassword){
					alert("两次密码输入不一致");
					return false;
				}
				var data="phone="+phone+"&newPassword="+newPassword
				$http({
					url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'updatePassword?'+data,
					method:"GET",
					dataType:"json",
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded'
					}
				}).success(function(data, status, headers, config){
					console.log(data);
					if(data.data.result==0){
						alert(data.data.msg); 
					 }else if(data.data.result==1){
						jQuery('#forgetPasswordModel').modal('hide'); 
						alert(data.data.msg); 
						jQuery("#old_phone").show();
						jQuery("#new_password").hide();
						$scope.newPhone="";
						$scope.newCode="";
						$scope.newPassword="";
						$scope.newRePassword="";
					 }
				}).error(function(data, status, headers, config){

			    }); 
			}
			
			//关闭重置密码窗口
			$scope.closeforgetPasswordModel=function(){
				jQuery('#forgetPasswordModel').modal('hide'); 
				jQuery("#old_phone").show();
				jQuery("#new_password").hide();
				$scope.newPhone="";
				$scope.newCode="";
				$scope.newPassword="";
				$scope.newRePassword="";
			}
			
			// 组织报价单返回Json对象
			function getPriceSheetJson() {
				// 报价单总信息json实体
				var quotationOrder = {};
				var fieldsHead = $("#headTab").find("input:visible");

				// 报价单头部转Json 
				addObjSet2Json(quotationOrder, fieldsHead, null);
				
				quotationOrder.custId=$cookieStore.get("username");  
				// 结算货币 
			 
				quotationOrder.settlementType =$scope.settlementType;  
				// 付款方式
				quotationOrder.payType =$scope.payType;  
				// 销售人员
				quotationOrder.staffId =$scope.staffId;  
				
				quotationOrder.quotationAbout=$scope.quotationAbout;
				// 报价单号上送始终为空
				quotationOrder.quotationCode = "";

				// 报价单明细信息
				var objBodyList = null;
				var fieldsTrObj = $("#mainDivId").find("#tab").find("tr");
				$.each(fieldsTrObj, function(index, domEle) {
					var fieldsInput = $(domEle).find("input:visible");
					if (0 >= fieldsInput.length) {
						return;
					}

					var svcGrp = fieldsInput[0];
					if (null == objBodyList) {
						objBodyList = new Array();
					}

					var subfieldsTrObj = $("#subDivId_Div_" + index).find(
							"#subDivId_Tbl_" + index).find("tr");
					$.each(subfieldsTrObj, function(subindex, subdomEle) {
						var objBodySub = {};
						var subfieldsInput = $(subdomEle).find("input:visible");

						if (0 >= subfieldsInput.length) {
							return;
						}

						addObjSet2Json(objBodySub, subfieldsInput, svcGrp);
						objBodyList.push(objBodySub);
					});
				});

				quotationOrder["quotationOrderDetails"] = objBodyList;
				quotationOrder["withTaxAmt"] = $("#withTaxAmt").text();
				quotationOrder["privilegeAmt"] = $("#privilegeAmt").val();
				quotationOrder["dealAmt"] = $("#dealAmt").text();

				// 报价单尾部信息
				quotationOrder["arrivalDays"] = $("input[name=\"arrivalDays\"]").val();
				var _deliveryMode = $("input[name='deliveryMode']:checked").val();
				quotationOrder["deliveryMode"] = _deliveryMode;
				if ("001" == _deliveryMode || "004" == _deliveryMode) {
					quotationOrder["otherAdd"] = "";
				} else if ("002" == _deliveryMode) {
					quotationOrder["otherAdd"] = $("#waitDays").val();
				} else if ("003" == _deliveryMode) {
					quotationOrder["otherAdd"] = $("#otherChoice").val();
				}

				return quotationOrder;
			}
			
			/*
			 * 检查必要的不能为空的输入 
			 */
			function chkEssentialInput() {
				var quotationAbout = $.trim($("[name='quotationAbout']").val());
				if ("" == quotationAbout) {
					alert("报价关于不能为空！！！");
					return false;
				}

				var settlementType= $scope.settlementType;  
				var payType=$scope.payType;  
				var staffId=$scope.staffId;
				if(typeof(settlementType)=="undefined" || typeof(payType)=="undefined" || typeof(staffId)=="undefined" ){
					 alert("结算币种、付款方式、销售人员不能为空！");
					return false;
				}
				
				// 如果报价单号已经生成，用户继续点击则进行提示
				var quotationCode = $("#headDivId").find("input[name=quotationCode]")
						.val();
				if (0 < quotationCode.length) {
					return confirm("【继续生成报价单】\n当前报价单已经生成成功，继续操作会生成新的报价单号。");
				}

				return true;
			}
//		 	//直接提交报价单
			$scope.submitPriceSheetDirect=function(){		
						if (!chkEssentialInput()) {
							return;
						}
						var quotationOrder = getPriceSheetJson();
						quotationOrder.transType = "001";
						console.log(quotationOrder);
						$http({
							url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'saveOrder',
							method:"POST",
							dataType : 'json',
							data : JSON.stringify(quotationOrder),
							headers: {
								'Content-Type': 'application/json'
							}
						}).success(function(data, status, headers, config){
							console.log(data);
							data = data.body;
							if (null != data && "0" == data.state) {
								alert("【报价单保存失败】\n" + data.msg);
							} else if (null != data && "1" == data.state) {
								alert("【报价单保存成功】\n" + data.msg);
								$("#headDivId").find("input[name=quotationCode]")
										.val(data.quotationCode);
							} else {
								alert("【报价单提交失败】\n 数据处理异常，保存报价单失败！！！");
							}
						}).error(function(data, status, headers, config){
				
					    }); 
			}
			//审核后获得报价单
			$scope.submitCheckPriceSheetDirect=function(){		
				if (!chkEssentialInput()) {
					return;
				}
				var quotationOrder = getPriceSheetJson();
				quotationOrder.transType = "001";
				console.log(quotationOrder);
				$http({
					url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'saveCheckOrder',
					method:"POST",
					dataType : 'json',
					data : JSON.stringify(quotationOrder),
					headers: {
						'Content-Type': 'application/json'
					}
				}).success(function(data, status, headers, config){
					console.log(data);
					data = data.body;
					if (null != data && "0" == data.state) {
						alert("【报价单保存失败】\n" + data.msg);
					} else if (null != data && "1" == data.state) {
						alert("【报价单保存成功】\n" + data.msg);
						$("#headDivId").find("input[name=quotationCode]")
								.val(data.quotationCode);
					} else {
						alert("【报价单提交失败】\n 数据处理异常，保存报价单失败！！！");
					}
				}).error(function(data, status, headers, config){
		
			    }); 
	}
			$scope.leftD=function(){
				 jQuery("#leftD").hide();
				 jQuery("#rightD").show();
				 jQuery("#bottomD").show();
				 jQuery("#left").addClass("left");
				 jQuery("#right").removeClass("right");
				 jQuery("#bottom").removeClass("bottom");
			}	
			$scope.rightD=function(){
				 if(typeof($scope.quotationAbout)=="undefined" || $scope.quotationAbout==null || $scope.quotationAbout==""){
						shake($("#quotationAbout"),"selectshake",4);  
					 return;
				 }
				 jQuery("#rightD").hide();
				 jQuery("#leftD").show();
				 jQuery("#bottomD").show();
				 jQuery("#right").addClass("right");
				 jQuery("#left").removeClass("left");
				 jQuery("#bottom").removeClass("bottom");
			}
			$scope.bottomD=function(){
				 if(typeof($scope.quotationAbout)=="undefined" || $scope.quotationAbout==null || $scope.quotationAbout==""){
						shake($("#quotationAbout"),"selectshake",4);  
					 return;
				 }
				if(typeof($scope.settlementType)=="undefined" || $scope.settlementType==null || $scope.settlementType==""){
					shake($("#settlementType"),"selectshake",4);  
					 return;
				 }
				if(typeof($scope.payType)=="undefined" || $scope.payType==null || $scope.payType==""){
					shake($("#payType"),"selectshake",4);  
					 return;
				 }
				if(typeof($scope.staffId)=="undefined" || $scope.staffId==null || $scope.staffId==""){
					shake($("#staffId"),"selectshake",4);
					 return;
				 }
				 jQuery("#bottomD").hide();
				 jQuery("#leftD").show();
				 jQuery("#rightD").show();
				 jQuery("#bottom").addClass("bottom");
				 jQuery("#right").removeClass("right");
				 jQuery("#left").removeClass("left");
			}
			
			function shake(ele,cls,times){//边框闪烁  
			    var i = 0,t= false ,o =ele.attr("class")+" ",c ="",times=times||2;  
			    if(t) return;  
			    t= setInterval(function(){  
			        i++;  
			        $scope.$digest();
			        c = i%2 ? o+cls : o;  
			        ele.attr("class",c);  
			        if(i==2*times){  
			            clearInterval(t);  
			            ele.removeClass(cls);  
			        }  
			    },200); 
			    
			    
//			    var myTime = setInterval(function() {
//					$scope.countdown--;
//					$scope.$digest();
//					// 通知视图模型的变化
//					if ($scope.countdown == 0) {
//						clearInterval(myTime);
//						$scope.countdown = '获取验证码';
//						jQuery("#sendCodeRe").attr("disabled",
//								false);
//						flag = 0;
//						$scope.$digest();
//					}								}, 1000);
//				console.log($scope.rePhone);
//			}
			};  
	}).filter('to_trusted', [ '$sce', function($sce) {
	return function(text) {
		return $sce.trustAsHtml(text);
	}
} ]);

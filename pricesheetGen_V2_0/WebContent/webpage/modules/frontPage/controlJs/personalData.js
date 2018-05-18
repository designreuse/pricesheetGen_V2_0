app.controller('personalData_ctrl',function($scope, $http, $routeParams, $cookieStore, $location, $sce,MathService) {
	$scope.bianJi="";
	$scope.countdown="获取验证码"
	$scope.newcountdown="获取验证码"
	if(typeof($routeParams.paramer)!="undifend"  || $routeParams.paramer!="" ){
		if(MathService.is_log($cookieStore)){
			if($cookieStore.get("username")==$routeParams.paramer){
				findUsers();
				findUsersByUserId();
			}else{
 				$cookieStore.remove('username');
				$location.path('/');
			}
		}else{
			$cookieStore.remove('username');
			$location.path('/');
		}
	}
	function findUsers(){
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
				 $scope.companyName=data.data.data.company;
				 $scope.companyPhone=data.data.data.companyPhone;
				 $scope.companyFox=data.data.data.fax; 
				 $scope.phone=data.data.data.phone; 
				 $scope.companyEmail=data.data.data.email;  
				 $scope.imageUrl=data.data.data.photo; 

				 $scope.newName=data.data.data.name; 
				 $scope.newCompanyName=data.data.data.company;
				 $scope.newCompanyPhone=data.data.data.companyPhone;
				 $scope.newCompanyFox=data.data.data.fax; 
				 $scope.newCompanyEmail=data.data.data.email; 
				 if(typeof($scope.newCompanyName)!="undefined" && $scope.newCompanyName=="上海小树信息技术有限公司"){
					 jQuery(".isXSCompany").show();
					 $scope.emailPassword=data.data.data.emailPassword;
				 }else{
					 jQuery(".isXSCompany").hide();
					 $scope.emailPassword="";
				 }
				 
				 $scope.thumb=data.data.data.photo; 
				 $scope.ismodify=false;
			 }else{
				 
			 }
		}).error(function(data, status, headers, config){

	    }); 
	}
	
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
	
	$scope.quitLogin=function(){
		jQuery('#quietModel').modal({
			backdrop : 'static',
			keyboard : false
		});
	}
	
	$scope.toFirstHtml=function(){
		if(MathService.is_log($cookieStore)){
				console.log($scope.newCompanyName);
				if(  typeof($scope.newCompanyName)=="undefined" || $scope.newCompanyName==null || $scope.newCompanyName=="" ){
					$cookieStore.remove('username');
					$location.path('/');
				}else{
					$location.path('/');
				}
		}else{
			$cookieStore.remove('username');
			$location.path('/');
		}
		
	}
	
	$scope.updatePhoneModel=function(){
		jQuery('#phoneModel').modal({
			backdrop : 'static',
			keyboard : false
		});
	}
	
	$scope.confirmPhone=function(){
		
		var data="phone="+$scope.phone+"&code="+$scope.code;
		if (typeof($scope.code) == "undefined" || $scope.rePhone == '') {
			alert("请输入验证码");
			return false;
		} 
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
				jQuery("#old_Phone").hide();
				jQuery("#new_Phone").show();
			 }else{
				 alert(data.msg); 
			 }
		}).error(function(data, status, headers, config){

	    }); 
		
	}
	
	var flag=0;
	$scope.sendCode=function(){
		if ($scope.phone == null || $scope.phone == '') {
			alert("请输入手机号");
		} else {
			if (flag == 0) {
				jQuery("#sendCodeOld").attr("disabled", true);
				flag = 1;
				$scope.countdown = 60;
				var myTime = setInterval(function() {
					$scope.countdown--;
					$scope.$digest();
					// 通知视图模型的变化
					if ($scope.countdown == 0) {
						clearInterval(myTime);
						$scope.countdown = '获取验证码';
						jQuery("#sendCodeOld").attr("disabled",
								false);
						flag = 0;
						$scope.$digest();
					}								}, 1000);
				console.log($scope.rePhone);
			}
		}
		var data="phone="+$scope.phone;
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
	$scope.closePhoneModel=function(){
		jQuery('#phoneModel').modal('hide'); 
		$scope.newPhone="";
		$scope.newCode="";
		$scope.code="";
	}
	
	$scope.updatePawdModel=function(){
		jQuery('#pawdModel').modal({
			backdrop : 'static',
			keyboard : false
		});
	}
	
	$scope.closePawdModel=function(){
		jQuery('#pawdModel').modal('hide'); 
		$scope.password="";
		$scope.newPassword="";
		$scope.newRePassword="";
	}
	
	
	$scope.findCompanyByName=function(){
		var data="companyName="+$scope.newCompanyName;
		console.log(data);	

		$http({
			url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'findCompanyByName',
			method:"POST",
			dataType:"json",
			data:data,
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			}
		}).success(function(data, status, headers, config){
			 if(typeof(data.data.data.name)!="undefined" && data.data.data.name=="上海小树信息技术有限公司"){
				 jQuery(".isXSCompany").show();
			 } else{
				 jQuery(".isXSCompany").hide();
			 }
			$scope.newCompanyPhone=data.data.data.phone;	
			$scope.newCompanyFox=data.data.data.fax;	
		}).error(function(data, status, headers, config){

	    }); 
	}
	
	$scope.updatePhone=function(){
		var phone= $scope.phone;
		var newCode=$scope.newCode;
		var newPhone=$scope.newPhone;
		if(typeof(newPhone)=="undefined" || newPhone==""){
			alert("请输入新号码！");
			return false;
		}
		if(typeof(newCode)=="undefined" || newCode==""){
			alert("请输入验证码！");
			return false;
		}
		if(phone==newPhone){
			alert("新手机号码不能与旧手机号相同");
			return false;
		}
		
		
		var data="phone="+phone+"&code="+newCode+"&newPhone="+newPhone;
		$http({
			url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'updatePhone?'+data,
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
				jQuery('#phoneModel').modal('hide'); 
				alert(data.data.msg); 
				$scope.phone=data.data.data;
				$scope.newPhone="";
				$scope.newCode="";
				$scope.code="";
			 }
		}).error(function(data, status, headers, config){

	    }); 
	}
	
	$scope.updatePassword=function(){
		var phone= $scope.phone;
		var password= $scope.password;
		var newPassword=$scope.newPassword;
		var newRePassword=$scope.newRePassword;
		if(typeof(password)=="undefined" || password==""){
			alert("请输入原密码！");
			return false;
		}
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
		if(password==newPassword){
			alert("新密码不能与旧密码相同");
			return false;
		}
		var data="phone="+phone+"&password="+password+"&newPassword="+newPassword
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
				jQuery('#pawdModel').modal('hide'); 
				alert(data.data.msg); 
				$scope.password="";
				$scope.newPassword="";
				$scope.newRePassword="";
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
				console.log(data.data.data);
				$(data.data.data).each(function(i,item){
					if(item.id=="test01"){
						jQuery("#manager").hide();
						$scope.assistant=item.name;
						$scope.assistantPhone=item.phone;
						$scope.assistantMible=item.mobile;
						$scope.assistantEmail=item.email;
					}else{
						jQuery("#managers").show();
						$scope.manager=item.name;
						$scope.managerPhone=item.phone;
						$scope.managerMible=item.mobile;
						$scope.managerEmail=item.email;
					}
				}); 
			}).error(function(data, status, headers, config){
	
		    }); 
		}
	
	var pwState=false;
	$scope.showEmailPassword=function(e){
		 if (!pwState) {  
			 	jQuery("#emailPassword").attr("type","text");
			 	jQuery("#showOrhide").val("隐藏");
		        pwState = true;  
		    } else {  
			 	jQuery("#showOrhide").val("显示");
			 	jQuery("#emailPassword").attr("type","password");
		        pwState = false;  
		    }  
	}
   function changePasswordVisiblity(what, id) {  
        what = parseInt(what,10);  
        var theEl = document.getElementById(id);  

        if (what === 1) { //show  
            $(theEl).vendorCss("TextSecurity","none");  
        } else {  
            $(theEl).vendorCss("TextSecurity","disc");  
        }  
        if(!$.os.webkit) {  
            if(what === 1)  
                theEl.type="text";  
            else  
                theEl.type="password";  
        }  
        theEl = null;  
    }  
	$scope.updateUserInfo=function(){
		var phone= $scope.phone;
		var name= $scope.newName;
		var companyName= $scope.newCompanyName;
		var fox= $scope.newCompanyFox;
		var companyEmail= $scope.newCompanyEmail;
		var emailPassword= $scope.emailPassword;
		var companyPhone= $scope.newCompanyPhone;
		var photo=$scope.thumb;
		if( name==null ||typeof(name)=="undefined" || name==""){
			alert("请输入姓名");
			return false;
		}
		if(companyName==null ||typeof(companyName)=="undefined" || companyName==""){
			alert("请输入公司名称");
			return false;
		}
		if(companyEmail==null ||typeof(companyEmail)=="undefined" || companyEmail==""){
			alert("请输入公司邮箱");
			return;
		}else{
			var myreg= /^[0-9A-Za-z]+([-_.][0-9A-Za-z]+)*@([0-9A-Za-z]+[-.])+[0-9A-Za-z]{2,5}$/;
			if(!myreg.test(companyEmail)) 
			{ 
			    alert('请输入合法的email！'); 
			    return false; 
			} 
		}
		var ismodify=$scope.ismodify;
		var data="phone="+phone+"&name="+name+"&companyName="+companyName+"&fox="+fox+"&companyEmail="+companyEmail+"&emailPassword="+emailPassword+"&companyPhone="+companyPhone+"&photo="+photo+"&ismodify="+ismodify;
		console.log(data);
		$http({
			url:'http://'+IP+'/pricesheetGen/quotation/quotationOrder/'+EDITION+'updateUserInfo',
			method:"POST",
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
				alert(data.data.msg); 
//				cancelEditorJs();
//				findUsers();
				 if(MathService.is_log($cookieStore)){
						console.log($scope.newCompanyName);
						$location.path('/');
				}else{
					$cookieStore.remove('username');
					$location.path('/');
				}
			 }
		}).error(function(data, status, headers, config){
			
	    }); 
		
	}
	
	
	$scope.reader = new FileReader();   //创建一个FileReader接口
	$scope.thumb ="";      //用于存放图片的base64
	$scope.img_upload = function(files) {       //单次提交图片的函数
		$scope.ismodify=true;
        $scope.reader.readAsDataURL(files[0]);  //FileReader的方法，把图片转成base64
        $scope.reader.onload = function(ev) {
        	$scope.thumb = ev.target.result  //接收base64
        	$scope.$apply(); 
        };
	} 
	$scope.cancelEditor=function(){
		cancelEditorJs();
	};
	
	function cancelEditorJs(){
		$scope.bianJi="";
		$scope.newName=$scope.name;
		$scope.newEmail=$scope.email;
		$scope.newCompanyFox=$scope.companyFox;
		$scope.newCompanyName=$scope.companyName;
		$scope.newCompanyPhone=$scope.companyPhone;
		$scope.newCompanyEmail=$scope.companyEmail;
		
		jQuery("#editor").hide(0);
		jQuery("#message").show(0);
	}
	
	$scope.editor=function(){
		$scope.bianJi="-->编辑";
		jQuery("#message").hide(0);
		jQuery("#editor").show(0);
		$scope.thumb=$scope.imageUrl;
		$scope.ismodify=false;
	}
}).filter('to_trusted', [ '$sce', function($sce) {
	return function(text) {
		return $sce.trustAsHtml(text);
	}
} ]);

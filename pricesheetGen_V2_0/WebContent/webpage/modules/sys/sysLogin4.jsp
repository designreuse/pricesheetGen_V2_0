<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta name="description" content="User login page" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<script src="${ctxStatic}/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
		<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
		<script src="${ctxStatic}/jquery-validation/1.14.0/jquery.validate.js" type="text/javascript"></script>
		<script src="${ctxStatic}/jquery-validation/1.14.0/localization/messages_zh.min.js" type="text/javascript"></script>
		<link href="${ctxStatic}/bootstrap/3.3.4/css_default/bootstrap.min.css" type="text/css" rel="stylesheet" />
		<script src="${ctxStatic}/bootstrap/3.3.4/js/bootstrap.min.js"  type="text/javascript"></script>
		 <link href="${ctxStatic}/awesome/4.4/css/font-awesome.min.css" rel="stylesheet" /> 
	
		<!-- jeeplus -->
		<link href="${ctxStatic}/common/sapling.css" type="text/css" rel="stylesheet" />  
		<script src="${ctxStatic}/common/sapling.js" type="text/javascript"></script>
		<!-- <link rel="shortcut icon" href="images/favicon.png" type="image/png"> -->
		<!-- text fonts -->
	  	<link rel="stylesheet" href="${ctxStatic }/common/login/ace-fonts.css" />  

		<!-- ace styles -->
		  <link rel="stylesheet" href="${ctxStatic }/common/login/ace.css" />  

		<!-- 引入layer插件 -->
		<script src="${ctxStatic}/layer-v2.3/layer/layer.js"></script>
		<script src="${ctxStatic}/layer-v2.3/layer/laydate/laydate.js"></script>
		
		
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="../assets/css/ace-part2.css" />
		<![endif]-->
		<link rel="stylesheet" href="${ctxStatic }/common/login/ace-rtl.css" />
		<style type="text/css">
		 .bound{
			    background-color: white;
			    background-color: rgba(255, 255, 255, 0.95);
			    border-radius: 40px;
			    } 

        ul, ul li
        {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        ul li.first
        {
            border-top: 1px solid #DFDFDF;
        }
        ul li.last
        {
            border: none;
        }
        ul p
        {
            float: left;
            margin: 0;
            width: 310px;
        }
        ul h3
        {
            float: left;
            font-size: 14px;
            font-weight: bold;
            margin: 5px 0 0 0;
            width: 200px;
            margin-left:20px;
        }
        ul li
        {
            border-bottom: 1px solid #DFDFDF;
            padding: 15px 0;
            width:600px;
            overflow:hidden;
        }
        ul input[type="text"], ul input[type="password"]
        {
            width:300px;
            padding:5px;
            position:relative;
            border:solid 1px #666;
            -moz-border-radius:5px;
            -webkit-border-radius:5px;
        }
        ul input.required 
        {
            border: solid 1px #f00;
        }

		</style>
		<title>${fns:getConfig('productName')} 登录</title>
		<script>
			if (window.top !== window.self) {
				window.top.location = window.location;
			}
		</script>
		<script type="text/javascript">
				$(document).ready(function() {
					$("#loginForm").validate({
						rules: {
							validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
						},
						messages: {
							username: {required: "请填写用户名."},password: {required: "请填写密码."},
							validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
						},
						errorLabelContainer: "#messageBox",
						errorPlacement: function(error, element) {
							error.appendTo($("#loginError").parent());
						} 
					});
				});
				// 如果在框架或在对话框中，则弹出提示并跳转到首页
				if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
					alert('未登录或登录超时。请重新登录，谢谢！');
					top.location = "${ctx}";
				}
		</script>
		<script type="text/javascript">

		$(document).ready(function() {
			if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
				width='auto';
				height='auto';
			}else{//如果是PC端，根据用户设置的width和height显示。
				width='700px';
				height='500px';
			}
			
			
			$("#inputForm").validate({
				rules: {
				loginName: {remote: "${ctx}/sys/user/validateLoginName"},
				mobile: {remote: "${ctx}/sys/user/validateMobile"},
				randomCode: {

					  remote:{

						   url:"${ctx}/sys/register/validateMobileCode", 
	
						  data:{
					       mobile:function(){
					          return $("#tel").val();
					          }
			          		} 

						}


					}
			},
				messages: {
					confirmNewPassword: {equalTo: "输入与上面相同的密码"},
					ck1: {required: "必须接受用户协议."},
					loginName: {remote: "此用户名已经被注册!", required: "用户名不能为空."},
					mobile:{remote: "此手机号已经被注册!", required: "手机号不能为空."},
					randomCode:{remote: "验证码不正确!", required: "验证码不能为空."}
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});

			$("#resetForm").validate({
				rules: {
				mobile: {remote: "${ctx}/sys/user/validateMobileExist"}
			},
				messages: {
					mobile:{remote: "此手机号未注册!", required: "手机号不能为空."}
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			// 手机号码验证
			jQuery.validator.addMethod("isMobile", function(value, element) {
			    var length = value.length;
			    var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
			    return (length == 11 && mobile.test(value));
			}, "请正确填写您的手机号码");



			$('#sendPassBtn').click(function () { 
				if($("#tel_resetpass").val()=="" || $("#tel_resetpass-error").text()!=""){
					top.layer.alert("请输入有效的注册手机号码！", {icon: 0});//讨厌的白色字体问题
					return;

				}
				$("#sendPassBtn").attr("disabled", true); 
				$.get("${ctx}/sys/user/resetPassword?mobile="+$("#tel_resetpass").val(),function(data){
						if(data.success == false){
							top.layer.alert(data.msg, {icon: 0});//讨厌的白色字体问题
							//alert(data.msg);
							$("#sendPassBtn").html("重新发送").removeAttr("disabled"); 
							clearInterval(countdown); 

						}

					});
				var count = 60; 
				var countdown = setInterval(CountDown, 1000); 
				function CountDown() { 
					$("#sendPassBtn").attr("disabled", true); 
					$("#sendPassBtn").html("等待 " + count + "秒!"); 
					if (count == 0) { 
						$("#sendPassBtn").html("重新发送").removeAttr("disabled"); 
						clearInterval(countdown); 
					} 
					count--; 
				}

				
			}) ;
			

			$('#sendCodeBtn').click(function () { 
				if($("#tel").val()=="" || $("#tel-error").text()!=""){
					top.layer.alert("请输入有效的注册手机号码！", {icon: 0});//讨厌的白色字体问题
					return;

				}
				$("#sendCodeBtn").attr("disabled", true); 
				$.get("${ctx}/sys/register/getRegisterCode?mobile="+$("#tel").val(),function(data){
						if(data.success == false){
							//top.layer.alert(data.msg, {icon: 0});讨厌的白色字体问题
							alert(data.msg);
							$("#sendCodeBtn").html("重新发送").removeAttr("disabled"); 
							clearInterval(countdown); 

						}

					});
				var count = 60; 
				var countdown = setInterval(CountDown, 1000); 
				function CountDown() { 
					$("#sendCodeBtn").attr("disabled", true); 
					$("#sendCodeBtn").html("等待 " + count + "秒!"); 
					if (count == 0) { 
						$("#sendCodeBtn").html("重新发送").removeAttr("disabled"); 
						clearInterval(countdown); 
					} 
					count--; 
				}

				
			}) ;
			
			$("#registProtocolBtn").click(function(){
				top.layer.open({
				    type: 1
				    ,area: [width, height]
				    ,title:"用户注册协议"
			    	,shade: 0.6 //遮罩透明度
				    ,content: ' <blockquote class="text-info" style="font-size:14px">用户注册协议 </blockquote>'
				}); 
			});
			
			$("#login-inboxClick").click(function(){
				$("#login-inbox").show();//show target
			});
			
			if($("#messageBox").val()!=null){
				$("#login-inbox").show();
			}
		 
	        });
		

		
	</script>
	</head>
	<body class="login-layout light-login">
		<div class="main-container">
			<div  class="center">
			  <sys:message content="${message}"/>  
			</div>
			<div  id="login-box" >							
						 <%@ include file="/webpage/modules/quotation/clientStaticLogin.jsp"%>  
			</div><!-- /.login-box  -->
 
			<div   class="center">
				<div id="signup-box" class="signup-box widget-box no-border bound">
					<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
						<div class="panel panel-default">
						<div class="panel-body">
								<h3><i class="ace-icon fa fa-users blue"></i> 用户注册</h3>
					     	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/register/registerUser" method="post" class="form-group form-horizontal">
							  <input  type="hidden" value="fc" name="roleName"><!-- 默认注册用户都是超级管理员   要修改滴-->
							  <fieldset>
							    <div class="control-group">
							      <label class="control-label" for="name">姓名</label>
							      <div class="controls">
						        	<span class="block input-icon input-icon-right">
											<input id="name" name="name" type="text" maxlength="20" minlength="2" class="form-control required" placeholder="您的真实姓名" />
											<i class="ace-icon fa fa-user"></i>
										</span>
							      </div>
							    </div>
							    <div class="control-group">
							      <label class="control-label" for="name">手机</label>
							      <div class="controls">
							        <span class="block input-icon input-icon-right">
																<input id="tel" name="mobile" type="text" value="" maxlength="11" minlength="11" class="form-control text-muted required isMobile"  placeholder="手机号"/>
																<i class="ace-icon fa fa-phone"></i>
															</span>
							      </div>
							    </div>
							    <div class="control-group">
							      <label class="control-label" for="name">验证手机</label>
							      <div class="controls">
							        <span class="block input-icon input-icon-right">
																	<input id="code" name="randomCode" type="text" value="" maxlength="4" minlength="4" width="40%" class="form-control required"  placeholder="验证码"/>
																	<button class="width-40 pull-right btn btn-sm btn-primary" type="button" id="sendCodeBtn"  >
																		<i class="ace-icon fa fa-lightbulb-o"></i>
																		<span class="bigger-110">获取验证码!</span>
																	</button>
																	<label id="code-error" class="error" for="code" style="display:none"></label>
															</span>
							      </div>
							    </div>
							    <div class="control-group">
							      <label class="control-label" for="email">个人邮箱</label>
							      <div class="controls">
							        <span class="block input-icon input-icon-right">
																<input id="userId" name="loginName" type="text" value="${user.loginName }" maxlength="50" minlength="3" class="form-control required" placeholder="您的手机或您的个人邮箱" />
																<i class="ace-icon fa fa-user"></i>
															</span>
							      </div>
							    </div>
							    <div class="control-group">
							      <label class="control-label" for="email">公司名全称</label>
							      <div class="controls">
							        <span class="block input-icon input-icon-right">
										<input id="cpName" name="company.name" type="text" maxlength="50" minlength="3" class="form-control required" placeholder="公司名全称" title="公司名全称用于展示在报价单【客户公司】"/>
										<i class="ace-icon fa fa-user"></i>
									</span>
							      </div>
							    </div>
							    <div class="control-group">
							      <label class="control-label" for="subject">公司邮箱</label>
							      <div class="controls">
							        <span class="block input-icon input-icon-right">
										<input id="cpMail" name="company.email" type="email" maxlength="50" minlength="3" class="form-control required" placeholder="您的公司邮箱用于收报价单"  title="报价单会往该地址发送"/>
										<i class="ace-icon fa fa-envelope"></i>
									</span>
							      </div>
							    </div>
							    <div class="control-group">
							      <label class="control-label" for="subject">公司地址</label>
							      <div class="controls">
							        <span class="block input-icon input-icon-right">
										<input id="cpAdd" name="company.address" type="text" maxlength="50"  class="form-control" placeholder="公司地址"/>
										<i class="ace-icon fa fa-envelope"></i>
									</span>
							      </div>
							    </div>
							    <div class="control-group">
							      <label class="control-label" for="subject">公司传真</label>
							      <div class="controls">
							        	<span class="block input-icon input-icon-right">
											<input id="cpFax" name="company.fax" type="text" maxlength="20" minlength="3" class="form-control" placeholder="您的公司邮传真" />
											<i class="ace-icon fa fa-fax"></i>
										</span>
							      </div>
							    </div>
<!-- 							    <div class="control-group">
							      <label class="control-label" for="message">个人邮箱地址</label>
							      <div class="controls">
							        <span class="block input-icon input-icon-right">
										<input id="cpMail" name="email" type="text" maxlength="50" minlength="3" class="form-control required" placeholder="个人邮箱地址" />
										<i class="ace-icon fa fa-envelope"></i>
									</span>
							      </div>
							    </div> -->
							    <div class="control-group">
							      <label class="control-label" for="message">密&nbsp;&nbsp;&nbsp;码</label>
							      <div class="controls">
							       		<span class="block input-icon input-icon-right">
											<input id="newPassword" name="password" type="password" value="" maxlength="20" minlength="3"  class="form-control required" placeholder="密码" />
											<i class="ace-icon fa fa-lock"></i>
										</span>
							      </div>
							    </div>
							    
							    <div class="control-group">
							      <label class="control-label" for="message">重复密码</label>
							      <div class="controls">
							        	<span class="block input-icon input-icon-right">
											<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="20" minlength="3" class="form-control required" equalTo="#newPassword" placeholder="重复密码" />
											<i class="ace-icon fa fa-retweet"></i>
										</span>
							      </div>
							    </div>
							    <div class="control-group">
							      <label class="block">
										<input name="ck1" type="checkbox" class="required ace" />
										<span class="lbl">
											我接受
											<a  id="registProtocolBtn" href="#">《用户注册协议》</a>
										</span>
										<label id="ck1-error" class="error" for="ck1" style="display: none;">必须接受用户协议</label>
									</label>
							    </div>
							    
	        					<div class="form-actions clearfix">
									<button type="reset" class="width-30 pull-left btn btn-sm">
										<i class="ace-icon fa fa-refresh"></i>
										<span class="bigger-110">重置</span>
									</button>
	
									<button type="submit" class="width-30 pull-right btn btn-sm btn-success">
										<span class="bigger-110">注册</span>
	
										<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
									</button>
								</div>
							  </fieldset>
							</form:form>
	   											<div class="form-options center">
													<br/>
													<br/>
													<a href="#" data-target="#login-box" class="">
														<font color=" #A73438"><i class="ace-icon fa fa-arrow-left"></i>
														返回登录
														</font>
													</a>
												</div>
					     
					    </div>
					    </div>
					</div>
				</div>
			</div>
			
			
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<div class="login-container">
							
							<div class="center">
 
							</div>

							<div class="space-6"></div>

							<div class="position-relative">
								<div id="login-box2" class="login-box  widget-box no-border bound">
									<div class="widget-body bound">
										<div class="widget-main bound">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-coffee green"></i>
												用户登录
											</h4>

											<div class="space-6"></div>

											<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text"  id="username" name="username" class="form-control required"  value="admin" placeholder="您的个人邮箱或手机号码"/>
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" id="password" name="password" value="admin" class="form-control required" placeholder="密码" />
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>
													<c:if test="${isValidateCodeLogin}">
														<div class="input-group m-b text-muted validateCode">
														<label class="input-label mid" for="validateCode">验证码:</label>
														<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:5px;"/>
														</div>
													</c:if>
													<div class="space"></div>

													<div class="clearfix">
														<label class="inline">
															<input  type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''} class="ace" />
															<span class="lbl"> 记住我</span>
														</label>

														<button type="submit" class="width-35 pull-right btn btn-sm btn-primary">
															<i class="ace-icon fa fa-key"></i>
															<span class="bigger-110">登录</span>
														</button>
													</div>

													<div class="space-4"></div>
														<div id="themeSwitch" class="dropdown">
															<a class="dropdown-toggle" data-toggle="dropdown" href="#">${fns:getDictLabel(cookie.theme.value,'theme','默认主题')}<b class="caret"></b></a>
															<ul class="dropdown-menu">
															  <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href"><font color="black">${dict.label}</font></a></li></c:forEach>
															</ul>
															<!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
														</div>
												</fieldset>
											</form>
											<!--  
											<div class="social-or-login center">
												<span class="bigger-110">Or Login Using</span>
											</div>

											<div class="space-6"></div>

											<div class="social-login center">
												<a class="btn btn-primary">
													<i class="ace-icon fa fa-facebook"></i>
												</a>

												<a class="btn btn-info">
													<i class="ace-icon fa fa-twitter"></i>
												</a>

												<a class="btn btn-danger">
													<i class="ace-icon fa fa-google-plus"></i>
												</a>
											</div>
											-->
											<br/>
											<br/>
											<div class="form-options clearfix">
											<div>
												<a href="#" data-target="#forgot-box" class="pull-left">
													<font color=" #007aff;"><i class="ace-icon fa fa-arrow-left"></i>
													忘记密码</font> 
												</a>
											</div>

											<div>
												<a href="#" data-target="#signup-box" class="pull-right user-signup-link">
													<font color=" #A73438">没有账号？注册 
													<i class="ace-icon fa fa-arrow-right"></i></font>
												</a>
											</div>
										</div>
										</div><!-- /.widget-main -->

										
									</div><!-- /.widget-body -->
								</div><!-- /.login-box -->

								<div id="forgot-box" class="forgot-box widget-box no-border bound">
									<div class="widget-body bound">
										<div class="widget-main bound">
											<h4 class="header red lighter bigger">
												<i class="ace-icon fa fa-key"></i>
												找回密码
											</h4>

											<div class="space-6"></div>
											<p>
												请输入您的注册手机号，您将会收到新的密码。
											</p>

											<form id="resetForm">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input id="tel_resetpass" name="mobile" type="tel" class="form-control  text-muted required isMobile" placeholder="请输入手机号" />
															<i class="ace-icon fa fa-envelope"></i>
														</span>
													</label>

													<div class="clearfix">
														<button id="sendPassBtn" type="button" class="width-35 pull-right btn btn-sm btn-danger">
															<i class="ace-icon fa fa-lightbulb-o"></i>
															<span class="bigger-110">发送!</span>
														</button>
													</div>
												</fieldset>
											</form>
											<div class="form-options center">
												<br/>
												<br/>
												<a href="#" data-target="#login-box" class="">
													<font color=" #A73438"><i class="ace-icon fa fa-arrow-left"></i>
													返回登录
													</font>
												</a>
											</div>
										</div><!-- /.widget-main -->

									</div><!-- /.widget-body -->
								</div><!-- /.forgot-box -->

							</div><!-- /.position-relative -->
							<div class="center">
							</div>
				
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.main-content -->
		</div><!-- /.main-container -->
		<!-- basic scripts -->

		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='../assets/js/jquery.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='../assets/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->

		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='../assets/js/jquery.mobile.custom.js'>"+"<"+"/script>");
		</script>
		<style>
		/* Validation */

			label.error {
			    color: #cc5965;
			    display: inline-block;
			    margin-left: 5px;
			}
			
			.form-control.error {
			    border: 1px dotted #cc5965;
			}
		</style>
	<!-- inline scripts related to this page -->
		<script type="text/javascript">
     	$(document).ready(function() {
			 $(document).on('click', '.form-options a[data-target]', function(e) {
				e.preventDefault();
				var target = $(this).data('target');
				$('.widget-box.visible').removeClass('visible');//hide others
				$(target).addClass('visible');//show target
				$("#login-inbox").removeClass('visible');//hide others
			 });
			});  
			
			
			
			
		</script>
	</body>
</html>

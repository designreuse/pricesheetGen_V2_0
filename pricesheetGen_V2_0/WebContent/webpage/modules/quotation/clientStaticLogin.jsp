<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" isErrorPage="true" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<html>
    <head>
        <title>报价单录入</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<style type="text/css">
			div{
				 font-family: 'Microsoft YaHei' ! important;
				 color:block  ! important;
			}
			table tr td{
				text-align: center;
			}
			
		 	/*模式窗体 
		 	.modalDialog { 
				position: fixed; 
				font-family: Arial, Helvetica, sans-serif; 
				top:0; 
				right:0; 
				bottom:0; 
				left:0; 
				background:rgba(0,0,0,0.8); 
				z-index:99999; 
				opacity:0;  
				-webkit-transition: opacity 400ms ease-in; 
				-moz-transition: opacity 400ms ease-in; 
				transition: opacity 400ms ease-in; 
				pointer-events: none; 
			} 
			.modalDialog:target { 
				opacity:1; 
				pointer-events: auto; 
			} 
			.modalDialog > div { 
				width:450px; 
				position: relative; 
				margin:10% 30% 0% 15%;
				padding:10px 20px 13px 0px; 
				border-radius:10px; 
				background:#fff; 
				background: -moz-linear-gradient(#fff, #999); 
				background: -webkit-linear-gradient(#fff, #999); 
				background: -o-linear-gradient(#fff, #999); 
			}	 */
		</style>
 
<script type="text/javascript">
$(function(){
	$(".loginInboxClick").click(function(){
		$("#signupBox").hide("slow");
		$("#loginIndex").show("1500");
		
	});
	$(".signupInboxClick").click(function(){
		$("#loginIndex").hide("slow");
		$("#signupBox").show("1500");
	});
	 $("#container").height($(document.body).height());
     //改变div的宽度
     $("#container").click(function(){
    	 $("#signupBox").hide("slow");
    	 $("#loginIndex").hide("slow");
     })
})
</script>
 	
<body bgcolor="white" style="background-color:white " id="body">
	<div>
	<!--模式窗体  -->
	<%--<a href="#openModal">登录</a> 
	<div id="openModal"class="modalDialog">
			<div>
				<div><a href="#close" title="Close"class="close">X</a></div>
				<div style="height:150px;">
					<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
						<fieldset>
						<div class="form-group" style="margin-bottom:5px;height:25px;">
						<label class="col-sm-4" style="text-align: right;line-height:25px;">账户：</label>
						<div class="col-sm-8"  style="height:25px;">
									<span class="block input-icon input-icon-right">
									<input type="text" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center"  id="username" name="username" class="form-control required"  value="admin" placeholder="您的个人邮箱或手机号码"/>
									<i class="ace-icon fa fa-user"></i>
									</span> 
									</div>
						</div>
						<div class="form-group"  style="margin-bottom:5px;height:25px;"> 
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">密码： </label>
							<div class="col-sm-8"   style="height:25px;text-align: left;">
								<span class="block input-icon input-icon-right">
									<input type="password"  style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center" id="password" name="password" value="admin" class="form-control required" placeholder="密码" />
									<i class="ace-icon fa fa-lock"></i>
								</span>
							 </div>
						</div>
						<div class="form-group"  style="margin-bottom:5px;height:25px;"> 
							<c:if test="${isValidateCodeLogin}">
								<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;" for="validateCode">验证码:</label>
									<div class="col-sm-8"   style="height:25px;text-align: left;">
											<sys:validateCode  name="validateCode" inputCssStyle="margin-bottom:5px;height:25px;width: 95%;border: 0px;border-bottom: 1px solid;text-align: center"/>
									</div>
							</c:if>
						</div>
							<div class="form-group"  style="margin-bottom:5px;height:25px;"> 
								<label class="col-sm-3 control-label" style="text-align: right;line-height:25px;">
									<input  type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''} class="ace" />
									<span class="lbl"> 记住我</span>
								</label>
								<div class="col-sm-6"   style="height:30px;text-align: left;">
									<button type="submit" class="width-100 pull-center" style="background-color: red;border: 0px;	border-radius:5px; height:100% " >
										<i class="ace-icon fa fa-key"></i>
										<span  >登录</span>
									</button>
								</div>
								<label class="col-sm-3 control-label" style="text-align: right;line-height:25px;">
									 注册
								</label>
							</div>			
					</fieldset>
				</form>
			</div>
		</div>
	</div> --%>
	<div class="col-sm-2"></div>
	<div class="col-sm-8">
		<div  class="col-sm-7" style="height:100px;line-height:100px;text-align:left;"><img src="${ctxStatic }/common/login/images/logo.png" style="width:280px"></div>
		<div  class="col-sm-5" style="height:100px;line-height:100px;text-align:center;"><img src="${ctxStatic }/common/login/images/image005.png" style="width:200px"></div>
	</div>
</div>
<div id="container" style="position: absolute !important;top:0px;left: 0px;z-index:2;width:100%;"></div>
<div class="col-sm-12">
	<div class="col-sm-2"></div>
	<div class="col-sm-8">
		    <div id="headDivId" >    
		        <div style="width: 100%;">
		        	<div  style="height:25px;line-height:25px; background-color:#008080;text-align: left;width:43.5%;font-weight: bold;margin-bottom:3px;z-index:2;position: absolute !important;top:0px;left: 15px;">
		        			尊敬的客户，您好！兹对贵司需求报价如下：
		        			<a  class="loginInboxClick" href="javascript:void(0)" style="color:red;font-weight:bold;"> 登录/ </a>
		               		<a   class="signupInboxClick" href="javascript:void(0)" style="color:red;font-weight:bold;" >注册</a>
		            </div>
		         </div>
		         <div  style="width:50%;" >
			        	<div id="loginIndex" hidden="false" style="width:60%;position: absolute !important;top:0px;left: 15px;z-index:4;	box-shadow: 2px 4px 6px #000;background:#fff; 
				background: -moz-linear-gradient(#fff, #999); 
				background: -webkit-linear-gradient(#fff, #999); 
				background: -o-linear-gradient(#fff, #999); padding-top:20px;">
							<form:form  id="loginForm" class="form-group form-horizontal" action="${ctx}/login" method="post">
								<fieldset>
									<legend>登录</legend>
									<div class="form-group" style="margin-bottom:5px;">
								        <label class="col-sm-3" style="text-align: right;line-height:25px;">账户：</label>
								        <div class="col-sm-8"  style="height:25px;">
								        		<span class="block input-icon input-icon-right">
													<input type="text" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center"  id="username" name="username" class="form-control required"  value="admin" placeholder="您的个人邮箱或手机号码"/>
													<i class="ace-icon fa fa-user"></i>
												</span> 
								        </div>
								    </div>
								    <div class="form-group" style="margin-bottom:5px;">
								        <label class="col-sm-3" style="text-align: right;line-height:25px;">密码：</label>
								        <div class="col-sm-8"  style="height:25px;">
								        		<span class="block input-icon input-icon-right">
													<input type="password"  style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center" id="password" name="password" value="admin" class="form-control required" placeholder="密码" />
													<i class="ace-icon fa fa-lock"></i>
												</span> 
								        </div>
								    </div>
									 <div class="form-group" style="margin-bottom:5px;">
									 	<c:if test="${isValidateCodeLogin}">
									        <label class="col-sm-3" style="text-align: right;line-height:25px;">验证码:</label>
									        <div class="col-sm-8"  style="height:25px;">
									        		<sys:validateCode  name="validateCode" inputCssStyle="margin-bottom:5px;height:25px;width: 35%;border: 0px;border-bottom: 1px solid;text-align: center"/>
									        </div>
								        </c:if>
								    </div>
									<div class="form-group"  style="margin-bottom:5px;">
										<label class="col-sm-6" style="text-align: right;line-height:25px;">
											<input  type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''} class="ace" />
											<span class="lbl">记住我</span>
										</label>
										<label class="col-sm-6" style="text-align: left;line-height:25px;">
											<a  class="signupInboxClick" style="background-color:#bdbdbd ;border-radius:5px; height:100% " > 注册</a>
										</label>
									</div>	
									<div class="form-group"  style="margin-bottom:5px;margin-bottom: 20px;"> 
										<div class="col-sm-12"   style="height:30px;text-align: center;">
											<button type="submit" style="background-color: red;border: 0px;	border-radius:5px; height:100%;width: 60% " >
												<i class="ace-icon fa fa-key"></i>
												<span>登录</span>
											</button>
										</div>
									</div>
							     </fieldset>
							</form:form> 
						</div>
						<div id="signupBox" hidden="false" style="width:60%;position: absolute !important;top:0px;left: 15px;z-index:4;	box-shadow: 2px 4px 6px #000;background:#fff; 
				background: -moz-linear-gradient(#fff, #999); 
				background: -webkit-linear-gradient(#fff, #999); 
				background: -o-linear-gradient(#fff, #999); padding-top:10px;">
								     	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/register/registerUser" method="post" class="form-group form-horizontal">
										  <input  type="hidden" value="fc" name="roleName"><!-- 默认注册用户都是超级管理员   要修改滴-->
										  <fieldset>
										  	<legend>注册</legend>
										    <div class="form-group"  style="margin-bottom:5px;"> 
										      <label class="col-sm-3" style="text-align: right;line-height:25px;">姓名</label>
										      <div class="col-sm-8">
									        	<span class="block input-icon input-icon-right">
														<input id="name" name="name" type="text" maxlength="20" minlength="2" class="form-control required" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center" placeholder="您的真实姓名" />
														<i class="ace-icon fa fa-user"></i>
												</span>
										      </div>
										    </div>
										    <div class="form-group"  style="margin-bottom:5px;"> 
										      <label class="col-sm-3" style="text-align: right;line-height:25px;">手机</label>
										      <div class="col-sm-8">
										        <span class="block input-icon input-icon-right">
													<input id="tel" name="mobile" type="text" value="" maxlength="11" minlength="11" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center" class="form-control text-muted required isMobile"  placeholder="手机号"/>
													<i class="ace-icon fa fa-phone"></i>
												</span>
										      </div>
										    </div>
										    <div class="form-group"  style="margin-bottom:5px;"> 
										      <label class="col-sm-3" style="text-align: right;line-height:25px;">验证手机</label>
										      <div class="col-sm-8">
										        <span class="block input-icon input-icon-right">
														<input id="code" name="randomCode" type="text" value="" maxlength="4" minlength="4"  style="height:25px;width: 40%;border: 0px;border-bottom: 1px solid;text-align: center"  class="form-control required"  placeholder="验证码"/>
														<button style="height: 100%;text-align: center;background-color: #bdbdbd;border: 0px;border-radius:2px;margin-left:30px;" type="button" id="sendCodeBtn"  >
															<i class="ace-icon fa fa-lightbulb-o"></i>
															<span class="bigger-110">获取验证码!</span>
														</button>
														<label id="code-error" class="error" for="code" style="display:none"></label>
												</span>
										      </div>
										    </div>
										    <div class="form-group"  style="margin-bottom:5px;"> 
										      <label class="col-sm-3" style="text-align: right;line-height:25px;">个人邮箱</label>
										       <div class="col-sm-8">
										        <span class="block input-icon input-icon-right">
																			<input id="userId" name="loginName" type="text" value="${user.loginName }" maxlength="50" minlength="3" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center" class="form-control required" placeholder="您的手机或您的个人邮箱" />
																			<i class="ace-icon fa fa-user"></i>
																		</span>
										      </div>
										    </div>
										    <div class="form-group"  style="margin-bottom:5px;"> 
										     <label class="col-sm-3" style="text-align: right;line-height:25px;">公司名全称</label>
										      <div class="col-sm-8">
										        <span class="block input-icon input-icon-right">
													<input id="cpName" name="company.name" type="text" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center" maxlength="50" minlength="3" class="form-control required" placeholder="公司名全称" title="公司名全称用于展示在报价单【客户公司】"/>
													<i class="ace-icon fa fa-user"></i>
												</span>
										      </div>
										    </div>
										    <div class="form-group"  style="margin-bottom:5px;"> 
										      <label class="col-sm-3" style="text-align: right;line-height:25px;">公司邮箱</label>
										      <div class="col-sm-8">
										        <span class="block input-icon input-icon-right">
													<input id="cpMail" name="company.email" type="email" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center" maxlength="50" minlength="3" class="form-control required" placeholder="您的公司邮箱用于收报价单"  title="报价单会往该地址发送"/>
													<i class="ace-icon fa fa-envelope"></i>
												</span>
										      </div>
										    </div>
										    <div class="form-group"  style="margin-bottom:5px;"> 
										      <label class="col-sm-3" style="text-align: right;line-height:25px;">公司地址</label>
										       <div class="col-sm-8">
										        <span class="block input-icon input-icon-right">
													<input id="cpAdd" name="company.address" type="text" maxlength="50" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center"  class="form-control" placeholder="公司地址"/>
													<i class="ace-icon fa fa-envelope"></i>
												</span>
										      </div>
										    </div>
										     <div class="form-group"  style="margin-bottom:5px;"> 
										      <label class="col-sm-3" style="text-align: right;line-height:25px;">公司传真</label>
										      <div class="col-sm-8">
										        	<span class="block input-icon input-icon-right">
														<input id="cpFax" name="company.fax" type="text" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center" maxlength="20" minlength="3" class="form-control" placeholder="您的公司邮传真" />
														<i class="ace-icon fa fa-fax"></i>
													</span>
										      </div>
										    </div>
										    <div class="form-group"  style="margin-bottom:5px;"> 
										     	<label class="col-sm-3" style="text-align: right;line-height:25px;">密&nbsp;&nbsp;&nbsp;码</label>
										      	<div class="col-sm-8">
										       		<span class="block input-icon input-icon-right">
														<input id="newPassword" name="password" type="password" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center" value="" maxlength="20" minlength="3"  class="form-control required" placeholder="密码" />
														<i class="ace-icon fa fa-lock"></i>
													</span>
										      </div>
										    </div>
										     <div class="form-group"  style="margin-bottom:5px;"> 
										       <label class="col-sm-3" style="text-align: right;line-height:25px;">重复密码</label>
										       <div class="col-sm-8">
										        	<span class="block input-icon input-icon-right">
														<input id="confirmNewPassword" name="confirmNewPassword" style="height:25px;width: 90%;border: 0px;border-bottom: 1px solid;text-align: center"  type="password" value="" maxlength="20" minlength="3" class="form-control required" equalTo="#newPassword" placeholder="重复密码" />
														<i class="ace-icon fa fa-retweet"></i>
													</span>
										      </div>
										    </div>
										    <div class="form-group"  style="margin-bottom:5px;"> 
										       <label class="col-sm-12" style="text-align: right;line-height:25px;">
													<input name="ck1" type="checkbox" class="required ace" />
													<span class="lbl">
														我接受
														<a  id="registProtocolBtn" href="#">《用户注册协议》</a>
													</span>
													<label id="ck1-error" class="error" for="ck1" style="display: none;">必须接受用户协议</label>
												</label>
										    </div>
										    
				        					 <div class="form-group"  style="margin-bottom:5px;text-align: center"> 
												<button type="reset" class="width-30  btn btn-sm">
													<i class="ace-icon fa fa-refresh"></i>
													<span class="bigger-110">重置</span>
												</button>
												<button type="submit" class="width-30  btn btn-sm btn-success">
													<span class="bigger-110">注册</span>
				
													<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
												</button>
											</div>
										  </fieldset>
										</form:form>
				   						<div class="form-options center">
											 <a href="#" class="loginInboxClick">
												 <font color=" #A73438"><i class="ace-icon fa fa-arrow-left"></i>
													 返回登录
												 </font>
											</a>
									 </div>
						</div>
					</div>
		        <div class="col-sm-6">
		        	<div class="col-sm-12" >
		        		<div class="form-group" style="margin-bottom:5px;height:25px;">
					        <label class="col-sm-4" style="text-align: right;line-height:25px;">至：	</label>
					        <div class="col-sm-8"  style="height:25px;">
									<div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;">小强</div>
					        </div>
					    </div>
						<div class="form-group"  style="margin-bottom:5px;height:25px;"> 
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">客户公司：</label>
							<div class="col-sm-8"   style="height:25px;text-align: left;">
									<div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;"></div>
					        </div>
						</div>	
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">联系电话：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
									<div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;"></div>
					        </div>
						</div>		
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">联系传真：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
									<div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;"></div>
					        </div>
						</div>		
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label"  style="text-align: right;line-height:25px;">报价关于：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
									<div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;">办公设备</div>
					        </div>
						</div>
					</div>
		        </div>
		        <div class="col-sm-6"  >
		        	<div class="col-sm-12" style="text-align:right;margin-left:50px;">
		        		<div class="form-group" style="margin-bottom:5px;height:25px;">
					        <label class="col-sm-4" style="text-align: right;line-height:25px;">报价日期：</label>
					        <div class="col-sm-8"  style="height:25px;text-align: left;">
					        	<div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;">2017-07-04</div>
					        </div>
					    </div>
						<div class="form-group"  style="margin-bottom:5px;height:25px;"> 
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">报价单号：</label>
							<div class="col-sm-8"   style="height:25px;text-align: left;">
								<div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;">D12D21DBK21DKSNDDSVYD9</div>	
							 </div>
						</div>	
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">结算币种：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
								 <div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;">人民币(RMB)</div>	
					        </div>
						</div>		
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">付款方式：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
								<div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;">支票</div>	
					        </div>
						</div>		
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label"  style="text-align: right;line-height:25px;">销售人员：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
								<div  style="height:25px;text-align: center;width:95%; border-bottom: 1px solid;">李四</div>	
					        </div>
						</div>
					</div>
		        </div>
		    </div>
		  
		    <div id='mainDivId' >
		        <table width="100%" > 
		        	<tr height="30px; "><th></th></tr>
		            <tr style="background-color:#008080;color:black;">
		                <th style="text-align:left;width:100%;padding-left:16px;">项目总价</th>
		            </tr>
		        </table>
		        <table width="100%" id="tab" style="text-align:center;" border="1"	>
		             <tr>
		                 <td style="text-align: left;">一、电脑</td>
		                 <td style="width:10%;">RMB</td>
		                 <td style="width:25%;">23,680.00  </td>
		             </tr>
		              <tr>
		                 <td style="text-align: left;">二、服务</td>
		                 <td style="width:10%;">RMB</td>
		                 <td style="width:25%;">50.00</td>
		             </tr>
		        </table>
		        <div id='area_sumAmount' style="width:100%;" >
		            <table width="100%"   style="text-align:center;">  
		                <tr >
		                    <td style="text-align:right;width:75%;border-left:1px solid black;height:30px;" >项目总价(RMB):</td>
							<td style="text-align:right;border-right:1px solid black;">23,730.00</td>
		                </tr>  
						<tr >						
						   <td style="text-align:right;border-left:1px solid black;">优惠(RMB):</td>
						   <td style="text-align:right;border-right:1px solid black;">
								0.00  
		                   </td>
						</tr>   
						<tr >		                
							<td style="text-align:right;border:1px solid black;border-top: 0px;border-right: 0px;">最终价格(RMB):</td>
		                    <td style="text-align:right;border:1px solid black;border-top: 0px;border-left: 0px;">¥23,730.00</td>
		                </tr>
		            </table>
		            <div style="display:inline">
		                <div style="width:65%;border:1px solid #FFF;float:left"></div>
		                <div style="width:15%;border:1px solid #FFF;float:left" id="finalAmt">23,730.00</div>
		            </div>
		        </div>
		    </div> 
		    <div id='subDivId'>
		    	<table  border="1" width="100%">
		    		<tr>
		    			<td style="background-color:#008080;color:black;padding-left:16px;" colspan="7">一、电脑 </td>
		    		</tr>
		    		<tr>
		    			<td width="5%">序号</td>
		    			<td width="15%">产品名称</td>
		    			<td width="50%">产品描述</td>
		    			<td width="5%">单位</td>
		    			<td width="5%">数量</td>
		    			<td width="10%">单价(人民币)</td>
		    			<td width="10%">金额(人民币)</td>
		    		</tr>
		    		<tr>
		    			<td>1.1</td>
		    			<td>办公电脑</td>
		    			<td>惠普 HP ProDesk 600 G1 SFF 纤小型 商用台式机电脑 标配主机(不含显示器) I3-4160 4G 500G 集显 DVD W7</td>
		    			<td>套</td>
		    			<td>2</td>
		    			<td>3,300.00</td>
		    			<td>6,600.00</td>
		    		</tr>
		    		<tr>
		    			<td>1.2</td>
		    			<td>办公显示器</td>
		    			<td>HP V201 19.45 英寸 LED 背光液晶显示器 (E6W38AA) 商用显示器</td>
		    			<td>套</td>
		    			<td>2</td>
		    			<td>840.00</td>
		    			<td>1,680.00</td>
		    		</tr>
		    		<tr>
		    			<td>1.3</td>
		    			<td>设计工作站</td>
		    			<td>惠普（HP）Z230SFF L9W20PA工作站 (I7-4771/16GB/2TB/DVDRW/DOS)</td>
		    			<td>套</td>
		    			<td>2</td>
		    			<td>6,050.00</td>
		    			<td>12,100.00  </td>
		    		</tr>
		    		<tr>
		    			<td>1.4</td>
		    			<td>设计显示器</td>
		    			<td>惠普（HP)v272 27英寸宽屏广视角LED背光液晶电脑显示器</td>
		    			<td>套</td>
		    			<td>2</td>
		    			<td>1,650.00</td>
		    			<td>3,300.00</td>
		    		</tr>
		    		<tr>
		    			<td colspan="7"><label style="width:80%;text-align: right;">小计：</label><label style="width:20%;text-align: right;"> 23,680.00 </label> </td>
		    		</tr>
		    	</table>
		    	<table width="100%" border="1">
		    		<tr>
		    			<td style="background-color:#008080;color:black;padding-left:16px;" colspan="7">一、电脑 </td>
		    		</tr>
		    		<tr>
		    			<td width="5%">序号</td>
		    			<td width="15%">产品名称</td>
		    			<td width="50%">产品描述</td>
		    			<td width="5%">单位</td>
		    			<td width="5%">数量</td>
		    			<td width="10%">单价(人民币)</td>
		    			<td width="10%">金额(人民币)</td>
		    		</tr>
		    		<tr>
		    			<td>2.1</td>
		    			<td>物流费</td>
		    			<td>外环内，下一工作日到货</td>
		    			<td>EA</td>
		    			<td>1</td>
		    			<td>50.00</td>
		    			<td>50.00</td>
		    		</tr>
		    		<tr>
		    			<td>2.2</td>
		    			<td>上门安装费</td>
		    			<td>工程师上门安装</td>
		    			<td>人天</td>
		    			<td>0</td>
		    			<td>600.00</td>
		    			<td>0</td>
		    		</tr>
		    		<tr>
		    			<td colspan="7">
		    				<div><label style="width:80%;text-align: right;">小计：</label><label style="width:20%;text-align: right;"> 50.00</label></div>
		    				<div><label style="width:80%;text-align: right;">总计：</label><label style="width:20%;text-align: right;">23,730.00</label></div>
		    			</td>
		    		</tr>
		    	</table>
		    </div>
		    <div>
		    	<div class="col-sm-7" style="margin-top:20px;">
		    		<div style="text-align: left;font-weight: bold;">备注：</div>
		    		<div style="text-align: left;padding-left:20px;">1、报价均已含税（产品开具17%增值税发票，服务开具6%增值税发票）</div>
		    		<div style="text-align: left;padding-left:20px;">2、报价有效期：5个工作日</div>
		    		<div style="text-align: left;padding-left:20px;" id="arrivalDays">3、到货时间：报价单签字确认回传合同签订后 <input type=text  name="arrivalDays" value="5" readonly="readonly" style="width:50px;align:center;height:20px;line-height: 20px;border: 0px;border-bottom: 1px solid;" />个工作日</div>
		    		<div style="text-align: left;padding-left:20px;">4、付款期限：</div>
		    		<div style="text-align: left;padding-left:100px;">√款到发货。</div>
		    		<div style="text-align: left;padding-left:100px;">□货到    工作日（现金、支票、转账）付款。  </div>
		    		<div style="text-align: left;padding-left:100px;">□其他<input type="text" id="otherChoice" readonly="readonly" name="otherChoice" style="width:300px;height:20px;line-height: 20px;border: 0px;border-bottom: 1px solid;" />。  </div>
		    	</div>
		    	<div class="col-sm-5">
		    		<div style="text-align: left;font-weight: bold;font-size: 22px;padding-top:50px;">客户签名(签章):</div>
		    		<div style="text-align: left;padding-top:75px"><hr style="height:3px;border:none;border-top:3px double black;" /></div>
		    	</div>
		    </div>
		    <div>
				<div class="col-sm-12" style="height:25px;"><hr style="height:3px;border:none;border-top:3px double black;" /></div>
			</div>
			<div>
			    <div class="col-sm-7" >
					<div style="text-align:left">地址:上海市杨浦区黄兴路1号中通大厦1楼北侧铺(眉州支路92-96号)</div>
					<div style="text-align:left">电话:021-65435161<label style="width:30px;"> </label>传真:65435240</div>
					<div style="text-align:left">手机	13311763209<label style="width:30px;"> </label> E-mail：gongquan.xie@sh-sapling.com</div>
					<div><br><br></div>
					<div style="text-align:left">开户名称：上海小树信息技术有限公司</div>
					<div style="text-align:left">收款银行：中国银行上海市五角场支行</div>
					<div style="text-align:left">收款账号：457265792109</div>
				</div> 
				<div class="col-sm-5" >
					<div style="font-weight: bold;font-size: 22px;">Best Regards!</div>
					<div style="font-weight: bold;font-size: 25px;height:80px;line-height:80px;">李四</div>
					<div style="height:3px;"><hr style="height:3px;border:none;border-top:3px double black;" /></div>
					<div>如有任何疑问请即时与我联系!</div>
				</div> 
			</div>
	</div>
	<div class="col-sm-2"></div>
</div>
<div >


</div>

<script type="text/javascript">
// 初始化客户信息
$("#custName").val('${custName}');         // 客户公司  custName
$("#company").val('${company}');           // 客户公司  company
$("#companyPhone").val('${companyPhone}'); // 联系电话  companyPhone
$("#companyFax").val('${companyFax}');     // 联系传真  companyFax

var curStdFmtDate = getNowFormatDate(); // 设置当前报价日期
$("#quotationDateStr").val(curStdFmtDate);


$("#settlementType").change(function() { currencyChange();}); // 绑定币种选择
     
// 绑定服务组优惠金额事件
$("input[name=privilegeAmt]").bind("blur", function(){

    var withTaxAmt = $("#mainDivId").find("#area_sumAmount").find("#withTaxAmt").text();
    var _withTaxAmt = 0;

    if (0 == withTaxAmt.length || isNaN(withTaxAmt)) 
    {
        alert("请先录入商品！");
        $(this).val(0);
        return;
    } else 
    {
        _withTaxAmt = parseFloat(withTaxAmt);
    }

    var _discountAmount = 0
    if (isNaN($(this).val())) { 
        $(this).val(0);
    } else 
    {
        _discountAmount = $(this).val();
    }         

    var _dealAmt = 0;
    _dealAmt =  _withTaxAmt - _discountAmount;        
    if (0 > _dealAmt) {
        alert("优惠金额不能大于商品总金额！");
        $(this).val(0);
        return;
    } else if (isNaN(_dealAmt)) {
        alert("优惠金额不能大于商品总金额！！！");
        return;
    }
    
    $("#mainDivId").find("#area_sumAmount").find("#dealAmt").html(_dealAmt.toFixed(2));
    $("#mainDivId").find("#area_sumAmount").find("#finalAmt").html(_dealAmt.toFixed(2));
});


// 提交核价
$("#submitPriceSheet").click(function()
{
    if(!chkEssentialInput()) {
        return;
    }

    var quotationOrder = getPriceSheetJson();
    quotationOrder.transType = "002";    

    $.ajax({
        type:'POST',
        data: JSON.stringify(quotationOrder),   
        contentType :'application/json',
        dataType:'json',     
        url :'${ctx}/quotation/quotationOrder/save',
        async: false,
        headers:
        {
            Accept:'application/json', 'Content-Type': 'application/json'
        },
        success :function(obj) 
        {
        	data = obj.body;
            if (null != data && "0" == data.state) 
            {
                alert("【报价单保存失败】\n" + data.msg);                
            } else if (null != data && "1" == data.state) 
            {
                alert("【报价单保存成功】\n" + data.msg);
                $("#headDivId").find("input[name=quotationCode]").val(data.quotationCode);
            } else 
            {
                alert("【报价单提交失败】\n 数据处理异常，保存报价单失败！！！");       
            }
        },
        error :function(e) 
        {
            alert("报价单保存异常！！！");
        }
    });
});


//直接提交报价单
$("#submitPriceSheetDirect").click(function()
{
    if(!chkEssentialInput()) {
        return;
    }

    var quotationOrder = getPriceSheetJson();
    quotationOrder.transType = "001";

    $.ajax(
    {
        type:'POST',
        data: JSON.stringify(quotationOrder),
        contentType :'application/json',
        dataType:'json',
        url :'${ctx}/quotation/quotationOrder/save',
        async: false,
        success :function(obj) 
        {
        	data = obj.body;
            if (null != data && "0" == data.state) 
            {
                alert("【报价单保存失败】\n" + data.msg);                
            } else if (null != data && "1" == data.state) 
            {
                alert("【报价单保存成功】\n" + data.msg);
                $("#headDivId").find("input[name=quotationCode]").val(data.quotationCode);
            } else 
            {
                alert("【报价单提交失败】\n 数据处理异常，保存报价单失败！！！");       
            }
        },
        error :function(e) {
            alert("报价单保存异常！！！");
        }
    });
});
</script>


</body>
</html>
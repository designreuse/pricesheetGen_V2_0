<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<style type="text/css">
 .col-sm-half {
    width: 46%;
  }
  .amtTop
	{mso-style-parent:style18;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:black gray-25;}
	
  	.topAutoInputStyle
	{mso-style-parent:style18;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:black gray-25;}
	
  	.topLabelStyle
	{mso-style-parent:style16;
	color:windowtext;
	font-size:10.0pt;
	text-align:left;
	font-weight:700;
	/* font-family:黑体, monospace; */
	mso-font-charset:134;
	mso-number-format:"\\$\#\,\#\#0\.00_\)\;\[Red\]\\\(\\$\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:black gray-25;}
	
	.blueBar
	{mso-style-parent:style18;
	color:white;
	font-size:10.0pt;
	/* font-family:宋体; */
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:teal;
	mso-pattern:black gray-25;}
	
	.cxwzwStyle
	{mso-style-parent:style18;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	/* font-family:宋体; */
	mso-generic-font-family:auto;
	mso-font-charset:134;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	background:#FFFFCC;
	mso-pattern:black gray-25;}
	
	.buttonNameStyle
	{mso-style-parent:style16;
	color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-family:楷体, monospace;
	mso-font-charset:134;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:black gray-25;
	mso-protection:unlocked visible;}
	
	.BestRegards
		{mso-style-parent:style16;
		color:windowtext;
		font-size:14.0pt;
		font-weight:700;
		font-family:宋体;
		mso-generic-font-family:auto;
		mso-font-charset:134;
		text-align:center;
		vertical-align:middle;
		border-top:2.0pt double windowtext;
		border-right:none;
		border-bottom:none;
		border-left:none;
		mso-background-source:auto;
		mso-pattern:black gray-25;}	
		
	.font44
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:黑体, monospace;
	mso-font-charset:134;}
</style>
<head>
<title>报价单管理系统 | 报价单添加</title>
<tags:head_common_content />
<!-- <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.0.0.js" type="text/javascript"></script> -->
<script src="${assets}/jquery/jquery-1.4.2.min.js"></script>

 


</head>
<body class="hold-transition skin-blue-light sidebar-mini">
	<div class="wrapper">
		<!-- Main header -->
		<tags:main_header />

		<!-- Left side column. contains the logo and sidebar -->
		<tags:main_sidebar active="unitAdd" />

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<div class="context-tips">
				<tags:action_tip />
			</div>
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>报价单添加</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 主页</a></li>
					<li><a href="#">报价单管理</a></li>
					<li class="active">报价单添加</li>
				</ol>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="box box-primary ">
					<div class="box-header with-border">
						<h3 class="box-title">
							<i class="fa fa-plus"></i> 报价新增
						</h3>
					</div>
					<div class="row ">
						<div class="col-sm-1"> </div>
						<div class="col-sm-10"> 
					<!-- /.box-header -->
						<table border="0" cellpadding="0" cellspacing="0" width="800" style="border-collapse:collapse;table-layout:fixed;min-width:750pt">
				<tbody><tr height="42" style="mso-height-source:userset;height:31.5pt">
				  <td height="42" width="32" style="height:31.5pt;width:24pt" align="left" valign="top"> 
				  	<span style="mso-ignore:vglayout;
				  position:absolute;z-index:2;margin-left:10px;margin-top:5px;width:333px;
				  height:73px"><img width="333" height="73" src="/platform/image/fax/image002.png" alt="说明: cid:image001.gif@01CDD49C.63E3C2B0" v:shapes="图片_x0020_4"></span><!--[endif]--><span style="mso-ignore:vglayout2">
				  <table cellpadding="0" cellspacing="0">
				   <tbody><tr>
				    <td height="42" class="xl70" width="32" style="height:31.5pt;width:24pt"></td>
				   </tr>
				  </tbody></table>
				  </span></td>
				  <td colspan="8" rowspan="2" class="xl192" width="404" style="width:305pt"><span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  </span>&nbsp;  &nbsp;</td>
				  <td colspan="2" rowspan="2" height="84" width="283" style="height:63.0pt;width:213pt" align="left" valign="top"><span style="mso-ignore:vglayout;
				  position:absolute;z-index:1;margin-left:45px;margin-top:2px;width:227px;
				  height:78px"><img width="227" height="78" src="/platform/image/fax/image005.png" v:shapes="Group_x0020_37 Rectangle_x0020_2 Rectangle_x0020_3"></span><!--[endif]--><span style="mso-ignore:vglayout2">
				  <table cellpadding="0" cellspacing="0">
				   <tbody><tr>
				    <td colspan="2" rowspan="2" height="84" class="xl193" width="283" style="height:63.0pt;
				    width:213pt"></td>
				   </tr>
				  </tbody></table>
				  </span></td>
				  
				 </tr>
				 <tr height="42" style="mso-height-source:userset;height:31.5pt">
				  <td height="42" class="xl72" style="height:31.5pt"><span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
				  
				 </tr>
				 <tr height="10" style="mso-height-source:userset;height:7.5pt">
				  <td height="10" class="xl72" style="height:7.5pt" colspan="11"></td>
				
				 </tr>
				 <tr height="19" style="height:14.25pt">
				  <td colspan="8" height="19" class="blueBar" style="height:14.25pt">尊敬的客户，您好！兹对贵司需求报价如下：</td>
				  <td class="xl75"></td>
				  <td class="xl75"></td>
				  <td class="xl72"></td>
				  
				 </tr>
				 <tr height="19" style="height:14.25pt">
				  <td height="19" class="xl185" dir="LTR" style="height:14.25pt"></td>
				  <td class="topLabelStyle"><span >&nbsp;&nbsp;&nbsp;
				  </span>至：</td>
				  <td colspan="7" class="topAutoInputStyle">${data.custName}</td>
				  
				  
				  <td class="topLabelStyle">报价日期：</td>
				  <td class="topAutoInputStyle"><fmt:formatDate value="${data.quotationDate}" pattern="yyyy/MM/dd"/></td>
				  
				 </tr>
				 <tr height="19" style="height:14.25pt">
				  <td height="19" class="xl185" dir="LTR" style="height:14.25pt"></td>
				  <td class="topLabelStyle">客户公司：</td>
				  <td colspan="7" class="topAutoInputStyle">${data.company}</td>
				  
				  
				  <td class="topLabelStyle">报价单号：</td>
				  <td  class="topAutoInputStyle">${data.quotationCode}</td>
				  
				 </tr>
				 <tr height="19" style="height:14.25pt">
				  <td height="19" class="xl185" dir="LTR" style="height:14.25pt"></td>
				  <td class="topLabelStyle">联系电话：</td>
				  <td colspan="7"  class="topAutoInputStyle">${data.companyPhone}</td>
				  
				  
				  <td class="topLabelStyle">结算货币：</td>
				  <td   class="topAutoInputStyle">${data.settlementType}<span >&nbsp;</span></td>
				  
				 </tr>
				 <tr height="19" style="height:14.25pt">
				  <td height="19" class="xl185" dir="LTR" style="height:14.25pt"></td>
				  <td class="topLabelStyle">联系传真：</td>
				  <td colspan="7" class="topAutoInputStyle">${data.companyFax }</td>
				  
				  
				  <td class="topLabelStyle">付款方式：</td>
				  <td class="topAutoInputStyle">支票</td>
				  
				 </tr>
				 <tr height="19" style="height:14.25pt">
				  <td height="19" class="xl185" dir="LTR" style="height:14.25pt"></td>
				  <td class="topLabelStyle">报价关于：</td>
				  <td colspan="7" class="topAutoInputStyle">${data.quotationAbout }</td>
				  <td class="topLabelStyle">销售人员：</td>
				  <td class="topAutoInputStyle">${data.staffName }</td>
				 </tr>
				 <tr height="19" style="height:14.25pt">
				  <td height="19" class="xl185" dir="LTR" style="height:14.25pt" colspan="11"></td>
				 </tr>
				 <tr  id="mainToType" height="19" class="blueBar"  style="height:14.25pt">
				  <td colspan="9" height="19" class="xl197" dir="LTR" style="height:14.25pt">项目总价（大写）：</td>
				  <td class="xl88" colspan="2">　</td>
				 </tr>
				<!-- topLines -->
				 <tr class="xl76" height="19" style="height:14.25pt">
				  <td height="19" class="xl95" style="height:14.25pt;border:none" colspan="9" rowspan="4">　</td>
				  <td class="xl99" style="border-top:none">含税总价(RMB):</td>
				  <td class=" amtTop " style="border-top:none">${data.withTaxAmt}</td>
				 </tr>
				 <tr class="xl76" height="19" style="height:14.25pt">
				  <td class="xl106"><span >&nbsp;</span>优<span >&nbsp; </span>惠 (RMB):</td>
				  <td class="amtTop">${data.privilegeAmt }</td>
				  
				 </tr>
				 <tr class="xl76" height="20" style="height:15.0pt">
				
				  <td class="xl112">最终价格(RMB):</td>
				  <td class="amtTop"><fmt:formatNumber type="currency" value="${data.dealAmt}" /></td>
				  
				 </tr>
				 <tr id="mainDetailLines"  height="19" style="height:14.25pt">
				
				  <td class="xl90"></td>
				  <td class="xl114">${data.withTaxAmt}</td>
				 </tr>
				 <tr class="xl77" height="20" style="mso-height-source:userset;height:15.0pt">
				  <td height="20" class="xl143" style="height:15.0pt" colspan="9">　</td>
				  <td class="xl147">总计</td>
				  <td class="xl148" align="right">${data.withTaxAmt}</td>
				  
				 </tr>
				 
				<tr class="xl81 blueBar " height="20" style="mso-height-source:userset;height:15.0pt">
				  <td height="20" class="xl149" colspan="11" style="height:15.0pt;border-top:none">　</td>
				 
				 </tr>
				 <tr class="xl84" height="20" style="mso-height-source:userset;height:15.0pt">
				  <td colspan="11" height="20" class="cxwzwStyle" style="border-right:.5pt solid black;
				  height:15.0pt">以下无正文</td>
				  
				 </tr>
				 <tr height="19" style="height:14.25pt">
				  <td height="19" class="xl90" style="height:14.25pt" colspan="11"></td>
				 </tr>
				 <tr height="19" style="height:14.25pt">
				  <td colspan="11" height="19" class="xl211" style="height:14.25pt">备注：</td>
				 </tr>
				 <tr height="20" style="mso-height-source:userset;height:15.0pt">
				  <td height="20" class="xl160" width="32" style="height:15.0pt;width:24pt">1、</td>
				  <td colspan="9" class="xl212" width="509" style="width:384pt">以上报价均已含税（产品开具17%增值税发票，服务开具6%增值税发票）</td>
				  <td class="xl90"></td>
				  
				 </tr>
				 <tr height="20" style="mso-height-source:userset;height:15.0pt">
				  <td height="20" class="xl161" style="height:15.0pt">2、</td>
				  <td colspan="7" class="xl212" width="370" style="width:279pt">报价有效期：5日。</td>
				  <td class="xl90"></td>
				  <td colspan="2" class="xl174">客户签名（盖章）：</td>
				  
				 </tr>
				 <tr height="20" style="mso-height-source:userset;height:15.0pt">
				  <td height="20" class="xl161" style="height:15.0pt">3、</td>
				  <td colspan="7" class="xl212" width="370" style="width:279pt">到货时间：报价单签字确认回传或合同签订后<font class="font44"><span >&nbsp;${data.arrivalDays }&nbsp;&nbsp;
				  </span></font><font class="font32">个工作日。</font></td>
				  <td class="xl90"></td>
				  <td colspan="2" rowspan="4" class="xl215" style="border-bottom:2.0pt double black"></td>
				  
				 </tr>
				 <tr height="20" style="mso-height-source:userset;height:15.0pt">
				  <td height="20" class="xl161" style="height:15.0pt">4、</td>
				  <td colspan="8" class="xl212" width="404" style="width:305pt">付款期限：√款到发货。</td>
				  
				 </tr>
				 <tr height="20" style="mso-height-source:userset;height:15.0pt">
				  <td height="20" class="xl161" style="height:15.0pt"></td>
				  <td colspan="8" class="xl212" width="404" style="width:305pt"><span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  </span>□货到<font class="font44"><span >&nbsp;&nbsp;&nbsp; </span></font><font class="font32">工作日（现金、支票、转账）付款。<span >&nbsp;&nbsp;</span></font></td>
				  
				 </tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl162" style="height:13.5pt"></td>
				  <td colspan="8" class="xl212" width="404" style="width:305pt"><span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  </span>□其他<font class="font44"><span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  </span></font><font class="font32"><span >&nbsp;</span>。</font></td>
				  
				 </tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl90" style="height:13.5pt" colspan="11"></td>
				</tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl166" style="height:13.5pt" colspan="11">　</td> 
				 </tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl170" colspan="3" style="height:13.5pt;mso-ignore:colspan">地址:上海市杨浦区大学路248号1002</td>
				  <td class="xl90"></td>
				  <td class="xl90"></td>
				  <td class="xl163"></td>
				  <td class="xl163"></td>
				  <td class="xl163"></td>
				  <td class="xl164"></td>
				  <td class="xl159"></td>
				  <td rowspan="2" class="BestRegards" style="border-top:none">Best Regards ！</td>
				   
				 </tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl170" colspan="3" style="height:13.5pt;mso-ignore:colspan">电话:021-65435161</td>
				  <td class="xl170" colspan="6">传&nbsp;真:65435240</td>
				  
				  <td class="xl165"></td>
				   
				 </tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl170" style="height:13.5pt" colspan="3">手机:13311763209</td>
				  
				  <td class="xl170" colspan="6" style="mso-ignore:colspan">E-mail:gongquan.xie@sh-sapling.com</td>
				  
				  <td class="xl90"></td>
				  <td rowspan="4" class="buttonNameStyle" style="border-bottom:2.0pt double black">${data.staffName}</td>
				   
				 </tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl159" style="height:13.5pt" colspan="11"></td> 
				</tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl173" colspan="11" style="height:13.5pt;mso-ignore:colspan">开户名称：上海小树信息技术有限公司</td>
				
				</tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl176" colspan="4" style="height:13.5pt;mso-ignore:colspan">收款银行：中国银行上海市五角场支行</td>
				  <td class="xl176" colspan="6"></td>
				 </tr>
				 <tr height="18" style="mso-height-source:userset;height:13.5pt">
				  <td height="18" class="xl173" colspan="3" style="height:13.5pt;mso-ignore:colspan">收款账号：457265792109</td>
				  <td class="xl90" colspan="7"></td>
				  <td class="xl178">如有任何疑问请即时与我联络！</td>
				   
				 </tr>
				 <tr height="20" style="mso-height-source:userset;height:15.0pt">
				  <td height="20" class="xl72" style="height:15.0pt" colspan="11"></td>
				 </tr>
				 <!--[if supportMisalignedColumns]-->
				 <tr height="0" style="display:none">
				  <td width="32" style="width:24pt" colspan="11"></td>
				 </tr>
				 <!--[endif]-->
				</tbody></table>
						</div>
						<div class="col-sm-1"> </div>
					</div>
					<!--  end -->
					
				</div>
			</section>
		</div>
		<!-- /.box -->
		<!-- /.content -->
	</div>
				<div id="initData" style="display:none">
					<script type="text/javascript">
						var _lis = ${JsonData};

						var _prdctType = [];

						for (var i = 0; i < _lis.length; i++) {
							var _objLis = _lis[i];
							 if(_prdctType.length>0){

							 	var _tyRin = true;
							 	for (var j = 0;  j < _prdctType.length;  j++) {
							 	 // code to be executed  productType
							 	 var _ptTy = _prdctType[j];
							 	 if(_ptTy.productType == _objLis.productType){
							 		_tyRin=false;
							 		_ptTy.dtlis.push(_objLis);
							 		_ptTy.totalAmt =toDecimal(parseFloat(_objLis.totalAmt)+parseFloat(_ptTy.totalAmt));
							 		break;
							 	}
							 }
							 if (_tyRin) {
							 	var _tobj = {};
								 _tobj.totalAmt  = _objLis.totalAmt;
								 _tobj.productType = _objLis.productType;
								 _tobj.dtlis =[_objLis];
								 _prdctType.push(_tobj);
							 }

							}else{
								 var _tobj = {};
								 _tobj.totalAmt  = parseFloat(_objLis.totalAmt);
								 _tobj.productType = _objLis.productType;
								 _tobj.dtlis = [_objLis];
								 _prdctType.push(_tobj);
								 }
						}

							function toDecimal(x) {
								var val = Number(x)
								if(!isNaN(parseFloat(val))) {
									val = val.toFixed(2);
								}
								return  val;
							}

					var _topLine = '';

					var _secLines = '';

					for (var y = 0; y < _prdctType.length; y++) {
						var _dis = _prdctType[y];

						_topLine+= 	'<tr height="19" style="height:14.25pt">'+
										  '<td colspan="9" height="19" class="xl200" dir="LTR" style="height:14.25pt">'+_dis.productType+'</td>'+
										  '<td class="xl91" style="border-left:none">RMB：</td>'+
										  '<td class="xl92" align="right" style="border-left:none">'+_dis.totalAmt+'</td>'+
										 '</tr>';

						var _lis =  _dis.dtlis;
						for (var m = 0; m < parseInt(_lis.length); m++) {
							var _os = _lis[m];
							if(m==0){
								_secLines+= '<tr height="19" class="blueBar" style="height:14.25pt"><td height="19" colspan="2" style="height:14.25pt;mso-ignore:colspan">'+_dis.productType
								+'</td><td class="xl117" colspan="9"></td><tr height="17" style="mso-height-source:userset;height:12.75pt"><td height="17"  style="height:12.75pt">序号</td><td style="border-left:none">产品名称</td><td colspan="5"  style="border-left:none">产品描述</td><td>单位</td><td style="border-left:none">数量</td><td style="border-left:none">单价（人民币）</td><td style="border-left:none">金额（人民币）</td></tr>';
							}
							 _secLines+=  '<tr  height="20" style="mso-height-source:userset;height:15.0pt">'+
								'<td height="20"  style="height:15.0pt;border-top:none">'+_os.orderNo+'</td>'+
								'<td  width="100" style="border-top:none;border-left:none;width:75pt">'+_os.productName+'</td>'+
								'<td colspan="5"  width="236" style="border-left:none;width:178pt">'+_os.productDesc+'</td>'+
								'<td  style="border-top:none">'+_os.unin+'</td>'+
								'<td  style="border-top:none;border-left:none">'+_os.amount+'</td>'+
								'<td  style="border-top:none;border-left:none">'+_os.unitPrice+'</td>'+
								'<td  style="border-top:none;border-left:none">'+_os.totalAmt+'</td>'+
								'</tr>';
							}
							_secLines+='<tr class="xl77" height="20" style="mso-height-source:userset;height:15.0pt"><td height="20" class="xl134" colspan="9" style="height:15.0pt;border-top:none">　</td><td class="xl138"'+
							'style="border-top:none">小计</td><td class="xl139" align="right" style="border-top:none">'+_dis.totalAmt+'</td></tr>'

					} 
					$("#mainToType").after(_topLine);
					$("#mainDetailLines").after(_secLines); 
					</script>
	</div>	
	<div style="display: none;">
		<script type="text/javascript">
				$("#initData").remove();
		</script>
	</div>
	<!-- /.content-wrapper -->
	<tags:main_footer />

	<!-- Control Sidebar -->
	<tags:control_sidebar />
	<!-- ./wrapper -->

	<tags:load_common_js />
	<script src="${assets}/datepicker/datepicker.js"></script>
	<script src="${assets}/datepicker/locales/zh-CN.js"></script>
	<script src="${assets}/validator/js/validator.js"></script>
	

</body>
</html>

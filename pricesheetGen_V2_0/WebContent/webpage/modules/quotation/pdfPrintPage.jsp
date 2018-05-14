<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" isErrorPage="true" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
    <head>
        <title>报价单录入</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
			div{
				 font-family: 'Microsoft YaHei' ! important;
				 color:block  ! important;
			}
			select{
			 font-family: 'Microsoft YaHei' ! important;
				 color:block  ! important;
			}
		 	#maintab tr td:first-child{
		 		text-align: left;
		 		padding-left:16px;
		 	}
		</style>
<style>
</style>

<script src="${ctxStatic}/json/json2.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript">

// 获取Select 控件指定的Value 对应的 Option值
function getTheOption(selectId, theVal) { 
	var theOpt =
	   <c:if test="${quotationRlt.settlementType=='RMB'}">'人民币';  </c:if>  
	   <c:if test="${quotationRlt.settlementType=='USD'}">'美元'   ;</c:if>  
	   <c:if test="${quotationRlt.settlementType=='EUR'}">'欧元'   ;</c:if>  
	   <c:if test="${quotationRlt.settlementType=='GBP'}">'英镑'   ;</c:if>  
	   <c:if test="${quotationRlt.settlementType=='JPY'}">'日元'   ;</c:if>  

    return theOpt; 
}

// 组织报价单返回Json对象
function getPriceSheetJson() 
{

    // 报价单总信息json实体
    var objJsonEntity={};
    var fieldsHead = $("#headTab").find("input:visible");

    // 报价单头部转Json 
    addObjSet2Json(objJsonEntity, fieldsHead, null);

    // 结算货币 
    var fieldsettlementType = $("select[name='settlementType']").find("option:selected");
    objJsonEntity.settlementType = $(fieldsettlementType).val();
    // 付款方式
    objJsonEntity.payType = $("select[name='payType']").find("option:selected").val();
    // 销售人员
    objJsonEntity.staffCode = $("select[name='staffCode']").find("option:selected").val();
    // 报价单号上送始终为空
    objJsonEntity.quotationCode = "";
    

    // 报价单明细信息
    var objBodyList= null;
    var fieldsTrObj = $("#mainDivId").find("#tab").find("tr");
    $.each(fieldsTrObj, function (index, domEle)
    {
        var fieldsInput = $(domEle).find("input:visible");                                 
        if (0 >= fieldsInput.length) 
        {
            return;
        }                                

        var svcGrp = fieldsInput[0];
        if(null == objBodyList) 
        {
            objBodyList = new Array();
        }

        var subfieldsTrObj = $("#subDivId_Div_" + index).find("#subDivId_Tbl_"+index).find("tr");                                     
        $.each(subfieldsTrObj, function (subindex, subdomEle)
        {
            var objBodySub = {};
            var subfieldsInput = $(subdomEle).find("input:visible");    

            if (0 >= subfieldsInput.length) {
                return;
            }

            addObjSet2Json(objBodySub, subfieldsInput, svcGrp);
            objBodyList.push(objBodySub);                                     
        });
    });


 
    return objJsonEntity;
}


/* 
 * 给表添加一行
 * tableId: 表的Id 
 * createSubTbl: 当前表为主表还是字表
 * fieldChsNameList: 主表中文表头名称 
 * fieldEngNameList: 主表英文表头名称
 * subfieldChsNameList: 子表表头中文名称
 * subfieldEngNameList: 子表表头英文名称 
 */
function addRow(tableId, fieldEngNameList, fieldValList)
{
    var tab = document.getElementById(tableId);
    var rowIndex = tab.rows.length;

    var tr = tab.insertRow(rowIndex); // 添加一行;
    var curTypeTblLen =fieldEngNameList.length;
    for (var i = 0; i < curTypeTblLen; i++) 
    {
        var tdCur = tr.insertCell(i);
        tdCur.id = fieldEngNameList[i];
        tdCur.innerText = fieldValList[i];
    }    
}

</script>

<body class="gray-bg">
	<div class="wrapper wrapper-content">
                
<form name="myForm">
    <div id="headDivId" style="width: 850px;margin:0px auto;">
			<div  style="height:100px;line-height:100px;text-align:left;float: left;width: 60%;"><img src="${ctxStatic }/common/login/images/logo.png" style="width:280px"></div>
			<div  style="height:100px;line-height:100px;float: left;text-align: center;width: 40%"><img src="${ctxStatic }/common/login/images/image005.png" style="width:200px"></div>
    		<div style="height:25px;float: left;width: 100%;"><div  style="height:25px;line-height:25px;background-color:#008080;text-align: left;width:45%;font-weight: bold;margin-bottom:3px;">尊敬的客户，您好！兹对贵司需求报价如下：</div></div>
    		
    		<div>
    			<div id="headTab"  style="float: left;width: 45%;">
			        	<div style="margin-bottom:5px;height:25px;">
						       <div style="float: left;width: 40%;text-align: right;line-height:25px;"> 至：</div>
						       <div   style="height:25px;text-align: center;float: left;width: 60%;border-bottom: 1px solid;">
						       		${quotationRlt.custName}
						        </div>
						    </div>
							<div   style="margin-bottom:5px;height:25px;"> 
								 <div style="text-align: right;line-height:25px;float: left;width: 40%">客户公司：</div>
								<div    style="height:25px;text-align: center;float: right;width: 60%;border-bottom: 1px solid;">
									${quotationRlt.company}
						        </div>
							</div>	
							<div   style="margin-bottom:5px;height:25px;">
								 <div style="text-align: right;line-height:25px;float: left;width: 40%">联系电话：</div>
								<div   style="height:25px;text-align: center;float: left;width: 60%;border-bottom: 1px solid;">
									${quotationRlt.companyPhone}
						        </div>
							</div>		
							<div  style="margin-bottom:5px;height:25px;">
								<div style="text-align: right;line-height:25px;float: left;width: 40%">联系传真：</div>
								<div    style="height:25px;text-align: center;float: left;width: 60%;border-bottom: 1px solid;">
									${quotationRlt.companyFax }
						        </div>
							</div>		
							<div    style="margin-bottom:5px;height:25px;">
								 <div style="text-align: right;line-height:25px;float: left;width: 40%">报价关于：</div>
								<div  style="height:25px;text-align: center;float: left;width: 60%;border-bottom: 1px solid;">
									${quotationRlt.quotationAbout}	
						        </div>
							</div>
						</div>
					<div  style="float: left;width: 55%" >
			        	<div style="text-align:right;margin-left:50px;">
			        		<div  style="margin-bottom:5px;height:25px;">
						         <div style="text-align: right;line-height:25px;float: left;width: 45%">报价日期：</div>
						        <div   style="height:25px;text-align: center;float: left;width: 55%;border-bottom: 1px solid;">
						        	<fmt:formatDate value="${quotationRlt.quotationDate}" pattern="yyyy-MM-dd" />						        	
						        </div>
						    </div>
							<div   style="margin-bottom:5px;height:25px;"> 
								 <div style="text-align: right;line-height:25px;float: left;width: 45%">报价单号：</div>
								<div   style="height:25px;text-align: center;float: left;width: 55%;border-bottom: 1px solid;">
									${quotationRlt.quotationCode}
						        </div>
							</div>	
							<div   style="margin-bottom:5px;height:25px;">
								 <div style="text-align: right;line-height:25px;float: left;width: 45%">结算币种：</div>
								<div  style="height:25px;text-align: center;float: left;width: 55%;border-bottom: 1px solid;">
						                   <c:if test="${quotationRlt.settlementType=='RMB'}">人民币  </c:if>  
								           <c:if test="${quotationRlt.settlementType=='USD'}">美元   </c:if>  
								           <c:if test="${quotationRlt.settlementType=='EUR'}">欧元   </c:if>  
								           <c:if test="${quotationRlt.settlementType=='GBP'}">英镑   </c:if>  
								           <c:if test="${quotationRlt.settlementType=='JPY'}">日元   </c:if>  
						        </div>
							</div>		
							<div  style="margin-bottom:5px;height:25px;">
								 <div style="text-align: right;line-height:25px;float: left;width: 45%">付款方式：</div>
								<div    style="height:25px;text-align: center;float: left;width:55%;border-bottom: 1px solid;">
				                       <c:if test="${quotationRlt.payType=='001'}">现金</c:if> 
									   <c:if test="${quotationRlt.payType=='002'}">支票</c:if> 
									   <c:if test="${quotationRlt.payType=='003'}">转账</c:if> 
						        </div>
							</div>		
							<div  style="margin-bottom:5px;height:25px;">
								 <div style="text-align: right;line-height:25px;float: left;width: 45%">销售人员：</div>
								<div   style="height:25px;text-align: center;float: left;width: 55%;border-bottom: 1px solid;">
				                        ${quotationRlt.staffName}
						        </div>
							</div>
						</div>
			        </div>	
    		</div>
    		<div id='mainDivId' >
    			<table width="100%" > 
		        	<tr height="30px; "><th></th></tr>
		            </tr>
		        </table>
		        <table width="100%" id="maintab" style="text-align:center;"  border="1" cellspacing="0" cellpadding="0">
		        	 <tr style="background-color:#008080;color:black;">
		                <th style="text-align:left;width:100%;padding-left:16px;"  colspan="3">项目总价</th>
		            </tr>
		            <tr >
		                 <td style="border-top: 1px solid black;text-align:left;padding-left:16px;" >项目名称</td>
		                 <td style="text-align:center;width:10%;border-top:  1px solid black;">计价币种</td>
		                 <td style="text-align:center;width:25%;border-top:  1px solid black;">税后总额</td>
		             </tr>
		        </table>
		        <div id='area_sumAmount' style="width:100%;" >
		            <table width="100%"   style="text-align:center;"  cellspacing="0" cellpadding="0">  
		            	 <tr >
		                    <td style="border: 2px solid #808080;border-top:0px; ">
		                    	<div>
			                    	<div style="width:75%;text-align:right;height:30px;float: left">项目总价(RMB):</div>
			                    	<div id="withTaxAmt" style="width:25%;text-align:right;height:30px;float: left" ></div>
		                    	</div>
		                    	<div>
			                    	<div style="width:75%;text-align:right;height:30px;float: left">优惠(RMB):</div>
			                    	<div style="width:25%;text-align:right;height:30px;float: left">
			                    		<input type="text" id="privilegeAmt" name="privilegeAmt" value="0" style="text-align: right;border:0px;width:99%;margin-right:5px;" />
			                    	</div>
		                    	</div>
		                    	<div>
			                    	<div style="width:75%;text-align:right;height:30px;float: left">最终价格(RMB):</div>
			                    	<div id="dealAmt" style="width:25%;text-align:right;height:30px;float: left"></div>
		                    	</div>
		                   </td>
		                </tr>
		            </table>
		            <div style="display:inline">
		                <div style="width:65%;border:1px solid #FFF;float:left"></div>
		                <div style="width:15%;border:1px solid #FFF;float:left" id="finalAmt">0.0000</div>
		            </div>
		        </div>
		    </div> 
    		
		    <div id='subDivId'>
					<c:set value="0" var="preQodIdx" />
					<c:forEach items="${quotationRlt.quotationOrderDetails}" var="quotationOrderDetail" varStatus="status" >
					
					    <c:forTokens items="${quotationOrderDetail.orderNo}" var="cur" delims="." varStatus="s">
						<c:if test="${s.first}" >
						    <c:set value="${cur}" var="curQodIdx" />
						    </c:if> 
					    </c:forTokens>	   
						   		   
						<c:if test="${preQodIdx ne curQodIdx and preQodIdx ne 0}">			
								<tr>
									<td colspan="5"></td>
									<td>小计</td>
									<td id="subSumAmt"> <c:out value="${sumAmt}" /></td>
								</tr>
						</c:if>
					
						<c:if test="${preQodIdx ne curQodIdx}">
							<c:set value="0.00" var="sumAmt" />
						    <table width="100%" id="subtab" border="1" style="text-align:center;" cellspacing="0" cellpadding="0">
								<tr  style="background-color:#008080;color:black;">
								    <td colspan="7" style="text-align:left;padding-left:16px;" id="subProductType">${quotationOrderDetail.productType}</td>
								</tr>
							    <tr>
							        <td>序号</td>
							        <td>产品名称</td>
							        <td>产品描述</td>
							        <td>单位</td>
							        <td>数量</td>
							        <td>单价(人民币)</td>
							        <td>金额(人民币)</td>
							    </tr>		   
						</c:if>		    
								<tr>
									<td>${quotationOrderDetail.orderNo}</td>
									<td>${quotationOrderDetail.productName}</td>
									<td>${quotationOrderDetail.productDesc}</td>
									<td>${quotationOrderDetail.unin}</td>
									<td>${quotationOrderDetail.amount}</td>
									<td>${quotationOrderDetail.unitPrice}</td>
									<td>${quotationOrderDetail.totalAmt}</td>		
								</tr>
					
					    <c:set value="${sumAmt + quotationOrderDetail.totalAmt}" var="sumAmt" />
							<c:if test="${status.last}">			
								<tr>
									<td colspan="6" style="text-align: right;padding-right:20px;">小计 </td>
									<td id="subSumAmt"> <c:out value="${sumAmt}" /></td>
								</tr>
							</table>
						</c:if>
						<c:set value="${curQodIdx}" var="preQodIdx" />
					</c:forEach>
		    </div>
		     <div id="tailDivId">
		    	<div  style="margin-top:20px;width:60%;float: left;font-size: 14px;">
		    		<div style="text-align: left;font-weight: bold;">备注：</div>
		    		<div style="text-align: left;padding-left:20px;">1、报价均已含税（产品开具17%增值税发票，服务开具6%增值税发票）</div>
		    		<div style="text-align: left;padding-left:20px;">2、报价有效期：5个工作日</div>
		    		<div style="text-align: left;padding-left:20px;" id="arrivalDays">3、到货时间：报价单签字确认回传合同签订后 <input type=text  name="arrivalDays"  style="width:50px;align:center;height:20px;line-height: 20px;border: 0px;border-bottom: 1px solid;"/>个工作日</div>
		    		<div style="text-align: left;padding-left:20px;">4、付款期限：</div>
		    		<div style="text-align: left;padding-left:100px;"><input type="radio" name="deliveryMode" id="radio" value="001">款到发货.  </div>
		    		<div style="text-align: left;padding-left:100px;"><input type="radio" name="deliveryMode" id="radio" value="002" checked="checked" />货到<input type="text" id="waitDays" name="waitDays" value="7" style="width:50px;height:20px;line-height: 20px;border: 0px;border-bottom: 1px solid;" /> 工作日(现金、支票、转账)付款。    </div>
		    		<div style="text-align: left;padding-left:100px;"><input type="radio" name="deliveryMode" id="radio" value="003"  />其他<input type="text" id="otherChoice" name="otherChoice" style="width:300px;height:20px;line-height: 20px;border: 0px;border-bottom: 1px solid;" />。  </div>
		    	</div>
		    	  <div style="margin-top:20px;float: right;width:40%">
		    		<div style="text-align: left;font-weight: bold;font-size: 22px;padding-top:50px;">客户签名(签章):</div>
		    		<div style="text-align: left;padding-top:75px"><hr style="height:3px;border:none;border-top:3px double black;" /></div>
		    	</div>
		    	<div style="float: left;width: 100%">
					<div style="height:25px;padding:0px;width: 100%"><hr style="height:3px;border:none;border-top:3px double black;" /></div>
				</div>
		    </div>
		    <div>
			    <div  style="float: left;width:60%" >
					<div style="text-align:left">地址:上海市杨浦区黄兴路1号中通大厦1楼北侧铺(眉州支路92-96号)</div>
					<div style="text-align:left">电话:021-65435161<label style="width:30px;"> </label>传真:65435240</div>
					<div style="text-align:left">手机	13311763209<label style="width:30px;"> </label> E-mail：shangwu@sh-sapling.com</div>
					<div><br><br></div>
					<div style="text-align:left">开户名称：上海小树信息技术有限公司</div>
					<div style="text-align:left">收款银行：中国银行上海市五角场支行</div>
					<div style="text-align:left">收款账号：457265792109</div>
				</div> 
				<div style="float: left;width:40%" >
					<div style="font-weight: bold;font-size: 22px;">Best Regards!</div>
					<div style="font-weight: bold;font-size: 25px;height:80px;line-height:80px;">${quotationRlt.staffName}</div>
					<div style="height:3px;"><hr style="height:3px;border:none;border-top:3px double black;" /></div>
					<div>如有任何疑问请即时与我联系!</div>
				</div> 
			</div>
    </div>

  

    <!-- <div id="tailDivId">
        <table width="80%" id="tailTab" border="1px" style="text-align:center;">
            <tr class="tr-left"><td width="5%">备注</td><td></td></tr>
            <tr class="tr-left"><td ></td><td>1.报价均已含税（产品开具17%增值税发票，服务开具6%增值税发票）</td></tr>
            <tr class="tr-left"><td></td><td>2.报价有效期5个工作日</td></tr>
            <tr class="tr-left"><td></td><td><div id="arrivalDays">3.到货时间：报价单签字确认回传合同签订后
                <input type=text  name="arrivalDays" value="" style="width:50px;align:center"/>个工作日</div></td></tr>
            <tr class="tr-left"><td></td><td>4.付款期限：</td></tr>
            <tr class="tr-left"><td></td><td>
            <input type="radio" name="deliveryMode" id="radio" value="001">款到发货<br>
            </td></tr>
            <tr class="tr-left"><td></td><td>
            <input type="radio" name="deliveryMode" id="radio" value="002" checked="checked" />货到
            <input type="text" id="waitDays" name="waitDays" value="" style="width:50px;" /> 工作日(现金、支票、转账)付款。                                
            </td></tr>
            <tr class="tr-left"><td></td><td>
            <input type="radio" name="deliveryMode" id="radio" value="003"  />其他
            <input type="text" id="otherChoice" name="otherChoice" style="width:500px;" />。
            </td></tr>                
         </table>
     </div>   -->  
</form>
</div>
   
<script type="text/javascript">
function initMainTbl() {
	
	var fieldEngNameList = ['productType','currency','grpAmount'];

	var len = $("#subDivId").find("#subtab").find("#subSumAmt").length;
	for (var i = 0; i < len; i++) {

		var fieldValList = [];
		var fieldVal = {};
		fieldVal.subProductType =NumberToChinese(parseInt(i)+1)+"、" +$("#subDivId").find("#subProductType").eq(i).text();

		var settlementTypeVal = '${quotationRlt.settlementType}';
		var settlementTypeOpt = getTheOption ('settlementType',  settlementTypeVal);
		if ("" != settlementTypeOpt) {
			fieldVal.settlementType = settlementTypeOpt;
		}	

		fieldVal.subSumAmt = $("#subDivId").find("#subtab").find("#subSumAmt").eq(i).text();
		fieldValList.push(fieldVal.subProductType);
		fieldValList.push(fieldVal.settlementType);
		fieldValList.push(fieldVal.subSumAmt);
			
		addRow('maintab', fieldEngNameList, fieldValList);
	}
} 

var chnNumChar = ["零","一","二","三","四","五","六","七","八","九"];
var chnUnitSection = ["","万","亿","万亿","亿亿"];
var chnUnitChar = ["","十","百","千"];
function SectionToChinese(section){
	
	  var strIns = '', chnStr = '';
	  var unitPos = 0;
	  var zero = true;
	  while(section > 0){
	    var v = section % 10;
	    if(v === 0){
	      if(!zero){
	        zero = true;
	        chnStr = chnNumChar[v] + chnStr;
	      }
	    }else{
	      zero = false;
	      strIns = chnNumChar[v];
	      strIns += chnUnitChar[unitPos];
	      chnStr = strIns + chnStr;
	    }
	    unitPos++;
	    section = Math.floor(section / 10);
	  }
	  return chnStr;
	}
function NumberToChinese(num){
	  var unitPos = 0;
	  var strIns = '', chnStr = '';
	  var needZero = false;
	 
	  if(num === 0){
	    return chnNumChar[0];
	  }
	 
	  while(num > 0){
	    var section = num % 10000;
	    if(needZero){
	      chnStr = chnNumChar[0] + chnStr;
	    }
	    strIns = SectionToChinese(section);
	    strIns += (section !== 0) ? chnUnitSection[unitPos] : chnUnitSection[0];
	    chnStr = strIns + chnStr;
	    needZero = (section < 1000) && (section > 0);
	    num = Math.floor(num / 10000);
	    unitPos++;
	  }
	 
	  return chnStr;
}



function initSumAmt() {

    var grpAmount = 0.00;
    var withTaxAmt = 0.00;

	var len = $("#mainDivId").find("#maintab").find("#grpAmount").length;
    for (var i = 0; i < len; i++) {
        grpAmount = $("#mainDivId").find("#maintab").find("#grpAmount").eq(i).text()         
        withTaxAmt = withTaxAmt + parseFloat(grpAmount);
    }

    var privilegeAmt = $("#privilegeAmt").val();
    var dealAmt = withTaxAmt - parseFloat(privilegeAmt);

    $("#mainDivId").find("#area_sumAmount").find("#withTaxAmt").html(withTaxAmt.toFixed(2));
    $("#mainDivId").find("#area_sumAmount").find("#dealAmt").html(dealAmt.toFixed(2));
    $("#mainDivId").find("#area_sumAmount").find("#finalAmt").html(dealAmt.toFixed(2));
}

// 初始化客户信息
$("#withTaxAmt").val('${quotationRlt.withTaxAmt}');     // 含税总价(RMB)
$("#privilegeAmt").val('${quotationRlt.privilegeAmt}'); // 惠 (RMB)
$("#dealAmt").val('${quotationRlt.dealAmt}');           // 最终价格

// 报价单主体
initMainTbl();
initSumAmt();

// 报价单尾部信息 
$("input[name='arrivalDays']").val('${quotationRlt.arrivalDays}');  // 到货时间

var deliveryMode = '${quotationRlt.deliveryMode}';
$("input[name='deliveryMode'][value='"+ deliveryMode +"']").attr("checked",true); 
if ("001" == deliveryMode) {
} else if ("002" == deliveryMode) {
    $("#waitDays").val('${quotationRlt.otherAdd}');            
} else if ("003" == deliveryMode) {
    $("#otherChoice").val('${quotationRlt.otherAdd}');
}

// 设置页面数据不可修改
$(":input").each(function(a,b){
    var disabled= $(b).attr("disabled"); //获取当前对象的disabled属性
    if(disabled==false){                 //判断如果是非disabled则进行处理
        $(b).attr("disabled",true)       //将input元素设置为disabled 
    }
});
</script>

</body>
</html>
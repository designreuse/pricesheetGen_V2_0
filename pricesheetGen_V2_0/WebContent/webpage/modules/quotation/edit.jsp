<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" isErrorPage="true" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<html>
    <head>
        <title>报价单修改</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<style>
.div-td table td{ background:#CCC; color:#000; line-height:40px} 
.tr-left {margin:0 auto;border:1px solid;text-align:left;}
</style>

<script src="${ctxStatic}/json/json2.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$("input[name=currency]").val($("#settlementType option:selected").text());
});

/*
 * 获取标准的年月日格式
 * 返回的格式yyyy-mm-dd
 */
function getNowFormatDate() 
{
    var seperator1 = "-";
    var seperator2 = ":";
    var date = new Date();    
    var month = date.getMonth() + 1;

    var strDate = date.getDate();
    if (month >= 1 && month <= 9) 
    {
        month = "0" + month;
    }
    
    if (strDate >= 0 && strDate <= 9) 
    {
        strDate = "0" + strDate;
    }

    return date.getFullYear() + seperator1 + month + seperator1 + strDate;
}


/*
 * 添加对象集合到Json对象
 * jObj: jquery 查询返回的input对象集 
 * parentNode：Json 对象
 * addObj: 追加的一个 jquery 查询返回的input对象
 */
function addObjSet2Json(parentNode, jObj, addObj)
{

    var arrObj = new Array();
    var fieldObj = {};
    var fieldString = "";
    var lenObj = $(jObj).length;

    for (var i=0; i<lenObj;i++) 
    {
        var name = $(jObj).eq(i).attr("name");
        var val = $(jObj).eq(i).val();     
        parentNode[name] = val;
    }

    // 补充的对象
    if(addObj) 
    {
        var name = $(addObj).attr("name");
        var val = $(addObj).val();     
        parentNode[name] = val;
    }
   
    return;
}

/*
 * 检查必要的不能为空的输入 
 */
function chkEssentialInput() 
{
    var quotationAbout = $.trim($("#quotationAbout").html());
    if ("" == quotationAbout) 
    {
        alert("报价关于不能为空！！！");
        return false;
    }
    
    // 如果报价单号已经生成，用户继续点击则进行提示
    //var quotationCode = $("#headDivId").find("input[name=quotationCode]").val();
    //if (0 < quotationCode.length) 
    //{
    //	return confirm("【继续生成报价单】\n当前报价单已经生成成功，继续操作会生成新的报价单号。");
    //}

    return true;
}

function currencyChange() 
{ //获取下拉框选中项的text属性值
    
    var selectText = $("#settlementType").find("option:selected").text();
    var selectValue = $("#settlementType").val();
    $("#mainDivId").find("input[name=currency]").val(selectText);
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
    objJsonEntity.staffId = $("select[name='staffCode']").find("option:selected").val();
    // 报价单号上送始终为空
    objJsonEntity.quotationCode = $("#quotationCode").html();
    objJsonEntity.id = $("#_id").val();
    objJsonEntity.custId = ${data.custId};

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


    objJsonEntity["quotationOrderDetails"] = objBodyList;
    objJsonEntity["withTaxAmt"] = $("#withTaxAmt").val();
    objJsonEntity["privilegeAmt"] = $("#privilegeAmt").val();
    objJsonEntity["dealAmt"] = $("#dealAmt").val();
  
    
 
    // 报价单尾部信息
    objJsonEntity["arrivalDays"] = $("input[name=\"arrivalDays\"]").val();
    var _deliveryMode = $("input[name='deliveryMode']:checked").val();
    
    objJsonEntity["deliveryMode"] = _deliveryMode;
    if ("001" == _deliveryMode) {
        objJsonEntity["otherAdd"] = "";
    } else if ("002" == _deliveryMode) {
        objJsonEntity["otherAdd"] = $("#waitDays").val();            
    } else if ("003" == _deliveryMode) {
        objJsonEntity["otherAdd"] = $("#otherChoice").val();
    }
    
    return objJsonEntity;
}



/* 
 * 创建表格
 * upLayerId: 创建表格所潜入的父对象容器Id名
 * index: 创建表的唯一识别标签索引
 * fieldChsNameList: 主表中文表头名称 
 * fieldEngNameList: 主表英文表头名称
 * subfieldChsNameList: 子表表头中文名称
 * subfieldEngNameList: 子表表头英文名称 
 */
function createTable(upLayerId, index, fieldChsNameList, fieldEngNameList, subfieldChsNameList, subfieldEngNameList)
{  
    var upLayerObj = document.getElementById(upLayerId); 
    var table = document.createElement("table");
    var tbody = document.createElement("tbody");   

    table.id = upLayerId + "_Tbl_" + index;
    table.className = "ListTable";
    table.width="80%";
    table.border = 1;

    var trtlt = document.createElement("tr");   
    var tdtlt = document.createElement("td");

    tdtlt.innerHTML = "</br>";
    tdtlt.colSpan = subfieldEngNameList.length + 1;
    tdtlt.setAttribute("align","left");
    trtlt.appendChild(tdtlt);

    var tr0 = document.createElement("tr");
    var tr1 = document.createElement("tr");
    var subTblRowId = table.id + "_" + index;
    var subfieldLen = subfieldEngNameList.length;
    for (var i = 0; i <= subfieldLen; i++) 
    {
        var td0Cur = document.createElement("td");
        var td1Cur = document.createElement("td");

        if (0 == i) 
        {
            td0Cur.width="5%";
            td0Cur.innerHTML = "<a href='#' id=" + subTblRowId +" >添加</a>";
            td1Cur.innerHTML = "<input type='hidden' name='_hidden' /><a href='#' onclick='deleteRow(\"" 
                    + table.id + "\", this, " + index + ", false)'>删除</a>";
        } else if (subfieldLen == i) 
        {
            td0Cur.innerHTML = "<td>" + subfieldChsNameList[i-1] + "</td>";
            td1Cur.innerHTML = "<input type=text style=\"width:100%\" readonly=\"readonly\" name=" 
                + subfieldEngNameList[i-1] + " ></input>";
        } else 
        {
            td0Cur.innerHTML = "<td>" + subfieldChsNameList[i-1] + "</td>";
            td1Cur.innerHTML = "<input type=text style=\"width:100%\" name=" + subfieldEngNameList[i-1] + " ></input>";              
        }

        tr0.appendChild(td0Cur);
        tr1.appendChild(td1Cur);                    
    }

    tbody.appendChild(trtlt);
    tbody.appendChild(tr0);
    tbody.appendChild(tr1);
    table.appendChild(tbody);

    var aDiv= document.createElement("div");         
    aDiv.id = upLayerId + '_Div_' + index; 
    aDiv.appendChild(table);
    upLayerObj.appendChild(aDiv);

    document.getElementById(subTblRowId).onclick= 
    function(){ addRow(table.id, false, fieldChsNameList, fieldEngNameList, subfieldChsNameList, subfieldEngNameList);}
    
    // 子表附加金额总和
    var aDivAddLeft= document.createElement("div");
    aDivAddLeft.style.width= "50%";
    aDivAddLeft.innerHTML = "<br>";
    aDivAddLeft.style.float= "left";

    var aDivAddMid= document.createElement("div");
    aDivAddMid.style.width= "10%";
    aDivAddMid.innerHTML = "小计";
    aDivAddMid.style.float= "left";

    var aDivAddRight= document.createElement("div");
    aDivAddRight.id = "sub_grpAmount_" + index;
    aDivAddRight.innerText = "0.0";        
    aDivAddRight.style.width = "20%";
    //aDivAddRight.style.backgroundColor='#ff0000';
    aDivAddRight.style.float= "left";

    var aDivWrapper= document.createElement("div");
    aDivWrapper.style.display ="inline";
    aDivWrapper.appendChild(aDivAddLeft);
    aDivWrapper.appendChild(aDivAddMid);
    aDivWrapper.appendChild(aDivAddRight);
    aDiv.appendChild(aDivWrapper);    
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
function addRow(tableId, createSubTbl, fieldChsNameList, fieldEngNameList, 
        subfieldChsNameList, subfieldEngNameList)
{

    var tab = document.getElementById(tableId);
    var rowIndex = tab.rows.length;
    var lastrowIndex = rowIndex;

    var tr = tab.insertRow(rowIndex); // 添加一行;
    var curTypeTbl = createSubTbl ? fieldEngNameList:subfieldEngNameList;
    var curTypeTblLen =curTypeTbl.length;
    for (var i = 0; i <= curTypeTblLen; i++) 
    {
        var tdCur = tr.insertCell(i);
        if (0 == i) 
        {
            tdCur.innerHTML = "<input type='hidden' name='_hidden' /><a href='#' onclick='deleteRow(\"tab\", this," 
                    + rowIndex + "," + createSubTbl + ")'>删除</a>";             
        } else  if (i == curTypeTblLen) 
        {
            tdCur.innerHTML = "<input type=text style=\"width:100%\" name=\"" + curTypeTbl[i-1] + "\" readonly=\"readonly\" />";
        } else 
        {
            tdCur.innerHTML = "<input type=text style=\"width:100%\" name=\"" + curTypeTbl[i-1] + "\" />";
        }
    }
     
    // 初始化行; 
    lastrowIndex = initRows(tab);

    if (createSubTbl) 
    {
        createTable('subDivId', lastrowIndex, fieldChsNameList, fieldEngNameList, subfieldChsNameList, subfieldEngNameList);
    }

    // 服务组名称变更, 联动服务明细列表表头名称变更
    $("input[name='productType']").unbind("blur").bind("blur", function(){
        
        var hiddenInput =  $(this).parent().prev().find("input")[0].value;
        
        if (this.value.length > 0) {
            $("#subDivId_Div_"+hiddenInput).find("table").find("tbody").
            find("tr:eq(0) td:eq(0)").text(this.value);
        }
        
        currencyChange();
    });
      
             
    // 绑定-子组别金额变更-一条记录金额的变更
    $("input[name=amount], input[name=unitPrice]").unbind("blur").bind("blur", function()
    {
        var curSubTbl =  $(this).parent().parent().parent();
        var trSet = $(curSubTbl).find("tr");
        var curGrpAmount = 0;
        $.each(trSet, function (idx, tr)
        {
            var amount = $(tr).find("input[name=amount]");
            var unitPrice = $(tr).find("input[name=unitPrice]");
            if (typeof(amount.val()) =="undefined"  || typeof(unitPrice.val()) == "undefined") 
            {
                    return;
            }
            var _amount = 0;
            var _unitPrice = 0;
            var _resultOfAmount = 0;
            if (isNaN(amount.val())) 
            { 
                $(amount).val("");
            } else 
            {
                _amount = $(amount).val();
            }
            if (isNaN(unitPrice.val())) 
            {
                $(unitPrice).val("");
            } else { 
                _unitPrice = $(unitPrice).val();
            }
            _resultOfAmount = _amount * _unitPrice;
            curGrpAmount = curGrpAmount + _resultOfAmount;
            $(tr).find("input[name=totalAmt]").val(_resultOfAmount.toFixed(2));
        });
        
        var curSubDivId =  $(this).parent().parent().parent().parent().attr("id");
        var curSubidx = curSubDivId.match(/\d+$/)[0];
        var curSubGrpAmountDiv = "#sub_grpAmount_" + curSubidx;
        $(curSubGrpAmountDiv).html(curGrpAmount.toFixed(2));
        $("#mainDivId").find("table").find("tr:eq("+curSubidx+")").find("input[name=grpAmount]").val(curGrpAmount.toFixed(2));
                                 
        // 设置主组总金额
        var mainTblTr =  $("#mainDivId").find("table").find("tr");
        var withTaxAmt = 0;
        $.each(mainTblTr, function (idx, tr)
        {        	
        	var mainHidden = $(tr).find("input[type=hidden]");
     		if (0 == mainHidden.length) { // 过滤非数据行
     			return;
         	}
     		var mainHiddenIdx = mainHidden.val();
     		if (mainHiddenIdx == curSubidx) { // 设置当前主组金额
     			$(tr).find("input[name=grpAmount]").val(curGrpAmount.toFixed(2));
     		}

            var _grpAmount = 0;
            var grpAmount = $(tr).find("input[name=grpAmount]");
            if (typeof(grpAmount.val()) =="undefined") 
            {
                return;
            }

            if (isNaN($(grpAmount).val())) {
                $(grpAmount).val(0);
            } else {
                _grpAmount = parseFloat($(grpAmount).val());
            }

            withTaxAmt = withTaxAmt + _grpAmount;
        });

        $("#mainDivId").find("#area_sumAmount").find("#withTaxAmt").html(withTaxAmt.toFixed(2));
        $("#mainDivId").find("#area_sumAmount").find("#dealAmt").html(withTaxAmt.toFixed(2));
        $("#mainDivId").find("#area_sumAmount").find("#finalAmt").html(withTaxAmt.toFixed(2));
    });
}  

/*
 * 初始化行, 设置序列号 
 */
function initRows(tableId){  
   var tabRows = tableId.rows.length; 
   var maxIdx = 0;
   // get the max value, set the next start postion where new index will start from
   for(var i = 0; i < tabRows; i++){
       var h = tableId.rows[i].cells[0].firstChild;
   	   if (h && typeof(h.value) != "undefined") {
   	   	  if(!isNaN( h.value) && h.value > maxIdx) {
   	   	  	  maxIdx = h.value;
   	   	  }
   	   }
   }

   for(var i = 0;i<tabRows;i++){
       var h = tableId.rows[i].cells[0].firstChild;
   	   if (h && typeof(h.value) != "undefined") {
   	   	    if("" == h.value) {
   	   	    	maxIdx = parseInt(maxIdx) + 1;
   	   	  	    h.value = maxIdx;
   	   	    }
   	   }
   }
   
   return maxIdx;
}

//删除行;(obj代表连接对象)  
function deleteRow(tableId, obj, index, deleteSubTbl)
{
      
    var tr = obj.parentNode.parentNode; // 获取tr对象;  
    var tab = document.getElementById(tableId);  
 
    if(tab.rows.length>1)
    {  
        tr.parentNode.removeChild(tr);  
    }
      
    initRows(document.getElementById(tableId)); //重新生成行号; 
    
    
    var subDiv = document.getElementById("subDivId_Div_" + index);
    var subTbl = document.getElementById("subDivId_Tbl_" + index);
    if (deleteSubTbl && null != subTbl) 
    { // 删除子表与子标签
        subTbl.parentNode.removeChild(subTbl);
    }

    if (deleteSubTbl && null != subDiv) 
    {
        subDiv.parentNode.removeChild(subDiv);
    }
}

</script>
</head>


<body class="gray-bg">
	<div class="wrapper wrapper-content">
                
<form name="myForm">
    <div id="headDivId">
        <table id="headTab" style="text-align:center;width:80%;" border="1px">  
           <tr>
               <td>至：</td><td>${data.custName}</td><td>报价日期</td>
               <td align="center">
					<fmt:formatDate value="${data.quotationDate}" pattern="yyyy/MM/dd"/>  
               </td>
           </tr>
           <tr>
               <td>客户公司：</td><td>${data.company}</td><td>报价单号</td>
               <td id="quotationCode">${data.quotationCode}</td>
           </tr>
           <tr>
               <td>联系电话：</td><td>${data.companyPhone}</td>
               <td>结算币种</td><td>                        
               <select id="settlementType" name="settlementType" style="width:170px;">
                   <option value="RMB" <c:if test="${quotationRlt.settlementType=='RMB'}">selected</c:if>>人民币</option>
		           <option value="USD" <c:if test="${quotationRlt.settlementType=='USD'}">selected</c:if>>美元</option>
		           <option value="EUR" <c:if test="${quotationRlt.settlementType=='EUR'}">selected</c:if>>欧元</option>
		           <option value="GBP" <c:if test="${quotationRlt.settlementType=='GBP'}">selected</c:if>>英镑</option>
		           <option value="JPY" <c:if test="${quotationRlt.settlementType=='JPY'}">selected</c:if>>日元</option>
               </select>                        
               </td>
           </tr>              
           <tr>
               <td>联系传真：</td><td>${data.companyFax }</td>
               <td>付款方式</td><td>
                   <select id="payType" name="payType" style="width:170px;" >
                       <option value="001" <c:if test="${data.settlementType=='001'}">selected</c:if>>现金</option>
					   <option value="002" <c:if test="${data.settlementType=='002'}">selected</c:if>>支票</option>
					   <option value="003" <c:if test="${data.settlementType=='003'}">selected</c:if>>转账</option>
                   </select>
               </td>
           </tr> 
           <tr>
               <td>报价关于：</td><td id="quotationAbout">${data.quotationAbout }</td><td>销售人员</td><td>
                   <select id="staffCode" name="staffCode" style="width:170px;">
		                <c:forEach items="${fns:findUserRuleCodeOrId('02','')}" var="dict">
							<option value="${dict.id}" ${dict.id==data.staffId?'selected':''}>${dict.name}</option>
						</c:forEach>
                    </select>
                </td>
            </tr>
        </table>
    </div>
    <div id='mainDivId'>
        <table width="80%" id="tab" border="1px" style="text-align:center;">  
            <tr style="background-color:0099FF;color:black;"><td>
                <a id=mainAdd href="#" onclick=
                     "addRow('tab', true, 
                     ['服务组', '计价币种', '组总金额'],
                     ['productType','currency','grpAmount'],
                     ['序号','产品名称','产品描述','单位','数量','单价(人民币)','金额(人民币)'],
                     ['orderNo','productName','productDesc', 'unin', 'amount', 'unitPrice', 'totalAmt'])">添加
                 </a></td><td colspan="3">项目总价（大写）：</td></tr>
                  <c:forEach var="item" varStatus="status" items="${result}">
                    <tr class="hideStyle">
                    <td><input type="hidden" name="_hidden" value="${status.index+1}"><a href="#" onclick="deleteRow('tab', this,${status.index+1},true)">删除</a></td>
                    <td><input type="text" style="width:100%" name="productType" value="${item.name}"></td>
                    <td><input type="text" style="width:100%" name="currency" id="currency"></td>
                    <td><input type="text" style="width:100%" name="grpAmount" value="${item.price}"readonly="readonly"></td>
                    </tr>             
                  </c:forEach>
        </table>
        <div id='area_sumAmount' style="width:100%;" >
            <table width="80%" border="1px" style="text-align:center;">  
                <tr ><td width="50%"></td><td>含税总价：</td><td colspan="3"> <div id="withTaxAmt" >${data.withTaxAmt}</div></td></tr>
                <tr ><td></td><td> 优惠：</td><td colspan="3"><input type="text" id="privilegeAmt" name="privilegeAmt" value="${data.privilegeAmt }" style="text-align: right;" /></td></tr>
                <tr ><td></td><td>最终价格：</td><td colspan="3"> <div id="dealAmt"><fmt:formatNumber type="currency" value="${data.dealAmt}" /></div></td></tr>
            </table>
            <div style="display:inline">
                <div style="width:65%;border:1px solid #FFF;float:left"></div>
                <div style="width:15%;border:1px solid #FFF;float:left" id="finalAmt">${data.dealAmt}</div>
            </div>
        </div>
    </div>
    <p><p>
    <div id='subDivId'>
    <c:forEach var="item" varStatus="status" items="${result}">
             <div id="subDivId_Div_${status.index+1}">
             <table id="subDivId_Tbl_${status.index+1}" class="ListTable" width="80%" border="1">
             <tbody>
             <tr><td colspan="8" align="left">${item.name}</td></tr>
             <tr>
             <td width="5%"><a href="#" id="subDivId_Tbl_${status.index+1}_${status.index+1}" onclick=
	                        "addRow('subDivId_Tbl_${status.index+1}', false, 
	                        ['服务组', '计价币种', '组总金额'],
	                        ['productType','currency','grpAmount'],
	                        ['序号','产品名称','产品描述','单位','数量','单价(人民币)','金额(人民币)'],
	                        ['orderNo','productName','productDesc', 'unin', 'amount', 'unitPrice', 'totalAmt'])">添加</a></td>
             <td>序号</td>
             <td>产品名称</td>
             <td>产品描述</td>
             <td>单位</td>
             <td>数量</td>
             <td>单价(人民币)</td>
             <td>金额(人民币)</td>
             </tr>
             <c:forEach var="item2" varStatus="status2" items="${item.detail}">
             <tr>
             <td><input type="hidden" name="_hidden"><a href="#" onclick="deleteRow('subDivId_Tbl_1', this, 1, false)">删除</a></td>
             <td><input type="text" style="width:100%" name="orderNo" value="${item2.orderNo}"></td>
             <td><input type="text" style="width:100%" name="productName" value="${item2.productName}"></td>
             <td><input type="text" style="width:100%" name="productDesc" value="${item2.productDesc}"></td>
             <td><input type="text" style="width:100%" name="unin" value="${item2.unin}"></td>
             <td><input type="text" style="width:100%" name="amount" value="${item2.amount}"></td>
             <td><input type="text" style="width:100%" name="unitPrice" value="${item2.unitPrice}"></td>
             <td><input type="text" style="width:100%" readonly="readonly" name="totalAmt" value="${item2.totalAmt}"></td>
             </tr>
              </c:forEach>
             </tbody>
             </table>
             <div>
             <div style="width: 50%; float: left;"><br></div>
             <div style="width: 10%; float: left;">小计</div>
             <div id="sub_grpAmount_1" style="width: 20%; float: left;">${item.price}</div>
             </div>
             </div>
             </c:forEach>
    </div>

    <div id="tailDivId">
        <table width="80%" id="tailTab" border="1px" style="text-align:center;">
            <tr class="tr-left"><td width="5%">备注</td><td></td></tr>
            <tr class="tr-left"><td ></td><td>1.报价均已含税（产品开具17%增值税发票，服务开具6%增值税发票）</td></tr>
            <tr class="tr-left"><td></td><td>2.报价有效期5个工作日</td></tr>
            <tr class="tr-left"><td></td><td><div id="arrivalDays">3.到货时间：报价单签字确认回传合同签订后
                <input type=text  name="arrivalDays" value="${data.arrivalDays}" style="width:50px;align:center"/>个工作日</div></td></tr>
            <tr class="tr-left"><td></td><td>4付款期限：</td></tr>
            <tr class="tr-left"><td></td><td>
            <input type="radio" name="deliveryMode" id="radio" <c:if test="${data.deliveryMode=='001'}">checked</c:if>  value="001">款到发货<br>
            </td></tr>
            <tr class="tr-left"><td></td><td>
            <input type="radio" name="deliveryMode" id="radio" value="002" <c:if test="${data.deliveryMode=='002'}">checked</c:if>/>货到
            <input type="text" id="waitDays" name="waitDays" <c:if test="${data.deliveryMode=='002'}"> value="${data.otherAdd}" </c:if>  style="width:50px;" /> 工作日(现金、支票、转账)付款。                                
            </td></tr>
            <tr class="tr-left"><td></td><td>
            <input type="radio" name="deliveryMode" id="radio" value="003" <c:if test="${data.deliveryMode=='003'}">checked</c:if> />其他
            <input type="text" id="otherChoice" name="otherChoice" <c:if test="${data.deliveryMode=='003'}"> value="${data.otherAdd}" </c:if> style="width:500px;" />。
            </td></tr>                
         </table>
     </div>

     <div id="submitId" align="center">
     	 <input id="_id" value="${data.id}" class="i-checks" hidden="true">
         <input type=button value="提交核价" id="submitPriceSheet" />
         <input type=button value="提交报价单" id="submitPriceSheetDirect" />
     </div>
</form>
</div>

<script type="text/javascript">
// 初始化客户信息
$("#custName").val('${custName}');         // 客户公司  custName
$("#company").val('${company}');           // 客户公司  company
$("#companyPhone").val('${companyPhone}'); // 联系电话  companyPhone
$("#companyFax").val('${companyFax}');     // 联系传真  companyFax

var curStdFmtDate = getNowFormatDate(); // 设置当前报价日期
$("#quotationDate").val(curStdFmtDate);


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


// 直接提交报价单
$("#submitPriceSheetDirect").click(function()
{
    if(!chkEssentialInput()) {
        return;
    }
    var directPriceSheet = getPriceSheetJson();
    directPriceSheet.transType = "001";
    
    $.ajax(
    {
        type:'post',
        data:JSON.stringify(directPriceSheet),
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


// 提交核价
$("#submitPriceSheet").click(function()
{
    if(!chkEssentialInput()) {
        return;
    }

    var directPriceSheet = getPriceSheetJson();
    directPriceSheet.transType = "002";

    $.ajax({
        type:'POST',
        data:JSON.stringify(directPriceSheet),
        contentType :'application/json',
        dataType:'json',        
        URL :'${ctx}/quotation/quotationOrder/save',
        async: false,
        headers:
        {
            Accept:'application/json', 'Content-Type': 'application/json'
        },
        success :function(data) 
        {
            if ("0" == data.state) 
            {
                alert("【报价单保存失败】\n" + data.msg);                
            } else if ("1" == data.state) 
            {
                alert("【报价单保存成功】\n" + data.msg);
                $("#headDivId").find("input[name=quotationCode]").val(data.quotationCode);
            } else 
            {
                alert("【报价单提交失败】\n 请输入必要的报价单数据！！！");       
            }
        },
        error :function(e) 
        {
            alert("报价单保存异常！！！");
        }
    });
});
</script>

</body>
</html>
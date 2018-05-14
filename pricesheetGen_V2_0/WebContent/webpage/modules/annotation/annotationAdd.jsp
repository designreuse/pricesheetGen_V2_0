<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" isErrorPage="true" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<html>
    <head>
        <title>注释商品</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <meta name="decorator" content="default"/>
	    <!-- SUMMERNOTE -->
		<link href="${ctxStatic}/summernote/summernote-bs3.css" rel="stylesheet">

		<style>
		.div-td table td{ background:#CCC; color:#000; line-height:40px} 
		.tr-left {margin:0 auto;border:1px solid;text-align:left;}
		</style>

<script src="${ctxStatic}/json/json2.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>

<script type="text/javascript">
function makeIptArr(parentNode, jObj, addObj){
	var arrObj = new Array();
	var fieldObj = {};
	var fieldString = "";
	var lenObj = $(jObj).length;
    for (var i=0; i<lenObj;i++) {
	    	var _name = $(jObj).eq(i).attr("name");
	    	var _val = $(jObj).eq(i).val(); 	
	    	parentNode[_name] = _val;
    }

    // 补充的对象
    if(addObj) {
	    	var _name = $(addObj).attr("name");
	    	var _val = $(addObj).val(); 	
	    	parentNode[_name] = _val;
    }  
    return;
}

// 组织商品注释返回Json对象
function geAnnoJson() {

	// 商品注释总信息json实体
	var quotationCode = $("#headDivId").find("#headTab").find("input[name='quotationCode']").val();
	var quotationId = $("#headDivId").find("#headTab").find("input[name='quotationId']").val();

	// 商品注释明细信息
	var objBody = null;
	var objBodyList= null;
	var fieldsTrObj = $("#mainDivId").find("#mainTab").find("tr");
	var detailId = null;
	var isMaster = 0;
	$.each(fieldsTrObj, function (index, domEle){

		// 跳过第一行
		var fieldsInput = $(domEle).find("input:hidden");							     
		if (0 >= fieldsInput.length) {
              return;
		}

		// var idxRow = fieldsInput[0].value;
        if(null == objBodyList) {
            objBodyList = new Array();
        }

        var fieldsTds = $(domEle).find("td");							     
		if (1 == fieldsTds.length) {
			objBody = {};
			objBody.quotationCode = quotationCode;
			objBody.detailId = detailId;
			objBody.isMaster = isMaster;
		    var aAnno = $(fieldsTds).find("div").find("li").find("input");
            makeIptArr(objBody, aAnno, null );
            objBodyList.push(objBody);
            isMaster++;
		} else {
			isMaster = 0;
		    detailId = $(fieldsTds).find("input[name='uid']").val();	
		}
	});
	return objBodyList;
}


//删除行;(obj代表连接对象)  
function deleteRow(tableId, obj, index){
    var tab = document.getElementById(tableId);  
    //获取tr对象;  
    var tr = obj.parentNode.parentNode.parentNode.parentNode;  
  
    if(tab.rows.length>1){
        //tr.parentNode，指的是，table对象;移除子节点;  
        tr.parentNode.removeChild(tr);  
    }
    //重新生成行号;  
    initRows(document.getElementById(tableId));
}

/*
* 初始化行, 设置序列号 
*/
function initRows(tableId){  
	var tabRows = tableId.rows.length; 
	for(var i = 0;i<tabRows;i++){
	   var h = tableId.rows[i].cells[0].firstChild;
		   if (h && typeof(h.value) != "undefined") {
		       h.value = i;
		   }
	}
}

/* 
* 给表添加一行
* tableId: 表的Id 
* createSubTbl: 当前表为主表还是子表
* fieldChsNameList: 主表中文表头名称 
* fieldEngNameList: 主表英文表头名称
* subfieldChsNameList: 子表表头中文名称
* subfieldEngNameList: 子表表头英文名称 
*/
function addRow(objBind, tableId, insertSubTbl, fieldChsNameList, fieldEngNameList, valueList, subfieldChsNameList, subfieldEngNameList, subvalueList)
{
	var tabObj = document.getElementById(tableId);
	var rowIndex = tabObj.rows.length;
	var subblockId = "subDivId";
	var curTypeTbl = insertSubTbl ? subfieldEngNameList:fieldEngNameList;
	var curvalueList = insertSubTbl ? subvalueList:valueList;
	var curTypeTblLen =curTypeTbl.length; 
	
	if (insertSubTbl)  { // 创建注释
	
	 	var lastRowOfBlock =  $(objBind).parent().parent();
	 	var lineNoOfChoosen =  $(lastRowOfBlock).find("td").find("input")[0].value;
	 	var idxRow = rowIndex;
	 	var isLastLine = (rowIndex == parseInt(lineNoOfChoosen) + 1) ? true : false; //  最后一行, 增加到末尾
	
	 	for (;  false == isLastLine && 0 != lastRowOfBlock.length; ) {
	 		
	 		curRowOfBlock  = $(lastRowOfBlock).next();
	 		if (0 != curRowOfBlock.length) {
	 			lastRowOfBlock = curRowOfBlock;
	 		}  else {
	 			isLastLine  = true;  // 有结尾, 没开始, 称为最后行
	 		    break;
	 		}
	 		if (0 == $(lastRowOfBlock).find("td").find("#"+subblockId).length) {
	 			isLastLine  = false; // 有结尾, 没开始, 称为最后行
	 			break;
	 		}
	 	}
	 	
	     if (false == isLastLine) {
	      	idxRow =  parseInt($(lastRowOfBlock).find("td").find("input")[0].value);
	     }
	
	    // 添加一行
	   	var tr = tabObj.insertRow(idxRow);
	    var tdField = tr.insertCell();
	    tr.align = "right";
	    tdField.colSpan = fieldEngNameList.length + 1;
	
	    var hiddenIpt = document.createElement("input");
	    hiddenIpt.type = 'hidden';
	    hiddenIpt.name = '_hidden';
	    hiddenIpt.value = idxRow;
	    tdField.appendChild (hiddenIpt);
	       		 
	    var delLink = document.createElement("a");
	     delLink.setAttribute('href','#');
	     delLink.setAttribute('line', idxRow);	      
	     delLink.name = "delLink";      
	     delLink.appendChild(document.createTextNode(" 删除 "));
	     delLink.style.textDecoration = 'none';
	     delLink.onclick=function(){
	          deleteRow(tabObj.id, this, idxRow, false);
	     }
	              
	     var divsubTbl = document.createElement("div");
	    divsubTbl.style.float= "left";
	    divsubTbl.style.width= "100%";
	    divsubTbl.id = subblockId;
	         		     
	    var divsubLi = document.createElement("li");
	    var divsubInput = null;
	    var divsubLabel = null;
	
	    divsubLi.style.listStyleType= "none";		      
	    divsubLi.appendChild (delLink); 
	
	    for (var i = 0; i < subfieldEngNameList.length; i++) {		     
		     divsubLabel = document.createElement("label");
		     divsubInput = document.createElement("input");

	    	 divsubInput.type = 'text';
		     divsubLabel.innerHTML = subfieldChsNameList[i];
		     divsubLabel.width = "200px";		     
		     divsubInput.type = 'text';

		     divsubInput.name = subfieldEngNameList[i];
		     divsubInput.value = (null != subvalueList) ? subvalueList[subfieldEngNameList[i]] : "";

			 divsubLi.appendChild (divsubLabel);		    	 
	         divsubLi.appendChild (divsubInput);
		}

	    divsubTbl.appendChild (divsubLi);
	    tdField.appendChild (divsubTbl);
	
	    initRows (tabObj);
	}  else {
	 	
		// 创建父表
	    var tr = tabObj.insertRow(rowIndex); 
	    var tdCur = null;

	 	// 添加各个列
	    for (var i = 0; i <= curTypeTblLen; i++) {

		    if (0 == i) {
		    	  tdCur = tr.insertCell(i);
		          var hiddenIpt = document.createElement("input");
		          hiddenIpt.type = 'hidden';
		          hiddenIpt.name = '_hidden';
		          hiddenIpt.value = rowIndex;
		          var addLink = document.createElement("a");
		          addLink.setAttribute('href','#');
		          addLink.setAttribute('line', rowIndex);	            
	              addLink.appendChild(document.createTextNode("添加"));
	               addLink.name = "addLink";
		          tdCur.appendChild (hiddenIpt);
		          tdCur.appendChild (addLink);
		          addLink.onclick=function(){
		          addRow(this, tabObj.id, true, fieldChsNameList, fieldEngNameList, valueList, subfieldChsNameList, subfieldEngNameList, null);}
		      } else if (1 == i) {  // 隐藏报价单明细 uid		     
		    	  var uidIpt = document.createElement("input");
		    	  uidIpt.type = 'hidden';
		    	  uidIpt.name = curTypeTbl[i-1];
		    	  uidIpt.value = curvalueList[i-1];
		          tdCur.appendChild (uidIpt);
		      } else {
		    	  tdCur = tr.insertCell(i - 1);
		          tdCur.innerHTML = "<input type=text style=\"width:100%\" name=\"" + curTypeTbl[i-1] +"\" value=\""+curvalueList[i-1]+ "\" readonly=\"readonly\" />";
		      }
		}
	}
	
	
    $("input[name=annoPrice]").unbind("blur").bind("blur", function() { // 绑定-注释价格变更

        var annoPrice = $(this).val(); 
        annoPrice = parseFloat(annoPrice);
        if (isNaN(annoPrice)) {
        	annoPrice = 0.00;
        }
        $(this).val(annoPrice.toFixed(2));
	});
}


</script>

<body class="gray-bg">
<div class="wrapper wrapper-content">
<form name="myForm">
    <div id="headDivId">
      <table id="headTab" name="headTab" width="80%" border="1px" style="text-align:center;">
       <tbody>
	       	<tr>
	     	    <th colspan="4" style="text-align:center;">商品注释</th>
	        </tr>
	       	<tr>
	     	    <td style="width:30%;"></td>
	     	    <td>报价单号：</td>
	     	    <td><input type=text name="quotationCode" style="width:100%;"  disabled="disabled" /></td>
	     	    <td style="width:30%;"></td>
	        </tr>
        </tbody>
      </table>
    </div>

    <div id='mainDivId'>
        <table id="mainTab" name="mainTab" width="80%" border="1px" style="text-align:center;">  
            <tr style="background-color:0099FF;color:black;">
            	<td style="width:40px;">注解</td>
            	<td style="width:40px;">序号</td>
            	<td style="width:100px;">产品名称</td>
            	<td >产品描述</td>
            	<td style="width:40px;">单位</td>
            	<td style="width:40px;">数量</td>
            	<td style="width:80px;">单价(人民币)</td>
            	<td style="width:100px;">金额(人民币)</td>
             </tr>
        </table>
    </div>   
    <div id="submitId" align="center">
        <input type=button value="提交" id="submitAnno" />
    </div>
</form>                
</div>

<script type="text/javascript">
var quotationCode = '<%=request.getParameter("quotationCode")%>';
$("#headDivId").find("#headTab").find("input[name='quotationCode']").val(quotationCode);


$("#submitAnno").click(function(){

	var annoList = geAnnoJson();

    $.ajax({    	
        type:'POST',
        data:JSON.stringify(annoList),
        contentType :'application/json',
        dataType:'json',
        url :'${ctx}/annotation/annotation/saveList',
        headers:{
            Accept:'application/json', 'Content-Type': 'application/json'
        },
        success :function(obj) {
        	data = obj.body;
            if (null != data && "0" == data.state) {
                alert('【产品注释保存失败】！');
            } else if (null != data && "1" == data.state) {
            	alert('【产品注释保存成功】\n' + data.msg);
            } else {
            	alert('【产品注释保存失败】\n数据处理异常！');
            }
        },
        error :function(e) {
            alert("产品注释保存异常！！！");
        }
    });
}); 


var fieldChsNameList = ['uid','序号','产品名称','产品描述','单位','数量','单价(人民币)','金额(人民币)'];
var fieldEngNameList = ['uid','orderNo','productName','productDesc', 'unin', 'amount', 'unitPrice', 'totalAmt'];
var subfieldChsNameList = ['品牌', '型号', '价格', '备注'];
var subfieldEngNameList = ['annoName','annoType','annoPrice', 'remark'];
var ipt;
 

var subLen = 0;
var idxPos = 0;
<c:forEach items="${detailListRlt}" var="detailListRlt" varStatus="status" >
    var detail = {};
    var detailList = [];
    detail.uid = '${detailListRlt.uid}';
    detail.orderNo = '${detailListRlt.orderNo}';
    detail.productName = '${detailListRlt.productName}';
    detail.productDesc = '${detailListRlt.productDesc}';    
    detail.unin = '${detailListRlt.unin}';
    detail.amount = '${detailListRlt.amount}';
    detail.unitPrice = '${detailListRlt.unitPrice}';
    detail.totalAmt = '${detailListRlt.totalAmt}';
    detailList.push(detail.uid);
    detailList.push(detail.orderNo);
    detailList.push(detail.productName);
    detailList.push(detail.productDesc);
    detailList.push(detail.unin);
    detailList.push(detail.amount);
    detailList.push(detail.unitPrice);
    detailList.push(detail.totalAmt);
	addRow(null, "mainTab", false, fieldChsNameList, fieldEngNameList, detailList, subfieldChsNameList, subfieldEngNameList, null);

    idxPos = idxPos + subLen+ 1;
    var objBind = $("#mainTab").find("tr:eq(" + idxPos + ")").find("td:eq(0)").find("input")[0];    

    subLen = 0;
    <c:forEach items="${detailListRlt.annotation}" var="annotation" varStatus="s" >
	    var annotation = '${annotationt}';
	    var annotationList = [];

	    annotationList.is_master  = '${s.index}';
	    annotationList.annoName = '${annotation.annoName}';
	    annotationList.annoType = '${annotation.annoType}';
	    annotationList.annoPrice = '${annotation.annoPrice}';
	    annotationList.remark = '${annotation.remark}';

		// 构造子列表
		subLen++;
	    addRow(objBind, "mainTab", true, fieldChsNameList, fieldEngNameList, detailList, subfieldChsNameList, subfieldEngNameList, annotationList);
	</c:forEach>
</c:forEach>

</script>


</body>
</html>
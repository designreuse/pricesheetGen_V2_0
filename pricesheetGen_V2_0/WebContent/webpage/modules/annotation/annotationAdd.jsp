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
		<link rel="stylesheet" href="${ctxStatic}/tinyselect/css/tinyselect.css">
		<style>
		.div-td table td{ background:#CCC; color:#000; line-height:40px} 
		.tr-left {margin:0 auto;border:1px solid;text-align:left;}
		</style>

<script src="${ctxStatic}/json/json2.js" type="text/javascript"></script>
<script src="${ctxStatic}/tinyselect/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<%-- <script src="${ctxStatic}/jquery/jquery-1.4.2.min.js" type="text/javascript"></script> --%>
<script src="${ctxStatic}/tinyselect/js/tinyselect.js"></script>
<script type="text/javascript">
// function makeIptArr(parentNode, jObj, addObj){
// 	var arrObj = new Array();
// 	var fieldObj = {};
// 	var fieldString = "";
// 	var lenObj = $(jObj).length;
//     for (var i=0; i<lenObj;i++) {
// 	    	var _name = $(jObj).eq(i).attr("name");
// 	    	var _val = $(jObj).eq(i).val(); 	
// 	    	parentNode[_name] = _val;
//     }

//     // 补充的对象
//     if(addObj) {
// 	    	var _name = $(addObj).attr("name");
// 	    	var _val = $(addObj).val(); 	
// 	    	parentNode[_name] = _val;
//     }  
//     return;
// }




//删除行;(obj代表连接对象)  
// function deleteRow(tableId, obj, index){
//     var tab = document.getElementById(tableId);  
//     //获取tr对象;  
//     var tr = obj.parentNode.parentNode.parentNode.parentNode;  
  
//     if(tab.rows.length>1){
//         //tr.parentNode，指的是，table对象;移除子节点;  
//         tr.parentNode.removeChild(tr);  
//     }
//     //重新生成行号;  
//     initRows(document.getElementById(tableId));
// }

/*
* 初始化行, 设置序列号 
*/
// function initRows(tableId){  
// 	var tabRows = tableId.rows.length; 
// 	for(var i = 0;i<tabRows;i++){
// 	   var h = tableId.rows[i].cells[0].firstChild;
// 		   if (h && typeof(h.value) != "undefined") {
// 		       h.value = i;
// 		   }
// 	}
// }

/* 
* 给表添加一行
* tableId: 表的Id 
* createSubTbl: 当前表为主表还是子表
* fieldChsNameList: 主表中文表头名称 
* fieldEngNameList: 主表英文表头名称
* subfieldChsNameList: 子表表头中文名称
* subfieldEngNameList: 子表表头英文名称 
*/
// function addRow(objBind, tableId, insertSubTbl, fieldChsNameList, fieldEngNameList, valueList, subfieldChsNameList, subfieldEngNameList, subvalueList)
// {
// 	var tabObj = document.getElementById(tableId);
// 	var rowIndex = tabObj.rows.length;
// 	var subblockId = "subDivId";
// 	var curTypeTbl = insertSubTbl ? subfieldEngNameList:fieldEngNameList;
// 	var curvalueList = insertSubTbl ? subvalueList:valueList;
// 	var curTypeTblLen =curTypeTbl.length; 
	
// 	if (insertSubTbl)  { // 创建注释
	
// 	 	var lastRowOfBlock =  $(objBind).parent().parent();
// 	 	var lineNoOfChoosen =  $(lastRowOfBlock).find("td").find("input")[0].value;
// 	 	var idxRow = rowIndex;
// 	 	var isLastLine = (rowIndex == parseInt(lineNoOfChoosen) + 1) ? true : false; //  最后一行, 增加到末尾
	
// 	 	for (;  false == isLastLine && 0 != lastRowOfBlock.length; ) {
	 		
// 	 		curRowOfBlock  = $(lastRowOfBlock).next();
// 	 		if (0 != curRowOfBlock.length) {
// 	 			lastRowOfBlock = curRowOfBlock;
// 	 		}  else {
// 	 			isLastLine  = true;  // 有结尾, 没开始, 称为最后行
// 	 		    break;
// 	 		}
// 	 		if (0 == $(lastRowOfBlock).find("td").find("#"+subblockId).length) {
// 	 			isLastLine  = false; // 有结尾, 没开始, 称为最后行
// 	 			break;
// 	 		}
// 	 	}
	 	
// 	     if (false == isLastLine) {
// 	      	idxRow =  parseInt($(lastRowOfBlock).find("td").find("input")[0].value);
// 	     }
	
// 	    // 添加一行
// 	   	var tr = tabObj.insertRow(idxRow);
// 	    var tdField = tr.insertCell();
// 	    tr.align = "right";
// 	    tdField.colSpan = fieldEngNameList.length + 1;
	
// 	    var hiddenIpt = document.createElement("input");
// 	    hiddenIpt.type = 'hidden';
// 	    hiddenIpt.name = '_hidden';
// 	    hiddenIpt.value = idxRow;
// 	    tdField.appendChild (hiddenIpt);
	       		 
// 	    var delLink = document.createElement("a");
// 	     delLink.setAttribute('href','#');
// 	     delLink.setAttribute('line', idxRow);	      
// 	     delLink.name = "delLink";      
// 	     delLink.appendChild(document.createTextNode(" 删除 "));
// 	     delLink.style.textDecoration = 'none';
// 	     delLink.onclick=function(){
// 	          deleteRow(tabObj.id, this, idxRow, false);
// 	     }
	              
// 	     var divsubTbl = document.createElement("div");
// 	    divsubTbl.style.float= "left";
// 	    divsubTbl.style.width= "100%";
// 	    divsubTbl.id = subblockId;
	         		     
// 	    var divsubLi = document.createElement("li");
// 	    var divsubInput = null;
// 	    var divsubLabel = null;
	
// 	    divsubLi.style.listStyleType= "none";		      
// 	    divsubLi.appendChild (delLink); 
	
// 	    for (var i = 0; i < subfieldEngNameList.length; i++) {		     
// 		     divsubLabel = document.createElement("label");
// 		     divsubInput = document.createElement("input");

// 	    	 divsubInput.type = 'text';
// 		     divsubLabel.innerHTML = subfieldChsNameList[i];
// 		     divsubLabel.width = "200px";		     
// 		     divsubInput.type = 'text';

// 		     divsubInput.name = subfieldEngNameList[i];
// 		     divsubInput.value = (null != subvalueList) ? subvalueList[subfieldEngNameList[i]] : "";

// 			 divsubLi.appendChild (divsubLabel);		    	 
// 	         divsubLi.appendChild (divsubInput);
// 		}

// 	    divsubTbl.appendChild (divsubLi);
// 	    tdField.appendChild (divsubTbl);
	
// 	    initRows (tabObj);
// 	}  else {
	 	
// 		// 创建父表
// 	    var tr = tabObj.insertRow(rowIndex); 
// 	    var tdCur = null;

// 	 	// 添加各个列
// 	    for (var i = 0; i <= curTypeTblLen; i++) {

// 		    if (0 == i) {
// 		    	  tdCur = tr.insertCell(i);
// 		          var hiddenIpt = document.createElement("input");
// 		          hiddenIpt.type = 'hidden';
// 		          hiddenIpt.name = '_hidden';
// 		          hiddenIpt.value = rowIndex;
// 		          var addLink = document.createElement("a");
// 		          addLink.setAttribute('href','#');
// 		          addLink.setAttribute('line', rowIndex);	            
// 	              addLink.appendChild(document.createTextNode("添加"));
// 	               addLink.name = "addLink";
// 		          tdCur.appendChild (hiddenIpt);
// 		          tdCur.appendChild (addLink);
// 		          addLink.onclick=function(){
// 		          addRow(this, tabObj.id, true, fieldChsNameList, fieldEngNameList, valueList, subfieldChsNameList, subfieldEngNameList, null);}
// 		      } else if (1 == i) {  // 隐藏报价单明细 uid		     
// 		    	  var uidIpt = document.createElement("input");
// 		    	  uidIpt.type = 'hidden';
// 		    	  uidIpt.name = curTypeTbl[i-1];
// 		    	  uidIpt.value = curvalueList[i-1];
// 		          tdCur.appendChild (uidIpt);
// 		      } else {
// 		    	  tdCur = tr.insertCell(i - 1);
// 		          tdCur.innerHTML = "<input type=text style=\"width:100%;border:0px;\" name=\"" + curTypeTbl[i-1] +"\" value=\""+curvalueList[i-1]+ "\" readonly=\"readonly\" />";
// 		      }
// 		}
// 	}
	
	
//     $("input[name=annoPrice]").unbind("blur").bind("blur", function() { // 绑定-注释价格变更

//         var annoPrice = $(this).val(); 
//         annoPrice = parseFloat(annoPrice);
//         if (isNaN(annoPrice)) {
//         	annoPrice = 0.00;
//         }
//         $(this).val(annoPrice.toFixed(2));
// 	});
// }


</script>

<body class="gray-bg">
<div class="wrapper wrapper-content white-bg" style="margin:16px;">
<form name="myForm">
    <div id="headDivId">
      <div class="title">
      		<h3>商品注释</h3>
      </div>
      <div  id="headTab" >
      		<div class="col-sm-2" style="text-align: right;font-weight: bold;" > 报价单号： </div>
      		<div class="col-sm-7"><input type=text name="quotationCode" style="width:100%;border: 0px;font-weight: bold;" readonly="readonly" /></div>
      </div>
    </div>

    <div id='mainDivId' style="margin-top:40px;">
        <table id="mainTab" name="mainTab"   class="table table-bordered table-striped table-hover" >  
            <thead>
            <tr style="background-color:0099FF;color:black;">
            	<th width="8%" style="text-align:center;" >注解</th>
            	<th width="5%" style="text-align:center;">序号</th>
            	<th style="text-align:center;">产品名称</th>
            	<th style="text-align:center;">产品描述</th>
            	<th style="text-align:center;">单位</th>
            	<th style="text-align:center;">数量</th>
            	<th style="text-align:center;">单价(人民币)</th>
            	<th style="text-align:center;">金额(人民币)</th>
            	<th style="text-align:center;">京东价</th>
            	<th style="text-align:center;">链接</th>
             </tr>
             </thead>
             <tbody>
             	<c:forEach items="${detailListRlt}" var="quotation" varStatus="status" >
             		<tr>
             			<td>
             				<c:if test="${quotation.annotation==null}">
             					<button type="button" onclick="addRow(${quotation.uid},this)">添加</button>
             				</c:if>
             			</td>
             			<td>${quotation.orderNo}</td>
             			<td>${quotation.productName}</td>
             			<td>${quotation.productDesc}</td>
             			<td>${quotation.unin}</td>
             			<td>${quotation.amount}</td>
             			<td>${quotation.unitPrice}</td>
             			<td>${quotation.totalAmt}</td>
             			<td>${quotation.jdPrice}</td>
             			<td>${quotation.url}</td>
             		</tr>
             		<c:if test="${quotation.annotation!=null}">
             			<c:forEach items="${quotation.annotation}" var="anno" varStatus="status" >
		             		<tr class="annotationDetail">
		             			<td><button type="button" onclick="removeRow(${quotation.uid},this)">删除</button></td>
		             			<td colspan="9">
		             				<input type="hidden" name="detailId" value="${quotation.uid}" />
			             			<div class="col-sm-3" style="border-right: 2px solid #bdbdbd;padding:0px;text-align: center;">
			             				<div class="col-sm-12" style="padding:0px;height: 35px;line-height: 35px;" >
			             					类型
			             				</div>
			             				<div  class="col-sm-12" style="height: 35px;">
			             					<div class="cell" >
												<input type="text" value="${anno.classfiyName}" name="classfiyName" class='form-control'  style="width:100%;height: 30px;" />
											</div>
			             				</div>
			             					<button type="button" onclick="selectClassfiy(this)" style="width:60%;margin-top:10px;">选择</button>
			             			</div>
			             			<div class="col-sm-3" style="border-right: 2px solid #bdbdbd;padding:0px;text-align: center;">
			             				<div class="col-sm-12" style="padding:0px;height: 35px;line-height: 35px;" >
			             					品牌
			             				</div>
			             				<div  class="col-sm-12" style="height: 35px;">
			             					<div class="cell" >
												<input type="text" value="${anno.annoName}" name="brandName" class='form-control'  style="width:100%;height: 30px;" />
											</div>
			             				</div>
			             					<button type="button" onclick="selectBrand(this)" style="width:60%;margin-top:10px;">选择</button>
			             			</div>
			             			<div class="col-sm-3" style="border-right: 2px solid #bdbdbd;padding:0px;text-align: center;">
			             				<div class="col-sm-12" style="padding:0px;height: 35px;line-height: 35px;" >
			             					型号
			             				</div>
			             				<div  class="col-sm-12" style="height: 35px;">
			             					<div class="cell" >
												<input type="text" value="${anno.annoType}" name="modelName" class='form-control'  style="width:100%;height: 30px;" />
											</div>
			             				</div>
			             					<button type="button" onclick="selectModel(this)" style="width:60%;margin-top:10px;">选择</button>
			             			</div>
			             			<div class="col-sm-3" style="padding:0px;text-align: center;">
			             				<div class="col-sm-2" style="padding:0px;height: 35px;line-height: 35px;" >
			             					价格：
			             				</div>
			             				<div  class="col-sm-10" style="height: 35px;">
			             					<div class="cell" >
												<input type="text" value="${anno.annoPrice}" name="annoPrice" class='form-control'  style="width:90%;height: 30px;" />
											</div>
			             				</div>
			             			</div>
		             			</td>
		             		</tr>
	             		</c:forEach>
             		</c:if>
             	</c:forEach>
             </tbody>
        </table>
    </div>   
    <div id="submitId" align="center">
        <button type="button"  class="btn btn-info" id="submitAnno" >提交</button>
    </div>
</form>                
</div>

<script type="text/javascript">
// function closes(){
// 	window.parent.location.reload();
// }
function selectClassfiy(e){
	if($(e).html()=="选择"){
		$(e).html("输入");
		selectC(e);
	}else{
		$(e).html("选择")
		$(e).parent().find(".cell").html('<input type="text" value=""  name="classfiyName" class="form-control"  style="width:100%;height: 30px;" />');
	}
}
function selectC(e){
    $.ajax({
		type : "GET",
		url :'${ctx}/product/prodClassfiy/findAllClassfiy',
		dataType : "json",
		traditional: true,
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		cache : false,
		async : false,
		success : function(data) {
	    	 console.log(data.data.classfiys);
	    	 var dhtml="<select  name='classfiyName' >";
		 		$(data.data.classfiys).each(function(i, item){
		 			dhtml+="<option value='"+item.prodClassfiyId+"'>"+item.prodClassfiyName+"</option>";	
		 		})
		 		dhtml+="</select>"; 
		 		$(e).parent().find(".cell").html(dhtml);
		 		$(e).parent().find(".cell").find("select").tinyselect();
	     },
	     error :function(e) {
	         
	     }
 });
}


function selectBrand(e){
	if($(e).html()=="选择"){
		$(e).html("输入");
		selectB(e);
	}else{
		$(e).html("选择")
		$(e).parent().find(".cell").html('<input type="text" value="" name="brandName" class="form-control"  style="width:100%;height: 30px;" />');
	}
}

function selectB(e){
    $.ajax({
		type : "GET",
		url :'${ctx}/product/prodBrand/findAllBrands',
		dataType : "json",
		traditional: true,
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		cache : false,
		async : false,
		success : function(data) {
	    	 console.log(data.data.classfiys);
	    	 var dhtml="<select name='brandName' >";
		 		$(data.data.brands).each(function(i, item){
		 			dhtml+="<option value='"+item.brandId+"'>"+item.brandName+"</option>";	
		 		})
		 		dhtml+="</select>"; 
		 		$(e).parent().find(".cell").html(dhtml);
		 		$(e).parent().find(".cell").find("select").tinyselect();
	     },
	     error :function(e) {
	         
	     }
 });
}

function selectModel(e){
	if($(e).html()=="选择"){
		$(e).html("输入");
		selectM(e);
	}else{
		$(e).html("选择")
		$(e).parent().find(".cell").html('<input type="text" value="" name="modelName" class="form-control"  style="width:100%;height: 30px;" />');
	}
}

function selectM(e){
    $.ajax({
		type : "GET",
		url :'${ctx}/product/prodModel/findAllModels',
		dataType : "json",
		traditional: true,
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		cache : false,
		async : false,
		success : function(data) {
	    	 console.log(data.data.classfiys);
	    	 var dhtml="<select name='modelName' >";
		 		$(data.data.models).each(function(i, item){
		 			dhtml+="<option value='"+item.modelId+"'>"+item.modelName+"</option>";	
		 		})
		 		dhtml+="</select>"; 
		 		$(e).parent().find(".cell").html(dhtml);
		 		$(e).parent().find(".cell").find("select").tinyselect();
	     },
	     error :function(e) {
	         
	     }
 });
}

function dataParserA(data, selected) {
	retval = [ { val: "-1" , text: "---" } ];

	data.forEach(function(v){
		if(selected == "-1" && v.val == 3)
			v.selected = true;
		retval.push(v); 
	});

	return retval;
}

function dataParserB(data, selected) {
	retval = [ { val: "-1" , text: "---" } ];
	data.forEach(function(v){ retval.push(v); });
	return retval;
}
var quotationCode = '<%=request.getParameter("quotationCode")%>';
$("#headDivId").find("#headTab").find("input[name='quotationCode']").val(quotationCode);

function addRow(detailId,e){
	var html="";
		html+='<tr class="annotationDetail">';
		html+='<td colspan="1"><button type="button"  onclick="removeRow('+detailId+',this)">删除</button></td>';
		html+='<td colspan="9">';
		html+='<input type="hidden" name="detailId" value="'+detailId+'" />';
		html+='<div class="col-sm-3" style="border-right: 2px solid #bdbdbd;padding:0px;text-align: center;">';
		html+='<div class="col-sm-12" style="padding:0px;height: 35px;line-height: 35px;" >';
		html+='类型';
		html+='</div>';
		html+='<div  class="col-sm-12" style="height: 35px;">';
		html+='<div class="cell" >';
		html+='<input type="text" value="" name="classfiyName"   class="form-control"  style="width:90%;height: 30px;" />';
		html+='</div>';
		html+='</div>';
		html+='<button type="button" onclick="selectClassfiy(this)" style="width:60%;margin-top:10px;">选择</button>';
		html+='</div>';
		html+='<div class="col-sm-3" style="border-right: 2px solid #bdbdbd;padding:0px;text-align: center;">';
		html+='<div class="col-sm-12" style="padding:0px;height: 35px;line-height: 35px;" >';
		html+='品牌';
		html+='</div>';
		html+='<div  class="col-sm-12" style="height: 35px;">';
		html+='<div class="cell" >';
		html+='<input type="text" value=""  name="brandName"  class="form-control"  style="width:90%;height: 30px;" />';
		html+='</div>';
		html+='</div>';
		html+='<button type="button" onclick="selectBrand(this)" style="width:60%;margin-top:10px;">选择</button>';
		html+='</div>';
		html+='<div class="col-sm-3" style="border-right: 2px solid #bdbdbd;padding:0px;text-align: center;">';
		html+='<div class="col-sm-12" style="padding:0px;height: 35px;line-height: 35px;" >';
		html+='型号';
		html+='</div>';
		html+='<div  class="col-sm-12" style="height: 35px;">';
		html+='<div class="cell" >';
		html+='<input type="text" value=""  name="modelName"   class="form-control"  style="width:90%;height: 30px;" />';
		html+='</div>';
		html+='</div>';
		html+='<button type="button" onclick="selectModel(this)" style="width:60%;margin-top:10px;">选择</button>';
		html+='</div>';
		html+='<div class="col-sm-3" style="padding:0px;text-align: center;">';
		html+='<div class="col-sm-2" style="padding:0px;height: 35px;line-height: 35px;" >';
		html+='价格：';
		html+='</div>';
		html+='<div  class="col-sm-10" style="height: 35px;">';
		html+='<div class="cell" >';
		html+='<input type="text" value=""   class="form-control" name="annoPrice"  style="width:90%;height: 30px;" />';
		html+='</div>';
		html+='</div>';
		html+='</div>';
		html+='</td>';
		html+='</tr>';
	$(e).parent().parent().after(html);
	$(e).remove();
}

function removeRow(detailId,e){
	$(e).parent().parent().prev().find("td:eq(0)").html('<button type="button" onclick="addRow('+detailId+',this)">添加</button>');
	$(e).parent().parent().remove();
}

$("#submitAnno").click(function(){
	var annoList = geAnnoJson();

	alert(JSON.stringify(annoList));
// 	return false;
    $.ajax({    	
        type:'POST',
        data:JSON.stringify(annoList),
        contentType :'application/json',
        dataType:'json',
//         traditional: true,
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

//组织商品注释返回Json对象
function geAnnoJson() {

	// 商品注释总信息json实体
	var annotationsVo = {};
	var annotationList=[];
	var quotationCode = $("#headDivId").find("#headTab").find("input[name='quotationCode']").val();

	$(".annotationDetail").each(function(){
		var obj = {};
		obj['detailId']=$(this).find("[name='detailId']").val();
		var brandNameInput=$(this).find("input[name='brandName']").val();
		var brandNameSelect=$(this).find("select[name='brandName'] option:selected").text();
		var annoTypeInput=  $(this).find("input[name='modelName']").val();
		var annoTypeSelect= $(this).find("select[name='modelName'] option:selected").text();
		var classfiyNameInput= $(this).find("input[name='classfiyName']").val();
		var classfiyNameSelect= $(this).find("select[name='classfiyName'] option:selected").text();
		if(typeof(classfiyNameInput)!="undefined" ){
			obj['classfiyName']=classfiyNameInput;
		}else if(typeof(classfiyNameSelect)!="undefined"){
			obj['classfiyName']=classfiyNameSelect;
		}else{
			obj['classfiyName']='';
		}
		
		if(typeof(brandNameInput)!="undefined" ){
			obj['annoName']=brandNameInput;
		}else if(typeof(brandNameSelect)!="undefined"){
			obj['annoName']=brandNameSelect;
		}else{
			obj['annoName']='';
		}
		
		if(typeof(annoTypeInput)!="undefined" ){
			obj['annoType']=annoTypeInput;
		}else if(typeof(annoTypeSelect)!="undefined"){
			obj['annoType']=annoTypeSelect;
		}else{
			obj['annoType']='';
		}
		
		obj['annoPrice']=$(this).find("[name='annoPrice']").val();
		obj['isMaster']=0;
		annotationList.push(obj);
	}); 
	annotationsVo['annotations']=annotationList;
	annotationsVo['quotationCode']=quotationCode;

	return annotationsVo;
}


// var fieldChsNameList = ['uid','序号','产品名称','产品描述','单位','数量','单价(人民币)','金额(人民币)'];
// var fieldEngNameList = ['uid','orderNo','productName','productDesc', 'unin', 'amount', 'unitPrice', 'totalAmt'];
// var subfieldChsNameList = ['&nbsp;&nbsp;&nbsp;品牌：&nbsp;&nbsp;&nbsp;', '&nbsp;&nbsp;&nbsp;&nbsp;型号：&nbsp;&nbsp;&nbsp;', '&nbsp;&nbsp;&nbsp;&nbsp;价格：&nbsp;&nbsp;&nbsp;', '&nbsp;&nbsp;&nbsp;&nbsp;备注：&nbsp;&nbsp;&nbsp;'];
// var subfieldEngNameList = ['annoName','annoType','annoPrice', 'remark'];
// var ipt;
 

// var subLen = 0;
// var idxPos = 0;
// <c:forEach items="${detailListRlt}" var="detailListRlt" varStatus="status" >
//     var detail = {};
//     var detailList = [];
//     detail.uid = '${detailListRlt.uid}';
//     detail.orderNo = '${detailListRlt.orderNo}';
//     detail.productName = '${detailListRlt.productName}';
//     detail.productDesc = '${detailListRlt.productDesc}';    
//     detail.unin = '${detailListRlt.unin}';
//     detail.amount = '${detailListRlt.amount}';
//     detail.unitPrice = '${detailListRlt.unitPrice}';
//     detail.totalAmt = '${detailListRlt.totalAmt}';
//     detailList.push(detail.uid);
//     detailList.push(detail.orderNo);
//     detailList.push(detail.productName);
//     detailList.push(detail.productDesc);
//     detailList.push(detail.unin);
//     detailList.push(detail.amount);
//     detailList.push(detail.unitPrice);
//     detailList.push(detail.totalAmt);
// 	addRow(null, "mainTab", false, fieldChsNameList, fieldEngNameList, detailList, subfieldChsNameList, subfieldEngNameList, null);

//     idxPos = idxPos + subLen+ 1;
//     var objBind = $("#mainTab").find("tr:eq(" + idxPos + ")").find("td:eq(0)").find("input")[0];    

//     subLen = 0;
//     <c:forEach items="${detailListRlt.annotation}" var="annotation" varStatus="s" >
// 	    var annotation = '${annotationt}';
// 	    var annotationList = [];

// 	    annotationList.is_master  = '${s.index}';
// 	    annotationList.annoName = '${annotation.annoName}';
// 	    annotationList.annoType = '${annotation.annoType}';
// 	    annotationList.annoPrice = '${annotation.annoPrice}';
// 	    annotationList.remark = '${annotation.remark}';

// 		// 构造子列表
// 		subLen++;
// 	    addRow(objBind, "mainTab", true, fieldChsNameList, fieldEngNameList, detailList, subfieldChsNameList, subfieldEngNameList, annotationList);
// 	</c:forEach>
// </c:forEach>

</script>


</body>
</html>
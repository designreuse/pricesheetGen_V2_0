<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>报价单管理系统 | 报价单添加</title>

<style> 
.div-td table td{ background:#CCC; color:#000; line-height:40px} 
.tr-left {margin:0 auto;border:1px solid;text-align:left;}
</style>

<script src="${assets}/jquery/jquery-1.4.2.min.js"></script>
<script src="${assets}/jquery/json2.js"></script>
<script charset="UTF-8" src="${assets}/datepicker/setday.js"></script>
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


//创建表格  
function createTable(upLayerId, index, fieldChsNameList, fieldEngNameList, subfieldChsNameList, subfieldEngNameList)
{  
    var upLayerObj = document.getElementById(upLayerId); 
    var table = document.createElement("table");
    table.id = upLayerId + "_Tbl_" + index;
    table.className = "ListTable";
    table.width="80%";
    table.border = 1;
    var tbody = document.createElement("tbody");   
            
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
    for (var i = 0; i <= subfieldLen; i++) {

        var td0Cur = document.createElement("td");
        var td1Cur = document.createElement("td");

        if (0 == i) {
        	td0Cur.width="5%";
            td0Cur.innerHTML = "<a href='#' id=" + subTblRowId +" >添加</a>";
            td1Cur.innerHTML = "<input type='hidden' name='_hidden' /><a href='#' onclick='deleteRow(\"" + table.id + "\", this, " + index + ", false)'>删除</a>";
        } else if (subfieldLen == i) {
            td0Cur.innerHTML = "<td>" + subfieldChsNameList[i-1] + "</td>";
            td1Cur.innerHTML = "<input type=text style=\"width:100%\" readonly=\"readonly\" name=" + subfieldEngNameList[i-1] + " ></input>";
        } else {
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
    var aDivAddOut= document.createElement("div");     
    aDivAddOut.style="float:left;width:70%;"; //border:1px solid #F00       
    
    var aDivAdd= document.createElement("div");
    aDivAdd.id = "sub_grpAmount_" + index;
    aDivAdd.innerText = "0.0";        
    aDivAdd.style.width= "10%";
    //aDivAdd.style.backgroundColor='#ff0000';
    aDivAdd.style.float= "right";

    aDivAddOut.appendChild(aDivAdd);    
    aDiv.appendChild(aDivAddOut);
}


 var selectRow=null;   
 //单击时,改变样式;  
 function onClickChangeStyle(obj){
   //获取表格对象;  
   var tab = document.getElementById("tab");  
     
   //获取当前行选择下标;
   var currentRowIndex = obj.rowIndex;  

   //获取表格所有行数;  
   var tablRows = tab.rows.length;  
    
   //获取表格第一行,第一列的值;  
   //var firstCellValue = tab.rows[0].cells[0].innerHTML;  
     
   //获取表格的第一行，第一列的第一个元素的值;  
   //var firstChildValue = tab.rows[0].cells[0].firstChild.value;  
     
    //循环表格的所有行;并且选择的当前行，改变背景颜色；  
    for(var i = 1;i<tablRows;ii=i+1){  
      if(currentRowIndex == i){  
          //为选中的当前，设置css样式;  
          selectRow  = tab.rows[i];  
          tab.rows[i].className= "onClickStyle";  
      }else{  
          //把没有选中的行的背景样式设置为白色;  
          tab.rows[i].className= "hideStyle";  
      }  
    }      
 }  

//鼠标移入时，改变颜色;  
function onmouseOverMethod(selectThis){  
  selectThis.className="displayStyle";  
  if(selectRow==selectThis){  
      selectThis.className="onClickStyle";  
  }  
}  

//鼠标移除时，改变背景颜色;  
function onmouseOutMethod(selectThis){  
   selectThis.className="hideStyle";  
   if(selectRow == selectThis){  
       selectThis.className="onClickStyle";  
   }  
}


//添加行;  
function addRow(tableId, createSubTbl, fieldChsNameList, fieldEngNameList, subfieldChsNameList, subfieldEngNameList){

  var tab = document.getElementById(tableId);
  var rowIndex = tab.rows.length;  

  //添加一行;  
  var tr  = tab.insertRow(rowIndex);  
  tr.onmouseover = tr.className="displayStyle" ;  
  tr.onmouseout = tr.className="hideStyle" ;  
  //tr.onclick=function (){this.className="onClickChangeStyle(this)";}  

  var curTypeTbl = createSubTbl ? fieldEngNameList:subfieldEngNameList;
  var curTypeTblLen =curTypeTbl.length;
  for (var i = 0; i <= curTypeTblLen; i++) {
      var tdCur = tr.insertCell(i);
      if (0 == i) {
            tdCur.innerHTML = "<input type='hidden' name='_hidden' /><a href='#' onclick='deleteRow(\"tab\", this," + rowIndex + "," + createSubTbl + ")'>删除</a>";             
      } else  if (i == curTypeTblLen) {
            tdCur.innerHTML = "<input type=text style=\"width:100%\" name=\"" + curTypeTbl[i-1] + "\" readonly=\"readonly\" />";
      } else {
      	  tdCur.innerHTML = "<input type=text style=\"width:100%\" name=\"" + curTypeTbl[i-1] + "\" />";
      }
  }
     
  if (createSubTbl) {
      createTable('subDivId', rowIndex, fieldChsNameList, fieldEngNameList, subfieldChsNameList, subfieldEngNameList);
  } 

  // 初始化行; 
  initRows(tab);

 // 服务组名称变更, 联动服务明细列表表头名称变更
 $("input[name='productType']").unbind("blur").bind("blur", function(){
     var hiddenInput =  $(this).parent().prev().find("input")[0].value;
     if (this.value.length > 0) {
         $("#subDivId_Div_"+hiddenInput).find("table").find("tbody").find("tr:eq(0) td:eq(0)").text(this.value);
     }
     currencyChange();
 });
	  
	   	  
	// 绑定-子组别金额变更-一条记录金额的变更
    $("input[name=amount], input[name=unitprice]").unbind("blur").bind("blur", function(){
        var curSubTbl =  $(this).parent().parent().parent();
        var trSet = $(curSubTbl).find("tr");
        var curGrpAmount = 0;
        $.each(trSet, function (idx, tr){
            var amount = $(tr).find("input[name=amount]");
            var unitprice = $(tr).find("input[name=unitprice]");
    	    if (typeof(amount.val()) =="undefined"  || typeof(unitprice.val()) == "undefined") {
    	    	    return;
    	   	}
    	   	var _amount = 0;
    	   	var _unitprice = 0;
    	    var _resultOfAmount = 0;
    	   	if (isNaN(amount.val())) { 
    	   		$(amount).val("");
    	   	} else {
    	   		 _amount = $(amount).val();
    	    }
    	   	if (isNaN(unitprice.val())) {
    	   		$(unitprice).val("");
    	   	} else { 
    	   		_unitprice = $(unitprice).val();
    	   	}
    	   	_resultOfAmount = _amount * _unitprice;
    	   	curGrpAmount = curGrpAmount + _resultOfAmount;
    	   	$(tr).find("input[name=totalAmt]").val(_resultOfAmount.toFixed(4));
        });
        
        var curSubDivId =  $(this).parent().parent().parent().parent().attr("id");
        var curSubidx = curSubDivId.match(/\d+$/)[0];
        var curSubGrpAmountDiv = "#sub_grpAmount_" + curSubidx;
        $(curSubGrpAmountDiv).html(curGrpAmount.toFixed(4));
        $("#mainDivId").find("table").find("tr:eq("+curSubidx+")").find("input[name=grpAmount]").val(curGrpAmount.toFixed(4));
						         
        // 设置主组总金额
        var mainTblTr =  $("#mainDivId").find("table").find("tr");
        var withTaxAmt = 0;
        $.each(mainTblTr, function (idx, tr){
        	var _grpAmount = 0;
            var grpAmount = $(tr).find("input[name=grpAmount]");
    	    if (typeof(grpAmount.val()) =="undefined") {
    	    	return;
    	    }

            if (isNaN($(grpAmount).val())) {
            	$(grpAmount).val(0);
            } else {
                _grpAmount = parseFloat($(grpAmount).val());
            }

            withTaxAmt = withTaxAmt + _grpAmount;
        });
        $("#mainDivId").find("#area_sumAmount").find("#withTaxAmt").html(withTaxAmt.toFixed(4));
        $("#mainDivId").find("#area_sumAmount").find("#dealAmt").html(withTaxAmt.toFixed(4));
    });
}  

//初始化行,设置序列号;  
function initRows(tableId){  
   var tabRows = tableId.rows.length;  
   for(var i = 0;i<tabRows;i++){
       var h = tableId.rows[i].cells[0].firstChild;
   	   if (h && typeof(h.value) != "undefined") {h.value=i;}
   }  
}  

//删除行;(obj代表连接对象)  
function deleteRow(tableId, obj, index, deleteSubTbl){
    var tab = document.getElementById(tableId);  
    //获取tr对象;  
    var tr = obj.parentNode.parentNode;  
  
    if(tab.rows.length>1){  
        //tr.parentNode，指的是，table对象;移除子节点;  
        tr.parentNode.removeChild(tr);  
    }  
    //重新生成行号;  
    initRows(document.getElementById(tableId)); 
    
    var subDiv = document.getElementById("subDivId_Div_" + index);
    var subTbl = document.getElementById("subDivId_Tbl_" + index);
    if (deleteSubTbl && null != subTbl) {
        subTbl.parentNode.removeChild(subTbl);
    }
    if (deleteSubTbl && null != subDiv) {
        subDiv.parentNode.removeChild(subDiv);
    }
}

</script>
</head>


<body>                
<form name="myForm">
            <div id="headDivId">
	            <table id="headTab" name="headTab" width="80%" border="1px" style="text-align:center;">  
	                <tr>
	                    <td>至：</td><td><input type=text id="custname" name="custname" /></td><td>报价日期</td>
	                    <td>
	                    	<input type=text  id="quotationDate" name="quotationDate" onclick="setday(this)" /></td>
	                </tr>
	                <tr>
	                    <td>客户公司：</td><td><input type=text name="company" /></td><td>报价单号</td><td><input type=text name="quotationCode" /></td>
	                </tr>
	                <tr>
	                    <td>联系电话：</td><td><input type=text name="companyphone" /></td>
	                    <td>结算币种</td><td>	                    
	                    <select id="settlementType" name="settlementType" style="width:160px;">
					        <option value="01">人民币</option>
					        <option value="02">美元</option>
					        <option value="03">欧元</option>
					        <option value="04">英镑</option>
					        <option value="05">日元</option>
					    </select>	                    
	                    </td>
	                </tr>                 
	                <td>联系传真：</td><td><input type=text name="companyfax" /></td><td>付款方式</td><td><input type=text name="payType" /></td>
	                </tr>
	                <tr>
	                    <td>报价关于：</td><td><input type=text name="quotationAbout" /></td><td>销售人员</td><td><input type=text name="staffcode" /></td>
	                </tr>
	            </table>
            </div>      
            <div id='mainDivId'>
	            <table width="80%" id="tab" name="tab" border="1px" style="text-align:center;">  
	                <tr style="background-color:0099FF;color:black;"><td>
	                    <a id=mainAdd href="#" onclick=
	                        "addRow('tab', true, 
	                        ['服务组', '计价币种', '组总金额'],
	                        ['productType','currency','grpAmount'],
	                        ['序号','产品名称','产品描述','单位','数量','单价(人民币)','金额(人民币)'],
	                        ['orderNo','productName','productDesc', 'unin', 'amount', 'unitprice', 'totalAmt'])">添加
	                    </a></td><td colspan="3">项目总价（大写）：</td></tr>
	            </table>
	            <div id='area_sumAmount' style="width:100%;" >
				    <table width="80%" border="1px" style="text-align:center;">  
						<tr ><td width="50%"></td><td>含税总价：</td><td colspan="3"> <div id="withTaxAmt" ></div></td></tr>
						<tr ><td></td><td> 优惠：</td><td colspan="3"><input type="text" id="privilegeAmt" name="privilegeAmt" value="0" style="text-align: right;" /></td></tr>
						<tr ><td></td><td>最终价格：</td><td colspan="3"> <div id="dealAmt"></div></td></tr>
					</table>
	            </div>
            </div>
            <p><p>
             <div id='subDivId'>

            	</div>

        <div id="tailDivId">
            <table width="80%" id="tailTab" border="1px" style="text-align:center;">
            	<tr class="tr-left"><td width="5%">备注</td><td></td></tr>
            	<tr class="tr-left"><td ></td><td>1.报价均已含税（产品开具17%增值税发票，服务开具6%增值税发票）</td></tr>
            	<tr class="tr-left"><td></td><td>2.报价有效期5个工作日</td></tr>
            	<tr class="tr-left"><td></td><td><div id="arrivalDays">3.到货时间：报价单签字确认回传合同签订后
            		<input type=text  name="arrivalDays" value="5" align="center" />个工作日</div></td></tr>
            	<tr class="tr-left"><td></td><td>4付款期限：</td></tr>
                <tr class="tr-left"><td></td><td><input type="radio" name="deliveryMode" id="radio" value="online">付款后发货<br></td></tr>
                <tr class="tr-left"><td></td><td><input type="radio" name="deliveryMode" id="radio" value="afterReceive" checked="checked" />货到付款<br></td></tr>
                <tr class="tr-left"><td></td><td><input type="radio" name="deliveryMode" id="radio" value="transfer"  />转账<br></td></tr>                
             </table>                       
        </div>

        <div id="submitId" align="center">
            <input type=button value="提交核价" id="submitPriceSheet" />
            <input type=button value="提交核价" id="submitPriceSheetDirect" />
        </div>
    </form>

     
<script type="text/javascript">
// 绑定币种选择
 $("#settlementType").change(function() { currencyChange();});
function currencyChange() {
	//获取下拉框选中项的text属性值
	var selectText = $("#settlementType").find("option:selected").text();
	var selectValue = $("#settlementType").val();
	$("#mainDivId").find("input[name=currency]").val(selectText);

}    
     
// 绑定服务组优惠金额事件
$("input[name=privilegeAmt]").bind("blur", function(){
	var withTaxAmt = $("#mainDivId").find("#area_sumAmount").find("#withTaxAmt").text();
	var _withTaxAmt = 0;

	if (0 == withTaxAmt.length || isNaN(withTaxAmt)) { 
		    alert("请先录入商品！");
		    $(this).val(0);
		    return;
	} else {
		_withTaxAmt = parseFloat(withTaxAmt); 
	}

    var _discountAmount = 0
    if (isNaN($(this).val())) { 
	   		$(this).val(0);
	   	} else {
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
	
    $("#mainDivId").find("#area_sumAmount").find("#dealAmt").html(_dealAmt.toFixed(4));
});

//直接提交
$("#submitPriceSheetDirect").click(function(){
    // 报价单总信息json实体
    var objJsonEntity={};
    var fieldsHead = $("#headTab").find("input:visible");
    var fieldsettlementType = $("select[name='settlementType']").find("option:selected");
    objJsonEntity.settlementType = $(fieldsettlementType).val();	
    
    makeIptArr(objJsonEntity, fieldsHead, null );                              

    // 报价单明细信息
    var objBodyList= null;
	  var fieldsTrObj = $("#mainDivId").find("#tab").find("tr");
	  $.each(fieldsTrObj, function (index, domEle){

	     var fieldsInput = $(domEle).find("input:visible");							     
	     if (0 >= fieldsInput.length) {
	         return;
	     }                                

       var svcGrp = fieldsInput[0];
       if(null == objBodyList) {
	         objBodyList = new Array();
	     }

   	var subfieldsTrObj = $("#subDivId_Div_" + index).find("#subDivId_Tbl_"+index).find("tr");							     	
   	$.each(subfieldsTrObj, function (subindex, subdomEle){
   	    var objBodySub = {};
           var subfieldsInput = $(subdomEle).find("input:visible");	
           if (0 >= subfieldsInput.length) {
           	return;
           }

           makeIptArr(objBodySub, subfieldsInput, svcGrp);
           objBodyList.push(objBodySub);						             
      });						        
	});

	objJsonEntity["body"] = objBodyList;
	objJsonEntity["privilegeAmt"] = $("#privilegeAmt").val();
  
	// 报价单尾部信息
	objJsonEntity["deliveryMode"] = $("input[name=\"deliveryMode\"]:checked").val();
	objJsonEntity["arrivalDays"] = $("input[name=\"arrivalDays\"]").val();
	alert(JSON.stringify(objJsonEntity));
  
    
    $.ajax({
        type:'POST',
        data:JSON.stringify(objJsonEntity),
        contentType :'application/json',
        dataType:'json',
        URL :'${ctx}/institution/add',
        headers:{ 
            Accept:'application/json', 'Content-Type': 'application/json'
        },
        success :function(data) {
            alert("OK");
        },
        error :function(e) {
            alert("error");
        }
    });
});

// 提交
$("#submitPriceSheet").click(function(){
    alert("2");
});
</script>
</body>
</html>

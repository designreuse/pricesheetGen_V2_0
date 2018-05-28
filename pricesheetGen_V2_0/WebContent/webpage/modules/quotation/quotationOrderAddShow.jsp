<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" isErrorPage="true" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<html>
    <head>
        <title>报价单录入</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="${ctxStatic}/bootstrap/3.3.4/css_default/bootstrap.min.css" type="text/css" rel="stylesheet" />
		<script src="${ctxStatic}/bootstrap/3.3.4/js/bootstrap.min.js"  type="text/javascript"></script>
		<script src="${ctxStatic}/json/json2.js" type="text/javascript"></script>
		<script src="${ctxStatic}/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
		<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		
		<style type="text/css">
			div{
				 font-family: 'Microsoft YaHei' ! important;
				 color:block  ! important;
			}
		</style>
 
<script type="text/javascript">
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
    var quotationAbout = $.trim($("[name='quotationAbout']").val());
    if ("" == quotationAbout) 
    {
        alert("报价关于不能为空！！！");
        return false;
    }
    
    // 如果报价单号已经生成，用户继续点击则进行提示
    var quotationCode = $("#headDivId").find("input[name=quotationCode]").val();
    if (0 < quotationCode.length) 
    {
    	return confirm("【继续生成报价单】\n当前报价单已经生成成功，继续操作会生成新的报价单号。");
    }

    return true;
}

function currencyChange() 
{ //获取下拉框选中项的text属性值
    
    var selectText = $("#settlementType").find("option:selected").text();
    var selectValue = $("#settlementType").val();
    $("#mainDivId").find("input[name=currency]").val(selectText);
}


function initSeq() { // 初始化商品序号

	var mainTblTr = $("#mainDivId").find("#tab").find("tr");
	$.each(mainTblTr, function (mainidx, maintr) {

		var mainHidden = $(maintr).find("input[type=hidden]");
		if (0 == mainHidden.length) { // 非数据行
			return;
    	}

        var mainHiddenIdx = mainHidden.val();
        var subDivIdTag = "subDivId_Div_" + mainHiddenIdx;
    	var subTblTr = $("#subDivId").find("#"+subDivIdTag).find("table").find("tr");
    	var seqSubIdx = 0;
    	$.each(subTblTr, function (subidx, subtr) {

	    	var subHidden = $(subtr).find("input[type=hidden]");
	    	if (0 == subHidden.length) { // 非数据行
	    		return;
	    	}

            seqSubIdx++;
	    	var seqSet = mainidx + "." + seqSubIdx;
	    	$(subtr).find("td:eq(1)").find("input").val(seqSet);	    	    
    	});
    });
}

// 组织报价单返回Json对象
function getPriceSheetJson() 
{

    // 报价单总信息json实体
    var quotationOrder={};
    var fieldsHead = $("#headTab").find("input:visible");

    // 报价单头部转Json 
    addObjSet2Json(quotationOrder, fieldsHead, null);

    // 结算货币 
    var fieldsettlementType = $("select[name='settlementType']").find("option:selected");
    quotationOrder.settlementType = $(fieldsettlementType).val();
    // 付款方式
    quotationOrder.payType = $("select[name='payType']").find("option:selected").val();
    // 销售人员
    quotationOrder.staffId = $("select[name='staffId']").find("option:selected").val();
    // 报价单号上送始终为空
    quotationOrder.quotationCode = "";
    

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


    quotationOrder["quotationOrderDetails"] = objBodyList;
    quotationOrder["withTaxAmt"] = $("#withTaxAmt").text();    
    quotationOrder["privilegeAmt"] = $("#privilegeAmt").val();
    quotationOrder["dealAmt"] = $("#dealAmt").text();
  
    // 报价单尾部信息
    quotationOrder["arrivalDays"] = $("input[name=\"arrivalDays\"]").val();
    var _deliveryMode = $("input[name='deliveryMode']:checked").val();
    quotationOrder["deliveryMode"] = _deliveryMode;
    if ("001" == _deliveryMode) {
        quotationOrder["otherAdd"] = "";
    } else if ("002" == _deliveryMode) {
        quotationOrder["otherAdd"] = $("#waitDays").val();            
    } else if ("003" == _deliveryMode) {
        quotationOrder["otherAdd"] = $("#otherChoice").val();
    }
    
    return quotationOrder;
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
    table.width="100%";
    table.border="1";
    table.spellcheck="false";
    table.contenteditable="true";

    var trtlt = document.createElement("tr");    
     var tdtlt = document.createElement("td");
     trtlt.bgColor = "#008080";
     tdtlt.style.fontWeight="bold";
     tdtlt.style.paddingLeft="40px";
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
            td0Cur.width="10%";
            td0Cur.innerHTML = "<a href='javascript:void(0)' id=" + subTblRowId +" style=\"color:black\" >添加</a>";
            td1Cur.innerHTML = "<input type='hidden' name='_hidden' /><a href='#' onclick='deleteRow(\"" 
                    + table.id + "\", this, " + index + ", false)'>删除</a>";
        } else if (1 == i || subfieldLen == i)
        {
            td0Cur.innerHTML = "<td style=\"border:1px solid black;\">" + subfieldChsNameList[i-1] + "</td>";
            td1Cur.innerHTML = "<input type=text style=\"width:100%;border:0px;\" readonly=\"readonly\" name=" 
                + subfieldEngNameList[i-1] + " ></input>";
        } else 
        {
            td0Cur.innerHTML = "<td>" + subfieldChsNameList[i-1] + "</td>";
            td1Cur.innerHTML = "<input type=text style=\"width:100%;border:0px;\" name=" + subfieldEngNameList[i-1] + " ></input>";              
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
    aDivAddLeft.style.width= "80%";
    aDivAddLeft.innerHTML = "<br>";
    aDivAddLeft.style.float= "left";

    var aDivAddMid= document.createElement("div");
  
    aDivAddMid.style.width= "5%";
    aDivAddMid.innerHTML = "小计";
    aDivAddMid.style.float= "left";

    var aDivAddRight= document.createElement("div");
    aDivAddRight.id = "sub_grpAmount_" + index;
    aDivAddRight.innerText = "0.0";        
    aDivAddRight.style.width = "10%";
    //aDivAddRight.style.backgroundColor='#ff0000';
    aDivAddRight.style.float= "left";

    var aDivWrapper= document.createElement("div");
    aDivWrapper.style.border="1px solid black";
    aDivWrapper.style.borderTop="0px";
    aDivWrapper.style.height="25px";
    /* aDivWrapper.style.display ="inline"; */
    aDivWrapper.appendChild(aDivAddLeft);
    aDivWrapper.appendChild(aDivAddMid);
    aDivWrapper.appendChild(aDivAddRight);
    aDiv.appendChild(aDivWrapper);    
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
            tdCur.innerHTML = "<input type='hidden' style=\"border:0px;\" name='_hidden' /><a href='#' style=\"border:0px;\" onclick='deleteRow(\"tab\", this," 
                    + rowIndex + "," + createSubTbl + ")'>删除</a>";         
        } else  if (i == curTypeTblLen || !createSubTbl && 1 == i)        	
        {
            tdCur.innerHTML = "<input type=text style=\"width:100%;border:0px;\" name=\"" + curTypeTbl[i-1] + "\" readonly=\"readonly\" />";
        } else 
        {
        	if(i==1){
        		  tdCur.innerHTML = "<input type=text style=\"width:100%;border:0px;\" value=\""+NumberToChinese(lastrowIndex)+"：\" name=\"" + curTypeTbl[i-1] + "\" />";
        	}else{
        		  tdCur.innerHTML = "<input type=text style=\"width:100%;border:0px;\" name=\"" + curTypeTbl[i-1] + "\" readonly=\"readonly\" />";
        	}
        }
    }
     

    lastrowIndex = initRows(tab); // 初始化行;

    if (createSubTbl) 
    {
        createTable('subDivId', lastrowIndex, fieldChsNameList, fieldEngNameList, subfieldChsNameList, subfieldEngNameList);
    }

    initSeq();  // 初始化商品序号


    $("input[name='productType']").unbind("blur").bind("blur", function() { // 服务组名称变更, 联动服务明细列表表头名称变更
        
        var hiddenInput =  $(this).parent().prev().find("input")[0].value;
        
        if (this.value.length > 0) {
            $("#subDivId_Div_"+hiddenInput).find("table").find("tbody").
            find("tr:eq(0) td:eq(0)").text(this.value);
        }
        
        currencyChange();
    });
      

    $("input[name=amount], input[name=unitPrice]").unbind("blur").bind("blur", function()
    { // 绑定-子组别金额变更-一条记录金额的变更
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
                $(amount).val("0");
            } else 
            {
                _amount = $(amount).val();
            }
            if (isNaN(unitPrice.val())) 
            {
                $(unitPrice).val("0.00");
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
    
    initSeq();  // 初始化商品序号
}

</script>


<body bgcolor="white" style="background-color:white ">
<div>
	<div class="col-sm-2"></div>
	<div class="col-sm-8">
		<div  class="col-sm-7" style="height:100px;line-height:100px;text-align:left;"><img src="${ctxStatic }/common/login/images/logo.png" style="width:280px"></div>
		<div  class="col-sm-5" style="height:100px;line-height:100px;text-align:center;"><img src="${ctxStatic }/common/login/images/image005.png" style="width:200px"></div>
	</div>
</div>
<div class="col-sm-12">
	<div class="col-sm-2"></div>
	<div class="col-sm-8">
		<form name="myForm">
		    <div id="headDivId" >    
		        <div><div  style="height:25px;line-height:25px; background-color:#008080;text-align: left;width:43.5%;font-weight: bold;margin-bottom:3px;">尊敬的客户，您好！兹对贵司需求报价如下：</div></div>
		        <div class="col-sm-6" style="padding-left:0px;">
		        	<div class="col-sm-12" >
		        		<div class="form-group" style="margin-bottom:5px;height:25px;">
					        <label class="col-sm-4" style="text-align: right;line-height:25px;">至：	</label>
					        <div class="col-sm-8"  style="height:25px;text-align: left;">
<!-- 					           <input type="text"  style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;text-align:center;" id="custName" name="custName" />  -->
					       		<input type="text" id="custName" name="custName" style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;text-align:center;"  placeholder="点击选择即可"/>
               					<input id="custId" name="custId" type="hidden"  />
					       		<script type="text/javascript">
									$("#custName").click(function(){
										top.layer.open({
										    type: 2, 
										    area: ['800px', '600px'],
										    title:"选择用户",
									        maxmin: true, //开启最大化最小化按钮
										    content: "${ctx}/sys/user/usertooffice?id=${role.id}" ,
										    btn: ['确定', '关闭'],
										    yes: function(index, layero){
												var selectedUser = layero.find("iframe")[0].contentWindow.selectedUser;
													if(selectedUser!=null && selectedUser.name !=null){
														$("#companyPhone").val(selectedUser.mobile);
														$("#company").val(selectedUser.companyName);
														$("#custName").val(selectedUser.name);
														$("#companyFax").val(selectedUser.companyFax);
														$("#custId").val(selectedUser.id);
													}
												    top.layer.close(index);
											  },
											  cancel: function(index){ 
								    	       }
										}); 
									});
								</script> 
					        </div>
					    </div>
						<div class="form-group"  style="margin-bottom:5px;height:25px;"> 
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">客户公司：</label>
							<div class="col-sm-8"   style="height:25px;text-align: left;">
					           <input type="text" id="company" name="company"   readonly="readonly"  style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;text-align:center;" />
					        </div>
						</div>	
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">联系电话：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
					           <input type="text" id="companyPhone" name="companyPhone"  readonly="readonly"   style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;text-align:center;" />
					        </div>
						</div>		
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">联系传真：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
					          <input type="text" id="companyFax" name="companyFax"  readonly="readonly"  style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;text-align:center;" />
					        </div>
						</div>		
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label"  style="text-align: right;line-height:25px;">报价关于：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
					           <input type=text name="quotationAbout"    style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;text-align:center;" />
					        </div>
						</div>
					</div>
		        </div>
		        <div class="col-sm-6" style="padding-left:0px;" >
		        	<div class="col-sm-12" style="text-align:right;margin-left:50px;">
		        		<div class="form-group" style="margin-bottom:5px;height:25px;">
					        <label class="col-sm-4" style="text-align: right;line-height:25px;">报价日期：</label>
					        <div class="col-sm-8"  style="height:25px;text-align: left;">
					        	<input id="quotationDateStr" name="quotationDateStr" type="text" readonly="readonly" maxlength="20" 
							class="input-medium Wdate"  style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;text-align:center;"
							pattern="yyyy-MM-dd" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
					        </div>
					    </div>
						<div class="form-group"  style="margin-bottom:5px;height:25px;"> 
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">报价单号：</label>
							<div class="col-sm-8"   style="height:25px;text-align: left;">
								<input type="text" name="quotationCode" readonly="readonly"  style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;text-align:center;"  />
					        </div>
						</div>	
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">结算币种：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
								 <select id="settlementType" name="settlementType"  style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;">
					                   <option value="RMB">人民币</option>
					                   <option value="USD">美元</option>
					                   <option value="EUR">欧元</option>
					                   <option value="GBP">英镑</option>
					                   <option value="JPY">日元</option>
					             </select> 
					        </div>
						</div>		
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label" style="text-align: right;line-height:25px;">付款方式：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
								<select id="payType" name="payType" style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;" >
				                       <option value="001">现金</option>
				                       <option value="002">支票</option>
				                       <option value="003">转账</option>
				                 </select>
					        </div>
						</div>		
						<div class="form-group"  style="margin-bottom:5px;height:25px;">
							<label class="col-sm-4 control-label"  style="text-align: right;line-height:25px;">销售人员：</label>
							<div class="col-sm-8"  style="height:25px;text-align: left;">
								<select id="staffId" name="staffId" style="border: 0px;border-bottom: 1px solid;width: 95%;height:100%;color:black;">
					                <c:forEach items="${fns:findUserRuleCodeOrId('02','')}" var="dict">
										<option value="${dict.id}" >${dict.name}</option>
									</c:forEach>
			                    </select>
					        </div>
						</div>
					</div>
		        </div>
		    </div>
		  
		    <div id='mainDivId' >
		        <table width="100%" > 
		        	<tr height="30px; "><th></th></tr>
		            <tr style="background-color:#008080;color:black;">
		                <th style="text-align:left;width:100%;">项目总价</th>
		            </tr>
		        </table>
		        <table width="100%" id="tab" style="text-align:center;" border="1"	>
		            <tr ><td width="10%">
		                <a id=mainAdd href="javascript:void(0)" onclick=
		                     "addRow('tab', true, 
		                     ['项目名称', '计价币种', '税后总额'],
		                     ['productType','currency','grpAmount'],
		                     ['序号','产品名称','产品描述','单位','数量','单价(人民币)','金额(人民币)'],
		                     ['orderNo','productName','productDesc', 'unin', 'amount', 'unitPrice', 'totalAmt'])" style="color:black">添加
		                 </a></td>
		                 <td>项目名称</td>
		                 <td style="text-align:left;width:10%;">计价币种</td>
		                 <td style="text-align:left;width:25%;">税后总额</td>
		             </tr>
		        </table>
		        <div id='area_sumAmount' style="width:100%;" >
		            <table width="100%"   style="text-align:center;">  
		                <tr >
		                    <td style="text-align:right;width:75%;border-left:1px solid black;height:30px;" >项目总价(RMB):</td>
							<td style="text-align:right;border-right:1px solid black;"> <div id="withTaxAmt" ></div></td>
		                </tr>  
						<tr >						
						   <td style="text-align:right;border-left:1px solid black;">优惠(RMB):</td>
						   <td style="text-align:left;border-right:1px solid black;">
		                   	 	<input type="text" id="privilegeAmt" name="privilegeAmt" value="0" style="text-align: right;border:0px;width:100%" />
		                    </td>
						</tr>   
						<tr >		                
							<td style="text-align:right;border:1px solid black;border-top: 0px;border-right: 0px;">最终价格(RMB):</td>
		                    <td style="text-align:right;border:1px solid black;border-top: 0px;border-left: 0px;"><div id="dealAmt"></div></td>
		                </tr>
		            </table>
		            <div style="display:inline">
		                <div style="width:65%;border:1px solid #FFF;float:left"></div>
		                <div style="width:15%;border:1px solid #FFF;float:left" id="finalAmt">0.0000</div>
		            </div>
		        </div>
		    </div> 
		    <div id='subDivId'></div>
		    
		    <div>
		    	<div class="col-sm-7" style="margin-top:20px;">
		    		<div style="text-align: left;font-weight: bold;">备注：</div>
		    		<div style="text-align: left;padding-left:20px;">1、报价均已含税（产品开具17%增值税发票，服务开具6%增值税发票）</div>
		    		<div style="text-align: left;padding-left:20px;">2、报价有效期：5个工作日</div>
		    		<div style="text-align: left;padding-left:20px;" id="arrivalDays">3、到货时间：报价单签字确认回传合同签订后 <input type=text  name="arrivalDays" value="5" style="width:50px;align:center;height:20px;line-height: 20px;border: 0px;border-bottom: 1px solid;"/>个工作日</div>
		    		<div style="text-align: left;padding-left:20px;">4、付款期限：</div>
		    		<div style="text-align: left;padding-left:100px;"><input type="radio" name="deliveryMode" id="radio" value="001">款到发货.  </div>
		    		<div style="text-align: left;padding-left:100px;"><input type="radio" name="deliveryMode" id="radio" value="002" checked="checked" />货到<input type="text" id="waitDays" name="waitDays" value="7" style="width:50px;height:20px;line-height: 20px;border: 0px;border-bottom: 1px solid;" /> 工作日(现金、支票、转账)付款。    </div>
		    		<div style="text-align: left;padding-left:100px;"><input type="radio" name="deliveryMode" id="radio" value="003"  />其他<input type="text" id="otherChoice" name="otherChoice" style="width:300px;height:20px;line-height: 20px;border: 0px;border-bottom: 1px solid;" />。  </div>
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
					<div style="font-weight: bold;font-size: 25px;height:80px;line-height:80px;">谢功全</div>
					<div style="height:3px;"><hr style="height:3px;border:none;border-top:3px double black;" /></div>
					<div>如有任何疑问请即时与我联系!</div>
				</div> 
			</div>
		    <div class="row" id="submitId" align="center"> 
			    <div class="col-sm-12" > 
		        <input id="submitPriceSheet" class="btn btn-action"  type="button" value="提交核价" /> 
				<input id="submitPriceSheetDirect" class="btn btn-action" type="button" value="提交报价单" />
				</div>
			</div>
		</form>
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
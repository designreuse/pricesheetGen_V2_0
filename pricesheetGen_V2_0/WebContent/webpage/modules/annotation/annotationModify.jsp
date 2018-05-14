<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>注释商品</title>
<meta name="decorator" content="default" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
</style>
<script src="${ctxStatic}/json/json2.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	function makeIptArr(parentNode, jObj, addObj) {
		var arrObj = new Array();
		var fieldObj = {};
		var fieldString = "";
		var lenObj = $(jObj).length;
		for (var i = 0; i < lenObj; i++) {
			var _name = $(jObj).eq(i).attr("name");
			var _val = $(jObj).eq(i).val();
			parentNode[_name] = _val;
		}

		// 补充的对象
		if (addObj) {
			var _name = $(addObj).attr("name");
			var _val = $(addObj).val();
			parentNode[_name] = _val;
		}
		return;
	}

	// 组织商品注释返回Json对象
	function geAnnoJson() {

		// 商品注释总信息json实体
		var quotationCode = $("#headDivId").find("#headTab").find(
				"input[name='quotationCode']").val();
		var quotationId = $("#headDivId").find("#headTab").find(
				"input[name='quotationId']").val();

		// 商品注释明细信息
		var objBody = {};
		var objBodyList = null;
		var fieldsTrObj = $("#mainDivId").find("#mainTab").find("tr");
		$.each(fieldsTrObj, function(index, domEle) {

			// 跳过第一行
			var fieldsInput = $(domEle).find("input:hidden");
			if (0 >= fieldsInput.length) {
				return;
			}

			// var idxRow = fieldsInput[0].value;
			if (null == objBodyList) {
				objBodyList = new Array();
			}

			var fieldsTd = $(domEle).find("td");
			if (1 == fieldsTd.length) {
				var aAnno = $(fieldsTd).find("div").find("li").find("input");
				makeIptArr(objBody, aAnno, null);
				objBodyList.push(objBody);
			} else {
				objBody.quotationCode = quotationCode;
				objBody.quotationId = quotationId;
				objBody.orderNo = $(fieldsTd).find("input[name='orderNo']")
						.val();
			}
		});
		return objBodyList;
	}

	//删除行;(obj代表连接对象)  
	function deleteRow(tableId, obj, index) {
		var tab = document.getElementById(tableId);
		//获取tr对象;  
		var tr = obj.parentNode.parentNode.parentNode.parentNode;

		if (tab.rows.length > 1) {
			//tr.parentNode，指的是，table对象;移除子节点;  
			tr.parentNode.removeChild(tr);
		}
		//重新生成行号;  
		initRows(document.getElementById(tableId));
	}

	/*
	 * 初始化行, 设置序列号 
	 */
	function initRows(tableId) {
		var tabRows = tableId.rows.length;
		for (var i = 0; i < tabRows; i++) {
			var h = tableId.rows[i].cells[0].firstChild;
			if (h && typeof (h.value) != "undefined") {
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
	function addRow(objBind, tableId, insertSubTbl, fieldChsNameList,
			fieldEngNameList, valueList, subfieldChsNameList,
			subfieldEngNameList, subvalueList) {
		var tabObj = document.getElementById(tableId);
		var rowIndex = tabObj.rows.length;
		var subblockId = "subDivId";
		var curTypeTbl = insertSubTbl ? subfieldEngNameList : fieldEngNameList;
		var curvalueList = insertSubTbl ? subvalueList : valueList;
		var curTypeTblLen = curTypeTbl.length;

		if (insertSubTbl) { // 创建注释

			var lastRowOfBlock = $(objBind).parent().parent();
			var lineNoOfChoosen = $(lastRowOfBlock).find("td").find("input")[0].value;
			var idxRow = rowIndex;
			var isLastLine = (rowIndex == parseInt(lineNoOfChoosen) + 1) ? true
					: false; //  最后一行, 增加到末尾

			for (; false == isLastLine && 0 != lastRowOfBlock.length;) {

				curRowOfBlock = $(lastRowOfBlock).next();
				if (0 != curRowOfBlock.length) {
					lastRowOfBlock = curRowOfBlock;
				} else {
					isLastLine = true; // 有结尾, 没开始, 称为最后行
					break;
				}
				if (0 == $(lastRowOfBlock).find("td").find("#" + subblockId).length) {
					isLastLine = false; // 有结尾, 没开始, 称为最后行
					break;
				}
			}

			if (false == isLastLine) {
				idxRow = parseInt($(lastRowOfBlock).find("td").find("input")[0].value);
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
			tdField.appendChild(hiddenIpt);

			var delLink = document.createElement("a");
			delLink.setAttribute('href', '#');
			delLink.setAttribute('line', idxRow);
			delLink.name = "delLink";
			delLink.appendChild(document.createTextNode("删除"));
			delLink.onclick = function() {
				deleteRow(tabObj.id, this, idxRow, false);
			}

			var divsubTbl = document.createElement("div");
			divsubTbl.style.float = "left";
			divsubTbl.style.width = "100%";
			divsubTbl.id = subblockId;

			var divsubLi = document.createElement("li");
			var divsubInput = null;
			var divsubLabel = null;

			divsubLi.style.listStyleType = "none";
			divsubLi.appendChild(delLink);

			for (var i = 0; i < subfieldEngNameList.length; i++) {
				divsubLabel = document.createElement("label");
				divsubLabel.innerHTML = subfieldChsNameList[i];
				divsubLabel.width = "100px";
				divsubInput = document.createElement("input");
				divsubInput.name = subfieldEngNameList[i];
				divsubInput.value = (null != subvalueList) ? subvalueList[subfieldEngNameList[i]]
						: "";

				divsubLi.appendChild(divsubLabel);
				divsubLi.appendChild(divsubInput);
			}

			divsubTbl.appendChild(divsubLi);
			tdField.appendChild(divsubTbl);

			initRows(tabObj);
		} else {
			// 创建父表
			var tr = tabObj.insertRow(rowIndex);
			// 添加各个列
			for (var i = 0; i <= curTypeTblLen; i++) {
				var tdCur = tr.insertCell(i);
				if (0 == i) {
					var hiddenIpt = document.createElement("input");
					hiddenIpt.type = 'hidden';
					hiddenIpt.name = '_hidden';
					hiddenIpt.value = rowIndex;
					var addLink = document.createElement("a");
					addLink.setAttribute('href', '#');
					addLink.setAttribute('line', rowIndex);
					addLink.appendChild(document.createTextNode("添加"));
					addLink.name = "addLink";
					tdCur.appendChild(hiddenIpt);
					tdCur.appendChild(addLink);
					addLink.onclick = function() {
						addRow(this, tabObj.id, true, fieldChsNameList,
								fieldEngNameList, valueList,
								subfieldChsNameList, subfieldEngNameList, null);
					}
				} else {
					tdCur.innerHTML = "<input type=text style=\"width:100%\" name=\""
							+ curTypeTbl[i - 1]
							+ "\" value=\""
							+ curvalueList[i - 1]
							+ "\" readonly=\"readonly\" />";
				}
			}
		}
	}
</script>

</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<form name="myForm">
			<div id="headDivId">
				<table id="headTab" width="80%" border="1px" style="text-align: center;">
					<tr>
					<td>报价单号：</td>
					<td><input type=text name="quotationCode"
						value="8323jkhddsjkhdsjksd" /></td>
					<td>报价单Id：</td>
					<td><input type=text name="quotationId" value="123" /></td>
					<td><select id="settlementType" name="settlementType"
						style="width: 160px;">
							<option value="USD">美元</option>
							<option value="CNY">人民币</option>
							<option value="EUR">欧元</option>
							<option value="POD">英镑</option>
							<option value="JPY">日元</option>
					</select></td>
					</tr>
				</table>
			</div>

			<div id='mainDivId'>
				<table id="mainTab" width="80%" border="1px" style="text-align: center;">
					<tr style="background-color: 0099FF; color: black;">
						<td>注解商品</td>
						<td>序号</td>
						<td>产品名称</td>
						<td>产品描述</td>
						<td>单位</td>
						<td>数量</td>
						<td>单价(人民币)</td>
						<td>金额(人民币)</td>
					</tr>
				</table>
			</div>
			<div id="submitId" align="center">
				<input type=button value="提交" id="submitAnno" />
			</div>
		</form>
	</div>

	<script type="text/javascript">
		$("#submitAnno").click(function() {

			var annoList = geAnnoJson();
			alert(JSON.stringify(annoList));
			$.ajax({
				type : 'POST',
				data : JSON.stringify(annoList),
				contentType : 'application/json',
				dataType : 'json',
				URL : '${ctx}/institution/modRemark',
				headers : {
					Accept : 'application/json',
					'Content-Type' : 'application/json'
				},
				success : function(data) {
					if (typeof (data) == "undefine") {
						alert("系统处理异常！！！");
						return;
					}
					if ("0" == data.state) {
						alert("产品注释保存失败:</br></br>" + data.msg);
					} else {
						alert("产品注释保存成功:</br></br>" + data.msg);
					}
				},
				error : function(e) {
					alert("产品注释保存异常！！！");
				}
			});
		});

		var fieldChsNameList = [ '序号', '产品名称', '产品描述', '单位', '数量', '单价(人民币)',
				'金额(人民币)' ];
		var fieldEngNameList = [ 'orderNo', 'productName', 'productDesc',
				'unin', 'amount', 'unitPrice', 'totalAmt' ];
		var valueList = [ '1.1', '态势电脑', '态势电脑', '台', 8, '999', 98987 ];
		var subfieldChsNameList = [ '品牌', '型号', '价格', '备注' ];
		var subfieldEngNameList = [ 'anno_name', 'anno_type', 'anno_price',
				'anno_note' ];
		var subvalueList = new Array();
		var subvalueList = [];
		var ipt;
		for (var i = 0; i < 3; i++) { // 构造主列表
			addRow(null, "mainTab", false, fieldChsNameList, fieldEngNameList,
					valueList, subfieldChsNameList, subfieldEngNameList,
					subvalueList);
		}

		var subLen = 0;
		var idxPos = 0;
		for (var i = 0; i < 3; i++) {
			// 构造 

			idxPos = idxPos + subLen + 1;
			var objBind = $("#mainTab").find("tr:eq(" + idxPos + ")").find(
					"td:eq(0)").find("input")[0];
			subLen = 2;
			for (var j = 0; j < subLen; j++) {
				subvalueList.is_master = j;
				subvalueList.anno_name = 'HP';
				subvalueList.anno_type = 'XP400-29';
				subvalueList.anno_price = 98.65;
				subvalueList.anno_note = '白术';

				// 构造子列表
				addRow(objBind, "mainTab", true, fieldChsNameList,
						fieldEngNameList, valueList, subfieldChsNameList,
						subfieldEngNameList, subvalueList);
			}
		}

	</script>
</body>
</html>
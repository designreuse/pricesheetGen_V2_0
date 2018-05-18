<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>临时商品录入</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/build.css" />
	<script type="text/javascript">
	var validateForm;
	function doSubmit(){ //回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  $("#inputForm").submit();
		  return true;

	  return false;
	} 
	</script>
</head>
<body class="hideScroll">
	<form method="post" id="inputForm" name="inputForm"  action="${ctx}/product/productImp/AddProduct">
		<input type="hidden" name="id" value="${productImp.id}" /> 
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品编号:</label></td>
		         <td  width="30%"><input type="text" readonly="readonly" value="${productImp.pId}" name="pId"  maxlength="50" class="form-control required" /></td>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品名称:</label></td>
		         <td width="30%"><input  value="${productImp.pName}" readonly="readonly"  name="pName"  maxlength="50" class="form-control required "/></td>
		      </tr>
		       <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品类型:</label></td>
		         <td  width="30%"><input type="text"  value="${productImp.classfiy}" name="classfiy"  maxlength="50" class="form-control required" /></td>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品品牌:</label></td>
		         <td width="30%"><input  value="${productImp.brand}"  name="brand"  maxlength="50" class="form-control required "/></td>
		      </tr>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品型号:</label></td>
		         <td colspan="3"><input type="text" value="${productImp.model}" name="model"  maxlength="50" class="form-control required" /></td>
		      </tr>
		 </tbody>
		 </table>
	</form>
	<script type="text/javascript">
	 $(document).ready(function() { 

	 }); 
	  
	</script>
</body>

</html>
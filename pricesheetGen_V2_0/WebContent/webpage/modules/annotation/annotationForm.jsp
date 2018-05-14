<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>查看注释</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="annotation" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		     
		      
		      <tr>
		         <td class="active"><label class="pull-right"><font color="red">*</font>品牌:</label></td>
		         <td><form:input path="annoName" htmlEscape="false" maxlength="50" class="form-control required"/></td>
		         <td class="active"><label class="pull-right"><font color="red">*</font>型号:</label></td>
		         <td><form:input path="annoType" htmlEscape="false" maxlength="50" class="form-control required "/></td>
		      </tr>
		      <tr>
		         <td class="active"><label class="pull-right">数量:</label></td>
		         <td><form:input path="amount" htmlEscape="false" maxlength="100" class="form-control"/></td>
		         <td class="active"><label class="pull-right">单价:</label></td>
		         <td><form:input path="unitPrice" htmlEscape="false" maxlength="100" class="form-control"/></td>
		      </tr>
		      <tr>
		         <td class="active"><label class="pull-right">报价单号:</label></td>
		         <td><form:input path="quotationCode" htmlEscape="false" maxlength="100" class="form-control"/></td>
		         <td class="active"><label class="pull-right">金额:</label></td>
		         <td><form:input path="totalAmt" htmlEscape="false" maxlength="100" class="form-control"/></td>
		      </tr>
		      <tr>
		         <td class="active"><label class="pull-right">报价单描述:</label></td>
		         <td><form:textarea path="remark" htmlEscape="false" rows="3" maxlength="200" class="form-control"/></td>
		         <td class="active"><label class="pull-right"></label></td>
		         <td></td>
		      </tr>
	</form:form>
</body>
</html>
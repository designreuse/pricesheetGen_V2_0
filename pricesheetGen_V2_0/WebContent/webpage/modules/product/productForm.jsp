<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>查看商品</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/build.css" />
	<script type="text/javascript">
	</script>
</head>
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="product" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品编号:</label></td>
		         <td  width="30%"><form:input path="productId" readonly="true" htmlEscape="false" maxlength="50" class="form-control required" /></td>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品名称:</label></td>
		         <td width="30%"><form:input path="productName" readonly="true"  htmlEscape="false" maxlength="50" class="form-control required "/></td>
		      </tr>
		      <tr>
		         <td class="active"><label class="pull-right">商品类别:</label></td>
		         <td colspan="3">
		         	<div style="height:30px; overflow:auto;">
 	      			   	<c:forEach items="${classfiyList}" var="classfiy">
			         			<div class="checkbox checkbox-success checkbox-inline">	
			         				<input type="checkbox" name="classfiyId" value="${classfiy.prodClassfiyId}" style="width:100px;height:35px;" checked="checked" disabled />
									<label for="checkbox" class="font-bolder">
										${classfiy.prodClassfiyName} 
									</label>
								</div>
		         		</c:forEach>
		         	</div>
		         </td>
		      </tr>
		      <tr>
		         <td class="active"><label class="pull-right">商品品牌:</label></td>
		         <td>
		         	<div style="height:200px; overflow:auto;padding:0px;" >
		         		<c:forEach items="${brandList}" var="brand">
 							<div class="form-group col-sm-6">
			         			<div class="radio radio-success radio-inline">	
			         				<input type="radio" name="brandId" value="${brand.brandId}" style="width:100px;height:35px;" checked="checked" disabled />
									<label for="radio" class="font-bolder">
										${brand.brandName} 
									</label>
								</div>
							</div>
		         		</c:forEach>		
		         	</div>
		         </td>
		         <td class="active"><label class="pull-right">商品型号:</label></td>
		         <td> 
		         	<div style="height:200px; overflow:auto;" id="modelD">
						<c:forEach items="${modelList}" var="model">
							<div class="form-group col-sm-6">
			         			<div class="radio radio-success radio-inline">	
			         				<input type="radio" name="modelId" value="${model.modelId}" style="width:100px;height:35px;" checked="checked" disabled />
									<label for="radio" class="font-bolder">
										${model.modelName} 
									</label>
								</div>
							</div>	
		         		</c:forEach>
		         	</div>
		         </td>
		      </tr>
		 </tbody>
		 </table>
	</form:form>
	<script type="text/javascript">
	 $(document).ready(function() { 

	 }); 
	  
	</script>
</body>

</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>新增商品</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
	<style type="text/css">
	</style>
		<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/bootstrap.css" />
<!-- 		<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"> -->
<%-- 		<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/htmleaf-demo.css" /> --%>
				<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/build.css" />
				<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
			  $("#inputForm").submit();
			  return true;
	
		  return false;
		} 
	</script>
</head>
<body class="hideScroll">
	<div class="htmleaf-container">
	<form method="post" id="inputForm" name="inputForm"  action="${ctx}/product/product/save">
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品编号:</label></td>
		         <td  width="30%"><input type="text"  class="form-control" name="productId" value="${productId}" readonly="readonly" /></td>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品名称:</label></td>
		         <td width="30%"><input type="text" class="form-control" name="productName" value=""  /></td>
		      </tr>
		      <tr>
		         <td class="active"><label class="pull-right">商品类别:</label></td>
		         <td colspan="3">
		         	<div style="height:60px; overflow:auto;">
		         		<c:forEach items="${classfiyList}" var="classfiy">
			         			<div class="radio radio-success radio-inline">	
			         				<input type="radio" name="classfiyId" value="${classfiy.prodClassfiyId}" style="width:100px;height:35px;"  />
									<label for="radio" class="font-bolder">
										${classfiy.prodClassfiyName} 
									</label>
								</div>
		         		</c:forEach>
<%-- 		         		<input type="radio" name="classfiy"  cssClass="i-checks" value="${selectClassfiy.prodClassfiyId}"  />${selectClassfiy.prodClassfiyName} --%>
<%-- 		         			<form:radiobuttons element="span style='margin-left:16px;' "  --%>
<%-- 		         	   items="${classfiyList}" itemLabel="prodClassfiyName" itemValue="prodClassfiyId" htmlEscape="false" cssClass="i-checks required"/> --%>
		         	</div>
    					<a href="#" onclick="openDialog('新增商品类型', '${ctx}/product/prodClassfiy/addPFrom?addOrEdit=add','400px', '300px')" class="btn btn-success btn-xs" ><i class="fa fa-plus"></i> 新增</a>
		         </td>
		      </tr>
		      <tr>
		         <td class="active"><label class="pull-right">商品品牌:</label></td>
		         <td>
		         	<div style="height:200px; overflow:auto;padding:0px;" id="brandD">
 						<c:forEach items="${brandList}" var="brand">
 							<div class="form-group col-sm-6">
			         			<div class="radio radio-success radio-inline">	
			         				<input type="radio" name="brandId" value="${brand.brandId}" style="width:100px;height:35px;"  />
									<label for="radio" class="font-bolder">
										${brand.brandName} 
									</label>
								</div>
							</div>
		         		</c:forEach>	
 		         	</div>
 		            <a href="#" onclick="openDialog('新增商品品牌', '${ctx}/product/prodBrand/addPFrom?addOrEdit=add','400px', '300px')" class="btn btn-success btn-xs" ><i class="fa fa-plus"></i> 新增</a>
		         </td>
		         <td class="active"><label class="pull-right">商品型号:</label></td>
		         <td> 
		         	<div style="height:200px; overflow:auto;" id="modelD">
						<c:forEach items="${modelList}" var="model">
							<div class="form-group col-sm-6">
			         			<div class="radio radio-success radio-inline">	
			         				<input type="radio" name="modelId" value="${model.modelId}" style="width:100px;height:35px;"  />
									<label for="radio" class="font-bolder">
										${model.modelName} 
									</label>
								</div>
							</div>	
		         		</c:forEach>	
		         	</div>
		           <a href="#" onclick="openDialog('新增商品型号', '${ctx}/product/prodModel/addPFrom?addOrEdit=add','400px', '300px')" class="btn btn-success btn-xs" ><i class="fa fa-plus"></i> 新增</a>
		         </td>
		      </tr>
		 </tbody>
		 </table>
		 <div style="margin-top:30px;text-align: center;">
		 	<button type="button" onclick="doSubmit()" style="width:200px;height:35px;border: 0px;border-radius: 5px;background:#4399EF;color:#ffffff;">保存</button>
		 </div>
	</form>
	</div>
	<script type="text/javascript">
	 $(document).ready(function() { 
				
	 }); 
	</script>
</body>

</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>新增商品类型</title>
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
	<form method="post" id="inputForm" name="inputForm"  action="${ctx}/product/prodClassfiy/save">
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品类型编号:</label></td>
		         <td ><input type="text"  class="form-control" name="prodClassfiyId" value="${classfiyId}" readonly="readonly" /></td>
		      </tr>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品类型名称:</label></td>
		         <td><input type="text" class="form-control" name="prodClassfiyName" value=""  /></td>
		      </tr>
<!-- 		      <tr> -->
<!-- 		         <td class="active"><label class="pull-right">商品品牌:</label></td> -->
<!-- 		         <td> -->
<!-- 		         	<div style="height:200px; overflow:auto;padding:0px;" id="brandD"> -->
		         		
<%-- <%-- 		         			<form:checkboxes element="div style='margin-left:16px;width:40%;' class='form-group col-sm-5' "  --%> 
<%-- <%-- 		         	  items="${brandList}" itemLabel="brandName" itemValue="brandId" htmlEscape="false" cssClass="i-checks"/> --%>  
<!-- 		         	</div> -->
<!-- 		         </td> -->
<!-- 		         <td class="active"><label class="pull-right">商品型号:</label></td> -->
<!-- 		         <td>  -->
<!-- 		         	<div style="height:200px; overflow:auto;" id="modelD"> -->
<%-- <%-- 		         		<c:forEach items="${models}" var="model"> --%>  
<%-- <%-- 		         			<div id="${model.modelId}">${model.modelName}</div> --%> 
<%-- <%-- 		         		</c:forEach> --%>  
<%-- <%-- 		         		<form:checkboxes element="div style='margin-left:16px;width:40%;' class='form-group col-sm-5' "  onclick="selectBrand()" --%>  
<%-- <%--  		         	 	path="modelIdList" items="${modelList}" itemLabel="modelName" itemValue="modelId" htmlEscape="false" cssClass="i-checks required"/>  --%>  
<!-- 		         	</div> -->
<!-- 		         </td> -->
<!-- 		      </tr> -->
		 </tbody>
		 </table>
	</form>
	</div>
	<script type="text/javascript">
	 $(document).ready(function() { 
// 		 findAllBrands();
	 }); 
	 
	 function findAllBrands(){
		 $.ajax({
				type : "GET",
		        url :'${ctx}/product/prodBrand/findAllBrands',
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				cache : false,
				async : false,
				success : function(data) {
				 	console.log(data);
				 	var htmlB='';
				 	if(data.status==1){
				 		$(data.data.brands).each(function(i, item){
				 			htmlB+='<div class=" form-group col-sm-6 ">'
				 			htmlB+='<div class="checkbox checkbox-success checkbox-inline" >';
				 			htmlB+='<input type="checkbox" name="brandId"  style="width:100px;height:35px;" onchange="brandChecked()"  class="styled" value="'+item.brandId+'" />'; 
				 			htmlB+='<label for="brandName" >'+item.brandName+' </label>'; 
				 			htmlB+='</div>';
				 			htmlB+='</div>';
				 		})
				 	}
				 	$("#brandD").html(htmlB);
				 	$("#modelD").html("");
				},
				error : function(msg) {
					console.log(data);
				}
			});
	 }
	 function brandChecked(){
		 $("#modelD").html("");
		 var brandId  = document.getElementsByName("brandId");
		 var brandIds=[];
		 for (var int = 0; int < brandId.length; int++) {
			if(brandId[int].checked){
				brandIds.push(brandId[int].value);
			}
		 }
		 console.log(brandIds);
		 $.ajax({
				type : "GET",
		        url :'${ctx}/product/prodModel/findModelByBrandId',
				data : {
					"brandIds" : brandIds
				},
				dataType : "json",
				traditional: true,
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				cache : false,
				async : false,
				success : function(data) {
				 	console.log(data);
				 	var htmlM='';
				 	if(data.status==1){
				 		$(data.data.models).each(function(i, item){
				 			htmlM+='<div class="col-sm-12">';
				 			htmlM+='<div>';
				 			htmlM+=item.brandName;
				 			htmlM+='</div>';
				 			htmlM+='<div class="checkbox checkbox-success checkbox-inline" style="font-size:10px;padding:0px;">';
				 			$(item.modelList).each(function(j, items){
				 				htmlM+='<div class="col-sm-6">';	
					 			htmlM+='<input type="checkbox" name="modelId"  style="width:100px;height:35px;"  class="styled" value="'+items.modelId+'" />'; 
					 			htmlM+='<label for="modelName" >'+items.modelName+' </label>'; 
					 			htmlM+='</div>';
					 		})
					 		htmlM+='</div>';
					 		htmlM+='</div>';
				 		})
				 	}
				 	$("#modelD").html(htmlM);
				},
				error : function(msg) {
					console.log(msg);
				}
			});
	 }
	</script>
</body>

</html>
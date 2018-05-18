<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>查看商品型号</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/build.css" />
	<script type="text/javascript">
	</script>
</head>
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="prodModel" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品型号编号:</label></td>
		         <td ><form:input path="modelId" readonly="true" htmlEscape="false" maxlength="50" class="form-control required" /></td>
		      </tr>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品型号名称:</label></td>
		         <td ><form:input path="modelName" readonly="true"  htmlEscape="false" maxlength="50" class="form-control required "/></td>
		      </tr>
		       <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>最后更改人:</label></td>
		         <td > <form:input path="updateBy.name" readonly="true"  htmlEscape="false" maxlength="50" class="form-control required "/></td>
		      </tr>
		       <tr>
		         <td class="active" width="15%"><label class="pull-right">最后更改时间:</label></td>
		         <td ><fmt:formatDate value="${prodModel.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		      </tr>
		 </tbody>
		 </table>
	</form:form>
	<script type="text/javascript">
	 $(document).ready(function() { 
// 		 brandChecked();
	 }); 
	 
	 function brandChecked(){
		 $("#modelD").html("");
		 var brandId  = document.getElementsByName("brandIdList");
		 var brandIds=[];
		 for (var int = 0; int < brandId.length; int++) {
			if(brandId[int].checked){
				brandIds.push(brandId[int].value);
			}
		 }
		 var classfiyId = $('input[name="prodClassfiyId"]').val();
		 console.log(brandIds+"---"+classfiyId);
		 $.ajax({
				type : "GET",
		        url :'${ctx}/product/product/findModelByBIdAndCIdAndPId',
				data : {
					"brandIds" : brandIds,
					"classfiyId":classfiyId
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
					 			htmlM+='<input type="checkbox" name="modelId"  style="width:100px;height:35px;"  class="styled" value="'+items.modelId+'" checked="checked"  />'; 
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
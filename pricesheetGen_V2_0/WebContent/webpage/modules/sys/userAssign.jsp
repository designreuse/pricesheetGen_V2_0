<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>分配客户</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	
	<div class="wrapper wrapper-content">
	<div class="container-fluid breadcrumb">
		<div class="row-fluid span12">
			<span class="span4">商务姓名: <b>${user.name}</b></span>
			<span class="span4">归属机构: ${user.office.name}</span>
		</div>
	</div>
	<sys:message content="${message}"/>
	<div class="breadcrumb">
		<form id="assignUserForm" action="${ctx}/sys/user/assignUser" method="post" class="hide">
			<input type="hidden" name="id" value="${user.id}"/>
			<input id="idsArr" type="hidden" name="idsArr" value=""/>
		</form>
		<button id="assignButton" type="submit"  class="btn btn-outline btn-primary btn-sm" title="添加人员"><i class="fa fa-plus"></i> 添加人员</button>
		<script type="text/javascript">
			$("#assignButton").click(function(){
				top.layer.open({
				    type: 2, 
				    area: ['800px', '600px'],
				    title:"选择客户",
			        maxmin: true, //开启最大化最小化按钮
				    content: "${ctx}/sys/user/usertouser?id=${user.id}" ,
				    btn: ['确定', '关闭'],
				    yes: function(index, layero){
						var ids = layero.find("iframe")[0].contentWindow.ids;
					    	// 执行保存
					    	loading('正在提交，请稍等...');
					    	var idsArr = "";
					    	for (var i = 0; i<ids.length; i++) {
					    		idsArr = (idsArr + ids[i]) + (((i + 1)== ids.length) ? '':',');
					    	}
					    	$('#idsArr').val(idsArr);
					    	$('#assignUserForm').submit();
						    top.layer.close(index);
					  },
					  cancel: function(index){ 
		    	       }
				}); 
			});
		</script>
	</div>
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead><tr><th>归属公司</th><th>归属部门</th><th>姓名</th><th>电话</th><th>手机</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${userList}" var="customer">
			<tr>
				<td>${customer.company.name}</td>
				<td>${customer.office.name}</td>
				<td>${customer.name}</td>
				<td>${customer.phone}</td>
				<td>${customer.mobile}</td>
				<shiro:hasPermission name="sys:user:edit"><td>
					<a href="${ctx}/sys/user/outUser?customerId=${customer.id}&id=${user.id}"
						onclick="return confirmx('确认要将客户<b>[${customer.name}]</b>从该商务人员中移除吗？', this.href)">移除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="wrapper wrapper-content">
    <sys:message content="${message}"/>
		<!-- 查询条件 -->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/customerList" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
<!-- 			<span>归属公司：</span> -->
<%-- 				<sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"  --%>
<%-- 				title="公司" url="/sys/office/treeData?type=1" cssClass=" form-control input-sm" allowClear="true" cssStyle="max-width:130px"/> --%>
			<span>登录名：</span>
				<form:input path="loginName" htmlEscape="false" maxlength="50" class=" form-control input-sm" cssStyle="max-width:130px" />
<!-- 			<span>归属部门：</span> -->
<%-- 				<sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" cssStyle="max-width:130px" --%>
<%-- 				title="部门" url="/sys/office/treeData?type=2" cssClass=" form-control input-sm" allowClear="true" notAllowSelectParent="true"/> --%>
			<span>姓&nbsp;&nbsp;&nbsp;名：</span>
				<form:input path="name" htmlEscape="false" maxlength="50" class=" form-control input-sm"  cssStyle="max-width:130px" />
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="sys:user:customerAdd	">
				<table:addRow url="${ctx}/sys/user/customerForm" title="客户" width="800px" height="625px" target="officeContent"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:user:del">
				<table:delRow url="${ctx}/sys/user/deleteAllCustomer" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
<%-- 			<shiro:hasPermission name="sys:user:import"> --%>
<%-- 				<table:importExcel url="${ctx}/sys/user/import"></table:importExcel><!-- 导入按钮 --> --%>
<%-- 			</shiro:hasPermission> --%>
<%-- 			<shiro:hasPermission name="sys:user:export"> --%>
<%-- 	       		<table:exportExcel url="${ctx}/sys/user/export"></table:exportExcel><!-- 导出按钮 --> --%>
<%-- 	       </shiro:hasPermission> --%>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
			</div>
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th width="3%"><input type="checkbox" class="i-checks"></th>
				<th width="10%"  class="sort-column name">姓名</th>
				<th width="10%"  class="sort-column phone">电话</th>
				<th width="10%"  class="sort-column mobile">手机</th>
				<th width="10%"  class="sort-column c.name">归属公司</th>
				<th width="17%"  class="sort-column o.name">归属部门</th>
				<th width="20%" >操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr>
				<td> <input type="checkbox" id="${user.id}" class="i-checks"></td>
				<td>${user.name}</td>
				<td>${user.phone}</td>
				<td>${user.mobile}</td>
				<td>${user.company.name}</td>
				<td>${user.office.name}</td>
				<td>
					<shiro:hasPermission name="sys:user:customerView">
						<a href="#" onclick="openDialogView('查看客户', '${ctx}/sys/user/customerForm?id=${user.id}','800px', '680px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="sys:user:customerEdit">
						<a href="#" onclick="openDialog('修改客户', '${ctx}/sys/user/customerForm?id=${user.id}','800px', '650px', 'officeContent')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="sys:user:del">
						<a href="${ctx}/sys/user/deleteCustomer?id=${user.id}" onclick="return confirmx('确认要删除该客户吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<table:page page="${page}"></table:page>
	</div>
</body>
</html>
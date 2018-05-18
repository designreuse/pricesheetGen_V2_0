<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>商品管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
	       
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>商品列表 </h5>
		<div class="ibox-tools">
			<a class="collapse-link">
				<i class="fa fa-chevron-up"></i>
			</a>
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-wrench"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#">选项1</a>
				</li>
				<li><a href="#">选项2</a>
				</li>
			</ul>
			<a class="close-link">
				<i class="fa fa-times"></i>
			</a>
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="product" action="${ctx}/product/product/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
	 	<div class="form-group">
			<span>商品名称：</span>
				<form:input path="productName" htmlEscape="false" maxlength="23"  class=" form-control input-sm"/>
<!-- 			<span>报价日期：</span> -->
<!-- 				<input id="beginQuotationDate" name="beginQuotationDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm" -->
<%-- 					value="<fmt:formatDate value="${quotationOrder.beginQuotationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> -  --%>
<!-- 				<input id="endQuotationDate" name="endQuotationDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm" -->
<%-- 					value="<fmt:formatDate value="${quotationOrder.endQuotationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> --%>
		 </div>	 
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			 <shiro:hasPermission name="product:product:add">
			 	<a href="#" onclick='top.openTab("${ctx}/product/product/addFrom","商品新增", false)' title="商品新增" class="btn btn-info btn-xs" >
						<i class="fa fa-plus"></i>新增</a>
<%-- 			 	<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="openDialogAddProd('新增商品', '${ctx}/product/product/addForm','800px', '500px')" title="添加"><i class="fa fa-plus"></i> </button> --%>
<%-- 				<table:addRow url="${ctx}/product/product/addFrom" title="增加"></table:addRow><!-- 增加按钮 --> --%>
			</shiro:hasPermission>
			<shiro:hasPermission name="product:product:del">
				<table:delRow url="${ctx}/product/product/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
			</div>
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column productId">商品编号</th>
				<th  class="sort-column productName">商品名称</th>
				<th  class="sort-column updateBy.name">最后更改商品人</th>
				<th  class="sort-column createDate">创建时间</th>
				<th  class="sort-column updateDate">最后更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="product">
			<tr>
				<td> <input type="checkbox" id="${product.uid}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看', '${ctx}/product/product/form?id=${product.uid}','800px', '500px')" >
					${product.productId}
				</a></td>
				<td>
					${product.productName}
				</td>
				<td>
					${product.updateBy.name}
				</td>
				<td>
					<fmt:formatDate value="${product.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${product.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<shiro:hasPermission name="product:product:view">
						<a href="#" onclick="openDialogView('查看', '${ctx}/product/product/form?id=${product.uid}','800px', '500px')" class="btn btn-success btn-xs" >
						<i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="product:product:edit">
						<a href="#" onclick='top.openTab("${ctx}/product/product/editFrom?id=${product.uid}","商品修改${product.productId}", false)' title="商品修改" class="btn btn-info btn-xs" >
						<i class="fa fa-edit"></i> 修改</a>
<%--     					<a href="#" onclick="openDialog('修改商品', '${ctx}/product/product/editFrom?id=${product.uid}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a> --%>
    				</shiro:hasPermission> 
    				 <shiro:hasPermission name="product:product:del">
						<a href="${ctx}/product/product/delete?id=${product.uid}" onclick="return confirmx('确认要删除该商品吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>  
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
	</div>
</div>
</body>
</html>
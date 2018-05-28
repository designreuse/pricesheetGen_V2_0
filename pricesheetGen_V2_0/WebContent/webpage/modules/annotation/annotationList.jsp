<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>注释管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
	        laydate({
	            elem: '#beginQuotationDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
	        laydate({
	            elem: '#endQuotationDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>注释列表 </h5>
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
	<form:form id="searchForm" modelAttribute="annotation" action="${ctx}/annotation/annotation/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<%-- <div class="form-group">
			<span>报价单号：</span>
				<form:input path="quotationCode" htmlEscape="false" maxlength="23"  class=" form-control input-sm"/>
			<span>报价日期：</span>
				<input id="beginQuotationDate" name="beginQuotationDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${quotationOrder.beginQuotationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endQuotationDate" name="endQuotationDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${quotationOrder.endQuotationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
		 </div>	 --%>
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<%-- <shiro:hasPermission name="quotation:quotationOrder:add">
				<table:addRow url="${ctx}/annotation/annotation/form" title="注释"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="annotation:annotation:edit">
			    <table:editRow url="${ctx}/annotation/annotation/form" title="注释" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="annotation:annotation:del">
				<table:delRow url="${ctx}/annotation/annotation/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission> --%>
			
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
				<th  class="sort-column id">报价单号</th>
				<th  class="sort-column quotationCode">规格</th>
				<th  class="sort-column quotationDate">型号</th>
				<th  class="sort-column quotationDate">价格</th>
				<th  class="sort-column updateDate">更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="annotation">
			<tr>
				<td> <input type="checkbox" id="${annotation.uid}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看注释', '${ctx}/annotation/annotation/form?id=${annotation.uid}','800px', '500px')">
					<%-- ${quotationOrder.id} --%>
					${annotation.quotationCode}
				</a></td>
				<td>
					${annotation.annoName}
				</td>
				<td>
					${annotation.annoType}
				</td>
				<td>
					${annotation.annoPrice}
				</td>
				<td>
					<fmt:formatDate value="${annotation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					 <shiro:hasPermission name="annotation:annotation:view">
						<a href="#" onclick="openDialogView('查看注释', '${ctx}/annotation/annotation/form?id=${annotation.uid}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<%-- <shiro:hasPermission name="annotation:annotation:edit">
    					<a href="#" onclick="openDialog('修改注释', '${ctx}/annotation/annotation/form?id=${quotationOrder.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission> --%>
    				<%-- <shiro:hasPermission name="quotation:quotationOrder:del">
						<a href="${ctx}/quotation/quotationOrder/delete?id=${quotationOrder.id}" onclick="return confirmx('确认要删除该注释吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission> --%>
				</td>
				<%-- <td>
					<fmt:formatDate value="${quotationOrder.quotationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${quotationOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<shiro:hasPermission name="quotation:quotationOrder:view">
						<a href="#" onclick="openDialogView('查看报价单', '${ctx}/quotation/quotationOrder/form?id=${quotationOrder.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="quotation:quotationOrder:edit">
    					<a href="#" onclick="openDialog('修改报价单', '${ctx}/quotation/quotationOrder/form?id=${quotationOrder.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="quotation:quotationOrder:del">
						<a href="${ctx}/quotation/quotationOrder/delete?id=${quotationOrder.id}" onclick="return confirmx('确认要删除该报价单吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td> --%>
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
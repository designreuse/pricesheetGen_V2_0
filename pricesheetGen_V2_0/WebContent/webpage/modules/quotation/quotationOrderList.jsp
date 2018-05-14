<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>报价单管理</title>
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
	
	<script src="${ctxStatic}/common/contabs.js"></script> 
	
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>报价单列表 </h5>
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
	<form:form id="searchForm" modelAttribute="quotationOrder" action="${ctx}/quotation/quotationOrder/list" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>报价单号：</span>
				<form:input path="quotationCode" htmlEscape="false" maxlength="23"  class=" form-control input-sm"/>
			<span style="padding-left: 50px">最终成交价：</span>
				<input id="startDlAmt" name="startDlAmt" type="number" maxlength="12" class="laynumber-icon form-control layer-number input-sm"
					 /> - 
				<input id="endDlAmt" name="endDlAmt" type="number" maxlength="12" class="laynumber-icon form-control layer-number input-sm"
					 />
			<span style="padding-left: 50px;min-width: 100px">客户联系人：</span>
				<form:input path="custName" htmlEscape="false" maxlength="10"  class=" form-control input-sm"/>		
		 </div>	
		<div class="form-group" style="padding-top: 8px">
			<span>产品名称：</span>
				<form:input path="productName" htmlEscape="false" maxlength="23"  class=" form-control input-sm"/>
			<span style="padding-left: 50px">报价日期：</span>
				<input id="beginQuotationDate" name="beginQuotationDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${quotationOrder.beginQuotationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endQuotationDate" name="endQuotationDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${quotationOrder.endQuotationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			<span style="padding-left: 50px;min-width: 100px">报价关于：</span>
				<form:input path="quotationAbout" htmlEscape="false" maxlength="23"  class=" form-control input-sm" placeholder="报价关于[可支持模糊查询]" />	
		 </div>	



	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
		<%-- 	<shiro:hasPermission name="quotation:quotationOrder:add">
				<table:addRow url="${ctx}/quotation/quotationOrder/form" title="报价单"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="quotation:quotationOrder:edit">
			    <table:editRow url="${ctx}/quotation/quotationOrder/form" title="报价单" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="quotation:quotationOrder:import">
				<table:importExcel url="${ctx}/quotation/quotationOrder/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
	       	--%>
			<shiro:hasPermission name="quotation:quotationOrder:del">
				<table:delRow url="${ctx}/quotation/quotationOrder/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="quotation:quotationOrder:export">
	       		<table:exportExcel url="${ctx}/quotation/quotationOrder/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column quotationCode ">报价单号</th>
				<th  class="sort-column quotationDate ">报价日期</th>
				<th  class="sort-column company">客户公司</th>
				<th  class="sort-column custName      ">客户联系人</th>
				<th  class="sort-column dealAmt       ">最终成交价</th>
				<th  class="sort-column staffName     ">销售人员</th>
				<th  class="sort-column quotationAbout">报价关于</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="quotationOrder">
			<tr>
				<td> <input type="checkbox" id="${quotationOrder.id}" class="i-checks"></td>

<%-- 				<td>
				<a  href="#" onclick="openDialogView('查看报价单', '${ctx}/quotation/quotationOrder/form?id=${quotationOrder.id}','800px', '500px')">
					${quotationOrder.id}
				</a>
				</td> --%>
				<td> 
					${quotationOrder.quotationCode}
				</td>
				<td>
					<fmt:formatDate value="${quotationOrder.quotationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${quotationOrder.company}
				</td>
				<td>
					${quotationOrder.custName}
				</td>
				<td>
					${quotationOrder.dealAmt}
				</td>
				<td>
					${quotationOrder.staffName}
				</td>
				<td>
					${quotationOrder.quotationAbout}
				</td>

				<td>
					<shiro:hasPermission name="quotation:quotationOrder:show">
						<a href="#" onclick='top.openTab("${ctx}/quotation/quotationOrder/show?id=${quotationOrder.id}","查看${quotationOrder.quotationCode}", false)' title="报价单明细" class="btn btn-info btn-xs" >
						<i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="quotation:quotationOrder:edit">					
    					<a href="#" onclick='top.openTab("${ctx}/quotation/quotationOrder/edit?id=${quotationOrder.id}","修改${quotationOrder.quotationCode}", false)' class="btn btn-success btn-xs" title="报价单修改" ><i class="fa fa-edit"></i>
    					 修改</a>
    				</shiro:hasPermission>
					<shiro:hasPermission name="annotation:annotation:annotationAddNav">
						<a href="#" onclick='top.openTab("${ctx}/annotation/annotation/annotationAddNav?id=${quotationOrder.id}&quotationCode=${quotationOrder.quotationCode}","注释${quotationOrder.quotationCode}", false)' title="添加注释" class="btn btn-info btn-xs" >
						<i class="fa fa-search-plus"></i>添加注释</a>
					</shiro:hasPermission>
    				<shiro:hasPermission name="quotation:quotationOrder:del">
						<a href="${ctx}/quotation/quotationOrder/delete?id=${quotationOrder.id}" onclick="return confirmx('确认要删除该报价单吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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
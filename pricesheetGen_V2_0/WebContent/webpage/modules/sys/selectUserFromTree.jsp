<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>分配角色</title>
	<meta name="decorator" content="blank"/>
	<%@include file="/webpage/include/treeview.jsp" %>
	<script type="text/javascript">
	
		var officeTree;
		var selectedTree;//zTree已选择对象
		
		// 初始化
		$(document).ready(function(){
			officeTree = $.fn.zTree.init($("#officeTree"), setting, officeNodes);
		});

		var setting = {view: {selectedMulti:false,nameIsHTML:true,showTitle:false,dblClickExpand:true},
				data: {simpleData: {enable: true}},
				callback: {onClick: treeOnClick}};
		
		var officeNodes=[
	            <c:forEach items="${officeList}" var="office">
	            {id:"${office.id}",
	             pId:"${not empty office.parent?office.parent.id:0}", 
	             name:"${office.name}",
	             type:"${office.type}"},
	            </c:forEach>];
	
		var pre_selectedNodes =[
   		        <c:forEach items="${userList}" var="user">
   		        {id:"${user.id}",
				pId:"0",
				email:"${user.email}",
				mobile:"${user.mobile}",
				phone:"${user.phone}",
				companyName:"${user.company.name}",
				officeFax:"${user.office.fax}",
				name:"<font color='red' style='font-weight:bold;'>${user.name}</font>"},
   		        </c:forEach>];
		
		var selectedNodes =[
		        <c:forEach items="${userList}" var="user">
		        {id:"${user.id}",
		         pId:"0",
		         name:"<font color='red' style='font-weight:bold;'>${user.name}</font>"},
		        </c:forEach>];
		
		var pre_ids = "${selectIds}".split(",");
		var ids = "${selectIds}".split(",");
		var selectedUser = {};
		//点击选择项回调
		function treeOnClick(event, treeId, treeNode, clickFlag){
			$.fn.zTree.getZTreeObj(treeId).expandNode(treeNode);
			if("officeTree"==treeId){
				$.get("${ctx}/sys/role/users?officeId=" + treeNode.id+"&type="+treeNode.type, function(userNodes){
					$.fn.zTree.init($("#userTree"), setting, userNodes);
				});
			}
			if("userTree"==treeId){
				$(".table-responsive").show();
				$("#sname").text(treeNode.name);
				$("#smobile").text(treeNode.mobile);
				$("#smail").text(treeNode.mail);
				$("#scompanyName").text(treeNode.companyName);
				$("#scompanyFax").text(treeNode.companyFax);
				selectedUser = treeNode;
			};
			 
		};
		function clearAssign(){
			var submit = function (v, h, f) {
			    if (v == 'ok'){
					var tips="";
			    	top.$.jBox.tip(tips, 'info');
			    } else if (v == 'cancel'){
			    	// 取消
			    	top.$.jBox.tip("取消清除操作！", 'info');
			    }
			    return true;
			};
			tips="确定清除角色【${role.name}】下的已选人员？";
			top.$.jBox.confirm(tips, "清除确认", submit);
		};
	</script>
</head>
<body>
	
	<div id="assignRole" class="row wrapper wrapper-content">
		<div class="col-sm-4" style="border-right: 1px solid #A8A8A8;">
			<p>所在部门：</p>
			<div id="officeTree" class="ztree"></div>
		</div>
		<div class="col-sm-3">
			<p>待选人员：</p>
			<div id="userTree" class="ztree"></div>
		</div>
		<div class="col-sm-5" style="padding-left:16px;border-left: 1px solid #A8A8A8;">
			<div id="selectedTree" class="ztree"></div>   
			<div class="col-sm-12">
									<div class="table-responsive" hidden="true">
										<table class="table table-bordered">
											<tbody>
												<tr>
													<td style="min-width: 75px;width: 20%"><strong>姓名</strong></td>
													<td id="sname" style="width: 80%"></td>
												</tr>
												<tr>
													<td><strong>联系电话</strong></td>
													<td id="smobile"></td>
												</tr>
												<tr>
													<td><strong>公司</strong></td>
													<td id="scompanyName"></td>
												</tr>
												<tr>
													<td><strong>联系传真</strong></td>
													<td id="scompanyFax"></td>
												</tr>
												<tr>
													<td><strong>邮箱</strong></td>
													<td id="smail"></td>
												</tr>
											</tbody>
										</table>										
									</div>
								</div>			
		</div>
	</div>
</body>
</html>

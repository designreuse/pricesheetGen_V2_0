<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>分配客户</title>
	<meta name="decorator" content="blank"/>
	<%@include file="/webpage/include/treeview.jsp" %>
	<script type="text/javascript">
	
		var officeTree;
		var selectedTree;//zTree已选择对象
		
		// 初始化
		$(document).ready(function(){
			officeTree = $.fn.zTree.init($("#officeTree"), setting, officeNodes);
			selectedTree = $.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
		});

		var setting = {view: {selectedMulti:false,nameIsHTML:true,showTitle:false,dblClickExpand:false},
				data: {simpleData: {enable: true}},
				callback: {onClick: treeOnClick}};
		
		var officeNodes=[
	            <c:forEach items="${officeList}" var="office">
	            {id:"${office.id}",
	             pId:"${not empty office.parent?office.parent.id:0}", 
	             name:"${office.name}",
	             type:"${office.type}"},
	            </c:forEach>];
		var selectedNodes =[];
		var ids =[];
		var userId="${user.id}"
		//点击选择项回调
		function treeOnClick(event, treeId, treeNode, clickFlag){
			$.fn.zTree.getZTreeObj(treeId).expandNode(treeNode);
			if("officeTree"==treeId){
				$.get("${ctx}/sys/user/users?officeId=" + treeNode.id+"&type="+treeNode.type+"&userId="+userId, function(userNodes){
					console.log(userNodes);
					$.fn.zTree.init($("#userTree"), setting, userNodes);
				});
			}
			if("userTree"==treeId){
				//alert(typeof ids[0] + " | " +  typeof treeNode.id);
				if($.inArray(String(treeNode.id), ids)<0){
					selectedTree.addNodes(null, treeNode);
					ids.push(String(treeNode.id));
				}
			};
			if("selectedTree"==treeId){
// 				alert(treeNode.id + " | " + ids);
				selectedTree.removeNode(treeNode);
				ids.splice($.inArray(String(treeNode.id), ids), 1);
			}
		};
	</script>
</head>
<body>
	
	<div id="assignRole" class="row wrapper wrapper-content">
		<div class="col-sm-4" style="border-right: 1px solid #A8A8A8;">
			<p>所在公司：</p>
			<div id="officeTree" class="ztree"></div>
		</div>
		<div class="col-sm-4">
			<p>待选人员：</p>
			<div id="userTree" class="ztree"></div>
		</div>
		<div class="col-sm-4" style="padding-left:16px;border-left: 1px solid #A8A8A8;">
			<p>已选人员：</p>
			<div id="selectedTree" class="ztree"></div>
		</div>
	</div>
</body>
</html>

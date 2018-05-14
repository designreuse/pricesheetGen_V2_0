<%@ page language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<!DOCTYPE html>
<html>
	<head>
		<title>教育物联网(RFID)考试管理系统 | 单位管理</title>
		<tags:head_common_content/>
	</head>
	<body class="hold-transition skin-blue-light sidebar-mini">
		<div class="wrapper">
			<!-- Main header -->
			<tags:main_header/>
			
			<!-- Left side column. contains the logo and sidebar -->
			<tags:main_sidebar active="unitList"/>
			
			<!-- Content Wrapper. Contains page content -->
			<div class="content-wrapper">
				<div class="context-tips">
		      		<tags:action_tip/>
		      	</div>
				<!-- Content Header (Page header) -->
				<section class="content-header">
					<h1>单位管理</h1>
					<ol class="breadcrumb">
						<li><a href="#"><i class="fa fa-dashboard"></i> 主页</a></li>
						<li><a href="#">报价单管理</a></li>
						<li class="active">报价单查询</li>
					</ol>
				</section>

				<!-- Main content -->
				<section class="content">
					<div class="box box-primary">
		                <div class="box-header with-border">
		                  <h3 class="box-title"><i class="fa fa-search"></i> 查询表单</h3>
		                  <div class="box-tools">
							  	<a class="btn pull-right" href="${ctx}/quotation/add"><i class="fa fa-plus"></i> 添加</a>		                  	
		                  </div>
		                </div><!-- /.box-header -->
		                <!-- form start -->
		                <form class="form-horizontal" action="${ctx}/quotation/list">
		                  <!-- ------- -->
						                  <div class="box-body">
						                  	<div  class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
						                  		<label for="id" class="col-sm-3 control-label" style="padding-left: 0px;padding-right: 0px;">报价单编号</label>
						                     	<div class="col-sm-9"  style="padding-left: 10px;padding-right: 0px;">
							                        <input class="form-control" id="quotationCode" name="quotationCode" value="${quotationCode}" placeholder="报价单编号" type="text">
						                      	</div>
						                  	</div>
						                  	<div  class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
						                     	<label for="id" class="col-sm-3 control-label" style="padding-left: 0px;padding-right: 0px;">公司名称</label>
						                     	<div class="col-sm-9"  style="padding-left: 10px;padding-right: 0px;">
							                        <input class="form-control" id="company" name="company" value="${company}" placeholder="公司名称[可支持模糊查询]" type="text">
						                      	</div>						                  		
						                  	</div>
						                  	<div  class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
							                     	<label for="id" class="col-sm-3 control-label" style="padding-left: 0px;padding-right: 0px;">报价单状态</label>
							                     	<div class="col-sm-9"  style="padding-left: 10px;padding-right: 0px;">
							                      	<select id="state" name="state" class="form-control" placeholder="报价单状态" >
											    		<option value="" selected="true">请选择</option>
											    		<option value="001" >待注释</option>
											    		<option value="002" >待核价</option>
											    		<option value="003" >完成</option>
<%-- 											    		<c:forEach var="type" items="${paratypes}">
											    			<option value="${type.key}" <c:if test="${childType==type.key}">selected="true"</c:if>>${type.value}</option>
											    		</c:forEach> --%>											    		
								    				</select>
							                      	</div>
							                      							                  	
						                  	</div>
						                  </div>
						                  
						                  <div class="box-body">
						                  	<div  class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
						                  		<label for="id" class="col-sm-3 control-label" style="padding-left: 0px;padding-right: 0px;">销售人员</label>
						                     	<div class="col-sm-9"  style="padding-left: 10px;padding-right: 0px;">
							                        <input class="form-control" id="staffName" name="staffName" value="${staffName}" placeholder="销售人员" type="text">
						                      	</div>
						                  	</div>
						                  	<div  class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
						                     	<label for="id" class="col-sm-3 control-label" style="padding-left: 0px;padding-right: 0px;">客户联系人</label>
						                     	<div class="col-sm-9"  style="padding-left: 10px;padding-right: 0px;">
							                        <input class="form-control" id="custName" name="custName" value="${custName}" placeholder="客户名称[可支持模糊查询]" type="text">
						                      	</div>						                  		
						                  	</div>
						                  	<div  class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
							                     	<label for="id" class="col-sm-3 control-label" style="padding-left: 0px;padding-right: 0px;">报价日期</label>
							                     	<div class="col-sm-9"  style="padding-left: 10px;padding-right: 0px;">
								                        <div class="col-sm-6"  style="padding-left: 0px;padding-right: 5px;">
								                        	<input class="form-control"  id="beginDate" name="beginDate" value="${beginDate}" placeholder="起始日期" type="date">
							                      		</div>
							                      		<div class="col-sm-6"  style="padding-left: 5px;padding-right: 0px;">
								                       		<input class="form-control " id=endDate name=endDate value="${endDate}" placeholder="截止日期" type="date">
							                      		</div>
							                      	</div>				                  	
						                  	</div>
						                  </div>	
						                  
						                  <div class="box-body">
						                  	<div  class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
						                  		<label for="id" class="col-sm-3 control-label" style="padding-left: 0px;padding-right: 0px;">产品名称</label>
						                     	<div class="col-sm-9"  style="padding-left: 10px;padding-right: 0px;">
							                        <input class="form-control" id="productName" name="productName" value="${productName}" placeholder="产品名称[可支持模糊查询]" type="text">
						                      	</div>
						                  	</div>
						                  	<div  class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
						                     	<label for="id" class="col-sm-3 control-label" style="padding-left: 0px;padding-right: 0px;">报价关于</label>
						                     	<div class="col-sm-9"  style="padding-left: 10px;padding-right: 0px;">
							                        <input class="form-control" id="quotationAbout" name="quotationAbout" value="${quotationAbout}" placeholder="报价关于" type="text">
						                      	</div>						                  		
						                  	</div>
						                  	<div  class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
							                     	<label for="id" class="col-sm-3 control-label" style="padding-left: 0px;padding-right: 0px;">最终成交价</label>
							                     	<div class="col-sm-9"  style="padding-left: 10px;padding-right: 0px;">
								                        <div class="col-sm-6"  style="padding-left: 0px;padding-right: 5px;">
								                        	<input class="form-control col-sm-12"  id="startDlAmt" name="startDlAmt" value="${startQAmt}" placeholder="起始金额" type="number">
							                      		</div>
							                      		<div class="col-sm-6"  style="padding-left: 5px;padding-right: 0px;">
								                       		<input class="form-control full-width" id=endDlAmt name=endDlAmt value="${endQAmt}" placeholder="截止金额" type="number">
							                      		</div>
							                      	</div>				                  	
						                  	</div>
						                  </div>							                  					                  
		                  <!-- -------f -->		                  	                  
		                  <!-- /.box-body -->
		                  <div class="box-footer">
		                    <button type="submit" class="btn btn-info pull-right"><i class="fa fa-search"></i> 查询</button>
		                  </div><!-- /.box-footer -->
		                </form>
			        </div><!-- /.box -->
				
					<div class="row">
						<div class="col-md-12">
							<div class="box box-info">
								<div class="box-header with-border">
									<h3 class="box-title"><i class="fa fa-list"></i> 报价单列表</h3>
									<div class="box-tools pull-right">
								        <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
								    </div>
								</div><!-- /.box-header -->
				                <div class="box-body">
					                <div class="table-responsive">
						                <table class="table table-striped">
											<thead>
											    <tr>
											        <th>报价单号</th>
				                                    <th>报价日期</th>
				                                    <th>客户公司</th>
				                                    <th>客户联系人</th>
				                                    <th>最终成交价</th>
				                                    <th>销售人员</th>
				                                    <th>报价关于</th>
											        <th class="text-right">操作</th>
											    </tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${pageInfo.list}">
												<tr>
													<td>${item.quotationCode}</td>
				                                    <td><fmt:formatDate value="${item.quotationDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
				                                    <td>${item.company}</td>
				                                    <td>${item.custName}</td>
				                                    <td>${item.dealAmt}</td>			                                   
				                                    <td>${item.staffName}</td>	
				                                    <td>${item.quotationAbout}</td>
													<td>
														<div class="btn-toolbar pull-right" role="toolbar">
															<div class="btn-group">
																<a type="button" class="btn btn-default btn-xs" title="修改" href="${ctx}/quotation/update?quotationCode=${item.quotationCode}"><i class="fa fa-fw fa-edit" aria-hidden="true"></i></a>
																<a type="button" class="btn btn-default btn-xs" title="查看" href="${ctx}/quotation/show?quotationCode=${item.quotationCode}"><i class="fa fa-fw fa-eye" aria-hidden="true"></i></a>
																<a type="button" class="btn btn-default btn-xs" title="删除" href="${ctx}/quotation/delete?quotationCode=${item.quotationCode}&childCode=${item.quotationCode}" onclick="return confirm('确认删除?')"><i class="glyphicon glyphicon-trash" aria-hidden="true"></i></a>
															</div>
														</div>
													</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
				                </div><!-- /.box-body -->
					
								<div class="box-footer clearfix">
									<tags:pagination url="${ctx}/quotation/list" page="${pageInfo}" cssClass="pull-right"/>
								</div>
							</div><!-- /.box -->
						</div><!-- /.col -->
					</div><!-- /.row -->
				</section><!-- /.content -->
			</div><!-- /.content-wrapper -->
	      
			<!-- Main footer -->
			<tags:main_footer/>
			
			<!-- Control Sidebar -->
			<tags:control_sidebar/>
      
		</div><!-- ./wrapper -->

		<tags:load_common_js/>
	</body>
</html>

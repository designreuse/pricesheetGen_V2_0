<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>首页</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		     WinMove();
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
   <div class="row  border-bottom white-bg dashboard-header">
        <div class="col-sm-12">
            <blockquote class="text-info" style="font-size:14px">
            	<h1>平台简介<br></h1>
            	 www.sh-sapling.com , 上海小数信息技术有限公司报价系统V1.0
    			<br/>
               <br>V1.0采用了目前极为流行的扁平化响应式的设计风格。
                <br>…………
            </blockquote>

            <hr>
        </div>
    </div>
      
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-4">

                <div class="ibox float-e-margins">
                     <div class="ibox-title">
                        <h5>技术特点</h5> 
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="index.html#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="index.html#">选项1</a>
                                </li>
                                <li><a href="index.html#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <p> 该平台采用 SpringMVC + MyBatis + BootStrap + Apache Shiro + Ehcache 开发组件 的基础架构,采用面向声明的开发模式， 基于泛型编写极少代码即可实现复杂的数据展示、数据编辑、
表单处理等功能，再配合代码生成器的使用,将J2EE的开发效率提高5倍以上，可以将代码减少50%以上。

                        <ol>
						<li>代码生成器，支持多种数据模型,根据表生成对应的Entity,Service,Dao,Action,JSP等,增删改查/排序/导出导入Excel/权限控制/功能生成直接使用</li>
						<li>基础用户权限，强大数据权限，操作权限控制精密细致，对所有管理链接都进行权限验证，可控制到按钮，对指定数据集权限进行过滤</li>
						<li>简易Excel导入导出，支持单表导出和一对多表模式导出，生成的代码自带导入导出Excel功能</li>
						<li>查询过滤器，查询功能自动生成，后台动态拼SQL追加查询条件；支持多种匹配方式（全匹配/模糊查询/包含查询/不匹配查询） </li>
						
						<li>...</li>
						<li>要求JDK1.6+</li>
                        </ol>
                    </div>
                </div>
              
            </div>
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                     <div class="ibox-title">
                        <h5>平台升级日志</h5> <span class="label label-primary">H+</span>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="index.html#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="index.html#">选项1</a>
                                </li>
                                <li><a href="index.html#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="panel-body">
                            <div class="panel-group" id="version">
                            
                            	<div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v2.5">v2.5</a><code class="pull-right">2016.10.8更新</code>
                                            </h5>
                                    </div>
                                    <div id="v2.5" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <ol>
                                            	<li>... </li>
                                                <li>....</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            
                            	<div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v2.4">v2.4</a><code class="pull-right">2016.06.27更新</code>
                                            </h5>
                                    </div>
                                    <div id="v2.4" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <ol>
                                                <li>修复分页bug。</li>
                                                <li>....</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            	<div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v2.3">v2.3</a><code class="pull-right">2016.05.17更新</code>
                                            </h5>
                                    </div>
                                    <div id="v2.3" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <ol>
                                            	<li>修复初次登录，菜单加载慢的问题,加载速度从10秒优化到2秒。</li>
                                                <li>修复list导入Excel文档为空的bug。</li>
                                                <li>修复360浏览器（7.1版本）提交表单失败的bug。</li>
                                                <li>修复短信发送bug。</li>
                                                <li>修复发送站内信时，无法添加图片的bug。</li>
                                                <li>增加我的日程功能。</li>
                                                <li>修复代码生成器生成的树结构，删除子节点时，会误删除父节点的bug。</li>
                                                <li>....</li>
                                                <li>....</li>
                                                <li>....</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            		<div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v2.2">v2.2Beta版</a><code class="pull-right">2016.03.13更新</code>
                                            </h5>
                                    </div>
                                    <div id="v2.2" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <ol>
                                            	<li>这是目前为止最重要的一次升级。</li>
                                                <li>新增功能：cpu，内存，jvm性能检测预警工具，短信群发功能，邮件群发功能，ace主题切换功能，表单构建器功能等功能。</li>
                                                <li>修正了大量2.1beta版本的bug，以及页面性能优化，具体参照网站的更新报告</li>
                                                <li>升级代码生成器功能，移除（可插入，可编辑）2个配置项，新增(表单）配置项，使代码生成器更加简单易懂，提高了代码生成器的实用性。</li>
                                                <li>....</li>
                                                <li>富文本编辑器，自定义java对象功能，表格的行权限和列权限，上下菜单风格，echarts图表生成器等功能预计在2.3版本推出。</li>
                                                <li>感谢大家的持续关注，如果你有更好的建议，请直接联系我。</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                                
                                 
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.0</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                               
                </div>
            </div>
            </div>
            </div>
            </div>
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>商业授权 </h5>
                    </div>
                    <div class="ibox-content">
                        <p>...</p>
                        <ol>
                            <li>……</li>
                        </ol>
                        <hr>
                    

                    </div>
                </div>
                  <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>联系信息</h5>

                    </div>
                    <div class="ibox-content">
                        <p><i class="fa fa-send-o"></i> 网址：<a href="http://www.sapling.org" target="_blank">http://www.SapLing.org</a>
                        </p>
                        <p><i class="fa fa-qq"></i> QQ：<a href="http://wpa.qq.com/msgrd?v=3&uin=117575171&site=qq&menu=yes" target="_blank">xxxxxxxxx</a>
                        </p>
                        <p><i class="fa fa-weixin"></i> 微信：<a href="javascript:;">xxxxxx</a>
                        </p>
                        <p><i class="fa fa-credit-card"></i> 支付宝：<a href="javascript:;" class="支付宝信息">xxx@qq.com</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
	</div>
</body>
</html>
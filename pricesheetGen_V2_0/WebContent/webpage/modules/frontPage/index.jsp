<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html ng-app="myApp">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=gb2312">
<title>报价系统</title>
<script src="js/jquery-2.1.1.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="js/jquery.cookie.js"></script>
<script src="js/angular.min.js"></script>
<script src="js/angular-route.min.js"></script>
<script src="js/angular-cookies.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/test.js"></script>
<script src="js/config.js"></script>

<script src="js/tripledes.js"></script>  
<script src="js/mode-ecb.js"></script>
<script src="js/tm.pagination.js"></script>
<script src="controlJs/index.js"></script>
<script src="controlJs/checkedOfferIndex.js"></script>
<script src="controlJs/applyOfferList.js"></script>
<script src="controlJs/aboutUs.js"></script>
<script src="controlJs/personalData.js"></script>
<script src="layer-v2.3/layer/layer.js"></script>
<script src="layer-v2.3/layer/laydate/laydate.js"></script>
<script>
	window.liveSettings = {
		api_key : "a0b49b34b93844c38eaee15690d86413",
		picker : "bottom-right",
		detectlang : true,
		dynamic : true,
		autocollect : true
	};
</script>
</head>
<body bgcolor="white" style="background-color:white ">
	<main>
      <div>
        <!-- 更换页面内容 -->
     	 <div ng-view class="view">

        </div>
      </div>
    </main>  
</body>
</html>
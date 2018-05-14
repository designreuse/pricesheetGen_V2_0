//    app.controller('DemoController', ['$scope', 'BusinessService', function ($scope, BusinessService) {
app.controller('aboutUs_ctrl',function($scope, $http, $routeParams, $cookieStore, $location, $sce,MathService) {
	if(MathService.is_log($cookieStore)){	

	}else{
		 
	}
}).filter('to_trusted', [ '$sce', function($sce) {
	return function(text) {
		return $sce.trustAsHtml(text);
	}
} ]);

app.factory('BusinessService', ['$http', function ($http) {
    var list = function (postData) {
        return $http.post('/Employee/GetAllEmployee', postData);
    }

    return {
        list: function (postData) {
            return list(postData);
        }
    }
}]);
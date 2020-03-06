angular
    .module('WidgetsDirect', ['ngMaterial'])
    .controller('PageController', ['$q', '$scope', '$timeout', '$http', '$log', function($q, $scope, $timeout, $http, $log){
        $scope.message = ""
        $scope.sortAsc = true;

        $http.get('/widgetsdirect/rest/Chris').then(
            function(response) { //success
                $scope.message = response.data.Message;
                $scope.widgets = response.data.Widgets;
            },
            function(response) { //failure
                $scope.message = "Couldn't get data rip";
            }
        )
    }
    ])
angular.module('rab').controller('ProfileCtrl', ['$scope', function($scope) {
  console.log('ProfileCtrl called');

  $scope.alert_me = function() {
    console.log('aaa');
  }
}]);

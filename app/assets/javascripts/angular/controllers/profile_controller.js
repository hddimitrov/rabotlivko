angular.module('rab').controller('ProfileCtrl', ['$scope', function($scope) {
  console.log('ProfileCtrl called');

  $scope.set_active_tab = function(tab) {
    $scope.active_tab = tab;
  }
}]);

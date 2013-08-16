angular.module('rab').controller('ProfileCtrl', ['$scope', 'favsServices', function($scope, favsServices) {
  console.log('ProfileCtrl called');

  $scope.set_active_tab = function(tab) {
    $scope.active_tab = tab;
  }

  $scope.fav = function(user_id) {
    console.log('fav user: ' + user_id);
    favsServices.fav_user(user_id).then(function(response){
      console.log('user faved');
    });
  }

  $scope.unfav = function(user_id) {
    console.log('unfav user: ' + user_id);
    favsServices.unfav_user(user_id).then(function(response){
      console.log('user unfaved');
    });
  }

  $scope.block = function(user_id) {
    console.log('block user: ' + user_id);
    favsServices.block_user(user_id).then(function(response){
      console.log('user blocked');
    });
  }

  $scope.unblock = function(user_id) {
    console.log('unblock user: ' + user_id);
    favsServices.unblock_user(user_id).then(function(response){
      console.log('user unblocked');
    });
  }
}]);

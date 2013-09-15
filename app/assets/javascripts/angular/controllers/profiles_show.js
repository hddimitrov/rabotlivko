angular.module('rab').controller('profiles_show', ['$scope', 'rabServices', 'favoriteServices', function($scope, rabServices, favoriteServices) {

  $scope.set_active_tab = function(tab) {
    $scope.active_tab = tab;
  }

  $scope.fav = function(user_id) {
    console.log('fav user: ' + user_id);
    favoriteServices.fav_user(user_id).then(function(response){
      console.log('user faved');
      $scope.favorited = true;
    });
  }

  $scope.unfav = function(user_id) {
    console.log('unfav user: ' + user_id);
    favoriteServices.unfav_user(user_id).then(function(response){
      console.log('user unfaved');
      $scope.favorited = false;
    });
  }

  $scope.block = function(user_id) {
    console.log('block user: ' + user_id);
    favoriteServices.block_user(user_id).then(function(response){
      console.log('user blocked');
      $scope.blocked = true;
    });
  }

  $scope.unblock = function(user_id) {
    console.log('unblock user: ' + user_id);
    favoriteServices.unblock_user(user_id).then(function(response){
      console.log('user unblocked');
      $scope.blocked = false;
    });
  }
}]);

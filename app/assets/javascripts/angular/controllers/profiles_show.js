angular.module('rab').controller('profiles_show', ['$scope', 'rabServices', 'favoriteServices', function($scope, rabServices, favoriteServices) {

  angular.extend($scope, {
    center: {
      latitude: 42.73, // initial map center latitude
      longitude: 25.56, // initial map center longitude
    },
    markers: [], // an array of markers,
    zoom: 7 // the zoom level
  });

  $scope.contractor = {};
  $scope.states = [];
  $scope.cities_by_state = {};
  $scope.cities = [];

  $scope.state_changed = function(state_id) {
    console.log(state_id);
    state = rabServices.findByProperty($scope.states, 'state_id', state_id);
    if(state) {
      $scope.center.latitude = state['lat'];
      $scope.center.longitude = state['lon'];
      $scope.zoom = 8;
      $scope.markers = [$scope.center];
    }

    $scope.cities = $scope.cities_by_state[state_id];
    console.log($scope.cities);
  }

  $scope.city_changed = function(city_id) {
    city = rabServices.findByProperty($scope.cities, 'city_id', city_id);
    console.log(city_id)
    console.log(city);
    if(city) {
      $scope.center.latitude = city['lat'];
      $scope.center.longitude = city['lon'];
      $scope.zoom = 14;
      $scope.markers = [$scope.center];
    }
  }

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

angular.module('rab').controller('profiles_show', ['$scope', 'rabServices', 'favsServices', function($scope, rabServices, favsServices) {
  console.log('profiles_show called');

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

  $scope.$watch(
    function () {
      return $('#locations-data').data('states');
    },
    function(newJson) {
      $scope.states = newJson;
    },
    true
  );

  $scope.$watch(
    function () {
      return $('#locations-data').data('cities');
    },
    function(newJson) {
      $scope.cities_by_state = newJson;
    },
    true
  );

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

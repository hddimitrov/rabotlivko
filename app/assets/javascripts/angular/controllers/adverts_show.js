angular.module('rab').controller('adverts_show', ['$scope', 'rabServices', 'favoriteServices', function($scope, rabServices, favoriteServices) {

  angular.extend($scope, {
    center: {
      latitude: 42.73, // initial map center latitude
      longitude: 25.56, // initial map center longitude
    },
    markers: [], // an array of markers,
    zoom: 7 // the zoom level
  });

  $scope.advert = {};
  $scope.states = [];
  $scope.cities_by_state = {};
  $scope.cities = [];
  $scope.adverts = [];

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

  $scope.$watch(
    function () {
      return $('#js-data').data('adverts');
    },
    function(newJson) {
      console.log(newJson);
      $scope.adverts = newJson;
    },
    true
  );

  $scope.add_filter = function(type, value) {
    rabServices.filter_adverts(value).then(function(response){
      $scope.adverts = response;
    });
  }

  $scope.state_changed = function(state_id) {
    state = rabServices.findById($scope.states, state_id);
    if(state) {
      $scope.center.latitude = state['lat'];
      $scope.center.longitude = state['lon'];
      $scope.zoom = 8;
      marker = {latitude: $scope.center.latitude, longitude: $scope.center.longitude};
      $scope.markers = [marker];
    }

    $scope.cities = $scope.cities_by_state[state_id];
  }

  $scope.city_changed = function(city_id) {
    city = rabServices.findById($scope.cities, city_id);
    if(city) {
      $scope.center.latitude = city['lat'];
      $scope.center.longitude = city['lon'];
      $scope.zoom = 14;
      marker = {latitude: $scope.center.latitude, longitude: $scope.center.longitude};
      $scope.markers = [marker];
    }
  }

  $scope.fav = function(advert_id) {
    console.log('fav adver: ' + advert_id);
    favoriteServices.fav_advert(advert_id).then(function(response){
      console.log('advert faved');
      $scope.favorited = true;
    });
  }

  $scope.unfav = function(advert_id) {
    console.log('unfav advert: ' + advert_id);
    favoriteServices.unfav_advert(advert_id).then(function(response){
      console.log('advert unfaved');
      $scope.favorited = false;
    });
  }
}]);

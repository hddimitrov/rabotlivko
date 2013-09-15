angular.module('rab').controller('want_ads_create',
                                ['$scope', 'rabServices',
                                function($scope, rabServices) {

  $scope.continue = function() {
    $scope.continue_clicked = true;
    if($scope.want_ad.title && $scope.want_ad.category_id && $scope.want_ad.description) {
      $scope.current_step = 2;
    }
  };

  angular.extend($scope, {
    center: {
      latitude: 42.73, // initial map center latitude
      longitude: 25.56, // initial map center longitude
    },
    markers: [], // an array of markers,
    zoom: 7 // the zoom level
  });

  $scope.states = [];
  $scope.cities_by_state = {};
  $scope.cities = [];

  $scope.state_changed = function(state_id) {
    state = rabServices.findByProperty($scope.states, 'state_id', state_id);
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
    city = rabServices.findByProperty($scope.cities, 'city_id', city_id)
    if(city) {
      $scope.center.latitude = city['lat'];
      $scope.center.longitude = city['lon'];
      $scope.zoom = 14;
      marker = {latitude: $scope.center.latitude, longitude: $scope.center.longitude};
      $scope.markers = [marker];
    }
  }

  $scope.new_advert_cookies_save = function() {
    console.log('new_want_ad_cookies_save');
    $.cookie('rab_new_want_ad_title', $scope.want_ad.title, {path: '/'});
    $.cookie('rab_new_want_ad_category_id', $scope.want_ad.category_id + '', {path: '/'});
    $.cookie('rab_new_want_ad_description', $scope.want_ad.description, {path: '/'});
    // $.cookie('rab_new_want_ad_price_type', $scope.want_ad.price_type, {path: '/'});
    // $.cookie('rab_new_want_ad_price', $scope.want_ad.price + '', {path: '/'});
    return true;
  };

  $scope.save_draft = function() {

  };

  $scope.save = function() {
    console.log($scope.want_ad);
    console.log($scope.address);
  };
}]);

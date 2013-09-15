angular.module('rab').controller('want_ads_create',
                                ['$scope', 'rabServices', 'creationServices',
                                function($scope, rabServices, creationServices) {


  $scope.files = [];

  //listen for the file selected event
  $scope.$on('fileSelected', function (event, args) {
    console.log('file Selected');
    $scope.$apply(function () {
      //add the file object to the scope's files collection
      $scope.files.push(args.file);
    });
  });

  $scope.$watch('want_ad.price_negotiable', function() {
    if($scope.want_ad.price_negotiable){
      $scope.want_ad.price = '';
    }
  });

  $scope.set_deadline = function(two_weeks) {
    if(two_weeks) {
      date = moment().add('days', 14);
      $scope.want_ad.deadline = date.format('DD.MM.YYYY');
      $("#deadline-input").datepicker('setDate', date.toDate());
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

  $scope.continue = function() {
    $scope.continue_clicked = true;
    if($scope.want_ad.title && $scope.want_ad.category_id && $scope.want_ad.description) {
      $scope.current_step = 2;
      $scope.continue_clicked = false;
    }
    return false;
  };

  $scope.create = function(draft) {
    $scope.continue_clicked = true;
    $scope.want_ad.q_draft = draft;
    $scope.want_ad.address = $scope.address;
    if(($scope.want_ad.price_negotiable || $scope.want_ad.price) && $scope.want_ad.deadline) {
      // creationServices.create_want_ad($scope.want_ad, $scope.files);
      document.want_ad_form.submit();
    } else {
      return false;
    }
  };
}]);

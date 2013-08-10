angular.module('rab', ['ngCookies', 'rab.directives'])

angular.module('rab').config(['$locationProvider', function(lProvider) {
  lProvider.html5Mode(false);
}]);

angular.module('rab').config(['$httpProvider', function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

angular.module('rab').controller('AdvertsCtrl', ['$scope', '$cookies', function($scope, $cookies) {
  $scope.msg = 'hello world';
  $scope.store_add = function() {
    $cookies.rab_new_ad_title               = $scope.add.title;
    $cookies.rab_new_ad_description         = $scope.add.description;
    $cookies.rab_new_ad_category_id         = $scope.add.category_id + '';
    $cookies.rab_new_ad_price               = $scope.add.price + '';

    $window.location.href = '/auth/facebook?origin=/r';
  };
}]);

angular.module('rab').controller('AdvertsCtrl', ['$scope', '$cookies', function($scope, $cookies) {
  $scope.advert = {};
  $scope.store_new_advert = function() {
    $cookies.rab_new_advert_title               = $scope.advert.title;
    $cookies.rab_new_advert_description         = $scope.advert.description;
    $cookies.rab_new_advert_category_id         = $scope.advert.category_id + '';
    $cookies.rab_new_advert_price               = $scope.advert.price + '';
    return true;
  };
}]);

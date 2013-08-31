angular.module('rab').controller('WantAdsCtrl', ['$scope', 'favsServices', 'filterServices', function($scope, favsServices, filterServices) {
  $scope.filters = {};

  filterServices.filter_want_ads($scope.filters).then(function(response) {
    $scope.want_ads = response;
    console.log($scope.want_ads);
  });

  $scope.fav = function(want_ad_id) {
    console.log('fav want_ad: ' + want_ad_id);
    favsServices.fav_want_ad(want_ad_id).then(function(response){
      console.log('want_ad faved');
    });
  };

  $scope.unfav = function(want_ad_id) {
    console.log('unfav want_ad: ' + want_ad_id);
    favsServices.unfav_want_ad(want_ad_id).then(function(response){
      console.log('want_ad unfaved');
    });
  };

  $scope.filter_want_ads = function() {
    filterServices.filter_want_ads($scope.filters).then(function(response){
      $scope.want_ads = response;
      console.log($scope.want_ads);
    });
  };

  $scope.click_category = function(category_id) {
    $scope.filters.category_id = category_id;
    $scope.filter_want_ads();
  };

  $scope.click_all = function() {
    $scope.filters.category_id = '';
    $scope.filter_want_ads();
  }
}]);

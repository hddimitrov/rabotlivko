angular.module('rab').controller('WantAdsCtrl', ['$scope', 'favsServices', 'filterServices', function($scope, favsServices, filterServices) {
  $scope.filters = {};

  filterServices.filter_want_ads($scope.filters).then(function(response) {
    $scope.want_ads = response.want_ads;
    $scope.number_pages = response.number_pages;
    $scope.current_page = response.current_page;
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
      $scope.want_ads = response.want_ads;
      $scope.number_pages = response.number_pages;
      $scope.current_page = response.current_page;
    });
  };

  $scope.page_changed = function(page) {
    $scope.filters.page = page;
    $scope.filter_want_ads();
  }
}]);

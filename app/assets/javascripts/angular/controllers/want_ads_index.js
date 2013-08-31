angular.module('rab').controller('want_ads_index', ['$scope', 'filterServices', function($scope, filterServices) {
  $scope.filters = {};

  filterServices.filter_want_ads($scope.filters).then(function(response) {
    $scope.want_ads = response.want_ads;
    $scope.number_pages = response.number_pages;
    $scope.current_page = response.current_page;
  });

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
  };
}]);

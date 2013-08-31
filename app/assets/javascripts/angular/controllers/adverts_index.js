angular.module('rab').controller('adverts_index', ['$scope', 'filterServices', function($scope, filterServices) {
  $scope.filters = {};

  filterServices.filter_adverts($scope.filters).then(function(response) {
    $scope.want_ads = response.want_ads;
    $scope.number_pages = response.number_pages;
    $scope.current_page = response.current_page;
  });

  $scope.filter_adverts = function() {
    filterServices.filter_adverts($scope.filters).then(function(response){
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

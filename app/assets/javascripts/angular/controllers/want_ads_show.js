angular.module('rab').controller('want_ads_show', ['$scope', 'favServices', function($scope, favServices) {
  $scope.applicant_status;

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

  $scope.apply = function() {
    console.log('apply submit');
  };

  $scope.resign = function() {
    console.log('resign submit');
  };
}]);

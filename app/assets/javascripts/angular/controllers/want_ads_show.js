angular.module('rab').controller('want_ads_show', ['$scope', 'favoriteServices', function($scope, favoriteServices) {

  $scope.applicant_status = '';

  $scope.$watch(
    function () {
      return $('#applicant-status').val();
    },
    function(newJson) {
      console.log('newJson');
      console.log(newJson);
      $scope.applicant_status = newJson;
    },
    true
  );

  $scope.fav = function(want_ad_id) {
    console.log('fav want_ad: ' + want_ad_id);
    favoriteServices.fav_want_ad(want_ad_id).then(function(response){
      console.log('want_ad faved');
    });
  };

  $scope.unfav = function(want_ad_id) {
    console.log('unfav want_ad: ' + want_ad_id);
    favoriteServices.unfav_want_ad(want_ad_id).then(function(response){
      console.log('want_ad unfaved');
    });
  };

  $scope.set_applicant_status = function(status) {
    $scope.applicant_status = status;
  };
}]);

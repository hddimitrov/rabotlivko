angular.module('rab').controller('WantAdsCtrl', ['$scope', 'favsServices', function($scope, favsServices) {
  $scope.fav = function(want_ad_id) {
    console.log('fav want_ad: ' + want_ad_id);
    favsServices.fav_want_ad(want_ad_id).then(function(response){
      console.log('want_ad faved');
    });
  }

  $scope.unfav = function(want_ad_id) {
    console.log('unfav want_ad: ' + want_ad_id);
    favsServices.unfav_want_ad(want_ad_id).then(function(response){
      console.log('want_ad unfaved');
    });
  }
}]);

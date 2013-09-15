angular.module('rab').controller('adverts_show', ['$scope', 'rabServices', 'favoriteServices', function($scope, rabServices, favoriteServices) {

  angular.extend($scope, {
    center: {
      latitude: 42.73, // initial map center latitude
      longitude: 25.56, // initial map center longitude
    },
    markers: [], // an array of markers,
    zoom: 7 // the zoom level
  });

  $scope.advert = {};

  $scope.fav = function(advert_id) {
    console.log('fav adver: ' + advert_id);
    favoriteServices.fav_advert(advert_id).then(function(response){
      console.log('advert faved');
      $scope.favorited = true;
    });
  }

  $scope.unfav = function(advert_id) {
    console.log('unfav advert: ' + advert_id);
    favoriteServices.unfav_advert(advert_id).then(function(response){
      console.log('advert unfaved');
      $scope.favorited = false;
    });
  }
}]);

angular.module('rab').controller('AdvertsCtrl', ['$scope', 'favsServices', function($scope, favsServices) {
  $scope.advert = {};
  $scope.new_advert_cookies_save = function() {
    console.log('new_advert_cookies_save')
    $.cookie('rab_new_advert_category_id', $scope.advert.category_id + '', {path: '/'});
    $.cookie('rab_new_advert_title', $scope.advert.title, {path: '/'});
    $.cookie('rab_new_advert_description', $scope.advert.description, {path: '/'});
    $.cookie('rab_new_advert_price_type', $scope.advert.price_type, {path: '/'});
    $.cookie('rab_new_advert_price', $scope.advert.price + '', {path: '/'});
    return true;
  };

  $scope.fav = function(advert_id) {
    console.log('fav adver: ' + advert_id);
    favsServices.fav_advert(advert_id).then(function(response){
      console.log('advert faved');
    });
  }

  $scope.unfav = function(advert_id) {
    console.log('unfav advert: ' + advert_id);
    favsServices.unfav_advert(advert_id).then(function(response){
      console.log('advert unfaved');
    });
  }
}]);

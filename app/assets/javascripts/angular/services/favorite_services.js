var favorite_services = {};
var favorite_services = angular.module('favorite_services', []);

favorite_services.factory('favsServices', ['$http', function($http) {
  var favsServices = {
    fav_advert: function(advert_id) {
      var promise = $http.post('/api/advert/fav', {advert_id: advert_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    unfav_advert: function(advert_id) {
      var promise = $http.post('/api/advert/unfav', {advert_id: advert_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    fav_want_ad: function(want_ad_id) {
      var promise = $http.post('/api/want_ad/fav', {want_ad_id: want_ad_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    unfav_want_ad: function(want_ad_id) {
      var promise = $http.post('/api/want_ad/unfav', {want_ad_id: want_ad_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    fav_user: function(user_id) {
      var promise = $http.post('/api/user/fav', {user_id: user_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    unfav_user: function(user_id) {
      var promise = $http.post('/api/user/unfav', {user_id: user_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    block_user: function(user_id) {
      var promise = $http.post('/api/user/block', {user_id: user_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    unblock_user: function(user_id) {
      var promise = $http.post('/api/user/unblock', {user_id: user_id}).then(function (response) {
        return response.data;
      });

      return promise;
    }
  }

  return favsServices;
}]);

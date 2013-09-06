var filter_services = {};
var filter_services = angular.module('filter_services', []);

filter_services.factory('filterServices', ['$http', function($http) {
  var filterServices = {
    filter_want_ads: function(parameters) {
      console.log(parameters);
      var promise = $http.post('/api/filter/want_ads', parameters).then(function (response) {
        return response.data;
      });

      return promise;
    },

    filter_adverts: function(parameters) {
      console.log(parameters);
      var promise = $http.post('/api/filter/adverts', parameters).then(function (response) {
        return response.data;
      });

      return promise;
    }
  };

  return filterServices;
}]);

var rab_services = {};
var rab_services = angular.module('rab.services', []);

rab_services.factory('rabServices', ['$http', function($http) {
  var rabServices = {
    findById: function(array, id) {
      for (var i = 0, len = array.length; i < len; i++) {
          if (array[i]['id'] === id) {
              return array[i]; // Return as soon as the object is found
          }
      }
      return null; // The object was not found
    },
    filter_adverts: function(category_id) {
      var promise = $http.post('/api/filter/adverts', {category_id: category_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },
  }
  return rabServices;
}]);

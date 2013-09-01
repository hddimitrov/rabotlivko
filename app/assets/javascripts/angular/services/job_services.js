var job_services = {};
var job_services = angular.module('job_services', []);

job_services.factory('jobServices', ['$http', '$location', function($http, $location) {
  var jobServices = {
    get_applications: function() {
      var promise = $http.post($location.absUrl() + '/get_applications').then(function (response) {
        return response.data;
      });

      return promise;
    }
  }

  return jobServices;
}]);

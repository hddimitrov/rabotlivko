var job_services = {};
var job_services = angular.module('job_services', []);

job_services.factory('jobServices', ['$http', function($http) {
  var jobServices = {
    want_ad_apply: function(want_ad_id) {
      var promise = $http.post('/api/want_ad/apply', {want_ad_id: want_ad_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },

    want_ad_resign: function(want_ad_id) {
      var promise = $http.post('/api/want_ad/resign', {want_ad_id: want_ad_id}).then(function (response) {
        return response.data;
      });

      return promise;
    },

    want_ad_applicant_ready: function(want_ad_id) {
      var promise = $http.post('/api/want_ad/applicant_ready', {want_ad_id: want_ad_id}).then(function (response) {
        return response.data;
      });

      return promise;
    }
  }

  return favsServices;
}]);

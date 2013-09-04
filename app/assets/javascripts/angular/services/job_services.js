var job_services = {};
var job_services = angular.module('job_services', []);

job_services.factory('jobServices', ['$http', '$location', function($http, $location) {
  var jobServices = {
    applicant_manage_want_ad_job: function(want_ad_id, status) {
      var promise = $http.post('/api/job/applicant_manage_want_ad_job', {want_ad_id: want_ad_id, status: status}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    applicant_manage_advert_job: function(advert_id, status) {
      var promise = $http.post('/api/job/applicant_manage_advert_job', {advert_id: advert_id, status: status}).then(function (response) {
        return response.data;
      });

      return promise;
    },
    owner_manage_job: function(application_id, status) {
      var promise = $http.post('/api/job/owner_manage_job', {application_id: application_id, status: status}).then(function (response) {
        return response.data;
      });

      return promise;
    }
  }

  return jobServices;
}]);

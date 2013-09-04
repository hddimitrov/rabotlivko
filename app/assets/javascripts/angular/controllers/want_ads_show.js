angular.module('rab').controller('want_ads_show',
                                ['$scope', 'rabServices', 'favoriteServices','jobServices',
                                function($scope, rabServices, favoriteServices, jobServices) {


  $scope.init = function(want_ad_id, owner_properties, candidate_properties) {
    $scope.want_ad_id = want_ad_id;
    $scope.candidate_properties = candidate_properties;
  }

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

  $scope.applicant_manage_want_ad_job = function(status) {
    jobServices.applicant_manage_want_ad_job($scope.want_ad_id, status).then(function(response){
      $scope.candidate_properties.applicant_status = status;
    });
  };

  $scope.owner_manage_job = function(application, status) {
    jobServices.owner_manage_job(application.app_id, status).then(function(response){
      application.owner_status = status;
    });
  };
}]);

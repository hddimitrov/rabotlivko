angular.module('rab').controller('want_ads_show',
                                ['$scope', 'rabServices', 'favoriteServices','jobServices',
                                function($scope, rabServices, favoriteServices, jobServices) {

  $scope.applicant_status = '';
  $scope.applications = [];

  $scope.$watch(
    function () {
      return $('#applicant-status').val();
    },
    function(newJson) {
      $scope.applicant_status = newJson;
    },
    true
  );

  jobServices.get_applications().then(function(response){
    $scope.applications = response;
  });

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

  $scope.set_applicant_status = function(status) {
    $scope.applicant_status = status;
  };

  $scope.set_owner_status = function(app_id, status) {
    console.log('changing status');
    app = rabServices.findByProperty($scope.applications, 'app_id', app_id);
    app.owner_status = status;
    console.log(app);
  };
}]);

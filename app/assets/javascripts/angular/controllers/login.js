angular.module('rab').controller('login', ['$scope', 'loginServices', function($scope, loginServices) {

  $scope.signin = function(user) {
    $scope.authError = null;

    loginServices.signin(user.email, user.password).then(
      function(response) {
        console.log("Success");
      },
      function(response) {
        console.log("Error");
        $scope.authError = response.data.error;
    });
  };

  $scope.signout = function(user) {

  };

  $scope.signup = function(user) {
    $scope.authError = null;

    loginServices.signup(user.name, user.email, user.password, user.confirm_password).then(
    function(response) {
      if(response) {
        if(response.data.success) {
          $scope.registered = true;
        }
      }
    });
  };
}]);

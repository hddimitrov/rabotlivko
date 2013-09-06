var login_services = {};
var login_services = angular.module('login_services', []);

login_services.factory('loginServices', ['$http', '$window', function($http, $window) {
  // Redirect to the given url (defaults to '/')
  function redirect(url) {
    url = url || '/';
    $window.location.href = url;
  }
  var loginServices = {

    signup: function(name, email, password, confirm_password) {
      return $http.post('/sign_up', {user: {name: name, email: email,
                                            password: password, password_confirmation: confirm_password} })
      .then(
        function(response) {
          loginServices.currentUser = null;
          return response;
        }
      );
    },

    signin: function(email, password) {
      return $http.post('/sign_in', {user: {email: email, password: password} }).then(
        function(response) {
          loginServices.currentUser = response.data.user;
          if (loginServices.isAuthenticated()) {
            redirect('/me');
          }
        }
        // function(response) {
        //   // if(response && response.data){
        //   //   return {error: response.data.error};
        //   // }
        //   return response;
        // }
      );
    },

    signout: function(redirectTo) {
      $http.post('/sign_out').then(function() {
        loginServices.currentUser = null;
        redirect(redirectTo);
      });
    },

    resend_confirmation: function(email) {
      return $http.post('/confirmation/new', {user: {email: email}}).then(
        function(response) {
          if (loginServices.isAuthenticated()) {
            redirect('/me');
          }
        }
        // function(response) {
        //   // if(response && response.data){
        //   //   return {error: response.data.error};
        //   // }
        //   return response;
        // }
      );
    },

    currentUser: null,

    isAuthenticated: function(){
      return !!loginServices.currentUser;
    }
  };
  return loginServices;
}]);

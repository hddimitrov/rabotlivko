angular.module('adverts', ['ngCookies', 'rabotlivko.directives'])

angular.module('adverts').config(['$locationProvider', function(lProvider) {
  lProvider.html5Mode(false);
}]);

angular.module('adverts').config(['$httpProvider', function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

angular.module('adverts').controller('AdvertsCtrl', ['$scope', function($scope) {
  $scope.msg = "hello world";
}]);

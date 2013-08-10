angular.module('rab', ['ngCookies', 'ui.bootstrap', 'rab.directives'])

angular.module('rab').config(['$locationProvider', function(lProvider) {
  lProvider.html5Mode(false);
}]);

angular.module('rab').config(['$httpProvider', function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

angular.module('rab', ['ui.bootstrap', 'rab.directives', 'favorite_services'])

angular.module('rab').config(['$locationProvider', function(lProvider) {
  lProvider.html5Mode(false);
}]);

angular.module('rab').config(['$httpProvider', function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

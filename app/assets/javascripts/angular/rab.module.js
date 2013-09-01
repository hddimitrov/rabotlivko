angular.module('rab', ['ui.bootstrap', 'google-maps', 'rab.directives', 'rab.services', 'favorite_services', 'filter_services', 'job_services'])

angular.module('rab').config(['$locationProvider', function(lProvider) {
  lProvider.html5Mode(false);
}]);

angular.module('rab').config(['$httpProvider', function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

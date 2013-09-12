  angular.module('rab.directives', []);

angular.module('rab.directives').directive('chosen', function() {
  var linker = function(scope, element, attributes) {
    scope.$watch(attributes.values, function() {
      element.trigger('liszt:updated');
    });

    element.chosen();
  }

  return {
    restrict: 'A',
    link: linker
  };
});

angular.module('rab.directives').directive('geocomplete', function ($log, $timeout, $compile, $controller) {
  return {
    restrict: 'A',
    scope:{
      location:'=geocomplete',
      ngModel:'='
    },
    priority: 200,
    link: function (scope, element, attrs) {
      var autocomplete = $(element).geocomplete().bind('geocode:result', function (event, result) {
        if(result.formatted_address) {
          console.log(event.target.value);
          $timeout(function() {
            scope.line = event.target.value;
          });
        }
      });
    }
  };
});

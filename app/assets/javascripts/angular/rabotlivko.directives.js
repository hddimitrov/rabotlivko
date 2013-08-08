angular.module('rabotlivko.directives', []);

angular.module('rabotlivko.directives').directive('chosen', function() {
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

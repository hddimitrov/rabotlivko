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
      markers:'=markers',
      line:'=line',
      ngModel:'='
    },
    priority: 200,
    link: function (scope, element, attrs) {
      var autocomplete = $(element).geocomplete().bind('geocode:result', function (event, result) {
        if(result.geometry && result.geometry.location) {
          var location = result.geometry.location;
          $timeout(function() {
            scope.line = event.target.value;
            latlon = {latitude: location.lat(), longitude: location.lng()};
            marker = {latitude: location.lat(), longitude: location.lng()};
            scope.location = latlon;
            scope.markers = [marker];
          });
        }
      });
    }
  };
});

angular.module('rab.directives').directive('fileUpload', function () {
    return {
        scope: true,
        link: function (scope, el, attrs) {
            el.bind('change', function (event) {
                var files = event.target.files;
                //iterate files since 'multiple' may be specified on the element
                for (var i = 0;i<files.length;i++) {
                    //emit event upward
                    scope.$emit('fileSelected', { file: files[i] });
                }
            });
        }
    };
});

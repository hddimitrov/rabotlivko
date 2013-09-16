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

// angular.module('rab.directives').directive('fileUpload', function () {
//     return {
//         scope: true,
//         link: function (scope, element, attributes) {
//             element.bind('change', function (event) {
//                 var files = event.target.files;
//                 //iterate files since 'multiple' may be specified on the element
//                 for (var i = 0;i<files.length;i++) {
//                     //emit event upward
//                     scope.$emit('fileSelected', { file: files[i] });
//                 }
//             });
//         }
//     };
// });

angular.module('rab.directives').directive('fileUploadButton', function () {
    return {
        scope: true,
        link: function (scope, element, attributes) {
            var button = el.children()[0]

            element.css({
              position: 'relative',
              overflow: 'hidden',
              width: button.offsetWidth,
              height: button.offsetHeight
            })

            var fileInput = angular.element('<input type="file" multiple="multiple" name="want_ad[attachments_attributes][][file]"/>');
            fileInput.css({
              position: 'absolute',
              top: 0,
              left: 0,
              'z-index': '2',
              width: '100%',
              height: '100%',
              opacity: '0',
              cursor: 'pointer'
            });

            fileInput.bind('change', function (event) {
                var files = event.target.files;
                //iterate files since 'multiple' may be specified on the element
                for (var i = 0;i<files.length;i++) {
                    //emit event upward
                    scope.$emit('fileSelected', { file: files[i] });
                }
            });

            element.append(fileInput)
        }
    };
});


var creation_services = {};
var creation_services = angular.module('creation_services', []);

creation_services.factory('creationServices', ['$http', function($http) {
  var creationServices = {
    create_want_ad: function(want_ad) {
      var promise = $http.post('/api/want_ad/create', {want_ad: want_ad}).then(function (response) {
        return response.data;
      });
      return promise;
    }
  }
  return creationServices;
}]);



    // create_want_ad: function(want_ad, files) {
    //   console.log(want_ad);
    //   console.log(files);
    //   $http({
    //     method: 'POST',
    //     url: '/api/want_ad/create',
    //     //IMPORTANT!!! You might think this should be set to 'multipart/form-data'
    //     // but this is not true because when we are sending up files the request
    //     // needs to include a 'boundary' parameter which identifies the boundary
    //     // name between parts in this multi-part request and setting the Content-type
    //     // manually will not set this boundary parameter. For whatever reason,
    //     // setting the Content-type to 'false' will force the request to automatically
    //     // populate the headers properly including the boundary parameter.
    //     headers: { 'Content-Type': false },
    //     //This method will allow us to change how the data is sent up to the server
    //     // for which we'll need to encapsulate the model data in 'FormData'
    //     transformRequest: function (data) {
    //         console.log(data);
    //         var formData = new FormData();
    //         //need to convert our json object to a string version of json otherwise
    //         // the browser will do a 'toString()' on the object which will result
    //         // in the value '[Object object]' on the server.
    //         formData.append("want_ad", angular.toJson(data.want_ad));
    //         //now add all of the assigned files
    //         for (var i = 0; i < data.files; i++) {
    //             //add each file to the form data and iteratively name them
    //             formData.append("file" + i, data.files[i]);
    //         }
    //         return formData;
    //     },
    //     //Create an object that contains the model and files which will be transformed
    //     // in the above transformRequest method
    //     data: { want_ad: want_ad, files: files }
    //   }).
    //   success(function (data, status, headers, config) {
    //       alert("success!");
    //   }).
    //   error(function (data, status, headers, config) {
    //       alert("failed!");
    //   });
    // }

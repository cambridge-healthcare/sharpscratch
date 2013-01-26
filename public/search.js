angular.module('SharpScratch', ['ngResource']);

function Search ($scope, $resource) {
  $scope.search = true;
  var searcher = $resource('/search/:term.json');

  $scope.search = function () {
    searcher.query({ term: $scope.term }, function (results) {
      $scope.results = results;
    });
  };
}

function Search ($scope, $resource) {
  $scope.search = true;
  var searcher = $resource('/search/:term.json');

  $scope.search = function () {
    $scope.status  = 'querying';
    $scope.results = null;
    searcher.query({ term: $scope.term }, function (results) {
      $scope.status  = 'got_reply';
      $scope.results = results;
    });
  };

  var new_procedure = $resource('/procedures.json');

  $scope.create = function () {
    new_procedure.save({ title: term }, function () {
      console.log(arguments);
    });
  };
}

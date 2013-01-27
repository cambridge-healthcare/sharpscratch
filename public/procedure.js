function Procedure ($scope, $resource, $routeParams) {
  var getter = $resource('/procedures/:id.json');

  getter.get({
    id: $routeParams.id
  }, function success (data) {
    _.extend($scope, data);
  }, function error (data) {
    $scope.message = "Can't retrieve a procedure with a given identificator.";
    $scope.message_class = "error";
  });
}

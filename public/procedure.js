function Procedure ($scope, $resource, $routeParams) {
  var getter       = $resource('/procedures/:id.json');
  var steps_getter = $resource('/procedures/:id/steps.json');

  $scope.marked = marked;

  $scope.scroll = function (id) {
    var element = document.getElementById(id);
    window.scrollTo(0, element.offsetTop);
  };

  getter.get($routeParams, function success (data) {
    _.extend($scope, data);
  }, function error (data) {
    $scope.message = "Can't retrieve a procedure with a given identificator.";
    $scope.message_class = "error";
  });

  steps_getter.query($routeParams, function success (data) {
    console.log(data);
    $scope.steps = data;
  }, function error (data) {
    $scope.message = "Can't steps for a given identificator.";
    $scope.message_class = "error";
  });
}

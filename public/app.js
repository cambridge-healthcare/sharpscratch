angular.module('SharpScratch', ['ngResource'])
.config(['$routeProvider', function($routeProvider) {
  $routeProvider
  .when('/search',    { templateUrl: 'search.html' })
  .when('/procedure', { templateUrl: 'procedure.html' })
  .when('/new_procedure/:title', { templateUrl: 'new_procedure.html'})
  .otherwise({ redirectTo: '/search' });
}]);

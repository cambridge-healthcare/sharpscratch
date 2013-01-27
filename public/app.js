angular.module('SharpScratch', ['ngResource'])
.config(['$routeProvider', function($routeProvider) {
  $routeProvider
  .when('/search',    { templateUrl: 'search.html' })
  .when('/procedure', { templateUrl: 'procedure.html' })
  .otherwise({ redirectTo: '/search' });
}]);

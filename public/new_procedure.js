function NewProcedure ($scope, $resource, $routeParams) {
  $scope.steps         = [''];
  $scope.complications = [];

  $scope.title = $routeParams.title;

  $scope.inc = function (list) {
    list.push('');
  };

  function get_values (title_class, text_class) {
    var things = [];

    var titles = document.querySelectorAll(title_class);
    var texts = document.querySelectorAll(text_class);

    for (var i = 0; i < titles.length; ++i) {
      things.push({
        title: titles[i].value,
        text:  texts[i].value
      });
    }

    return things;
  }

  var saver = $resource('/procedures.json');

  $scope.save = function () {
    var steps = get_values('.step_title', '.step_text');
    var complications = get_values('.complication_title',
      '.complication_text');

    saver.save({
      title: $scope.title
    }, function () {
      console.log(arguments);
    });
  };
}

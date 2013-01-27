function NewProcedure ($scope, $resource, $routeParams) {
  $scope.steps         = [''];
  $scope.complications = [];

  $scope.title = $routeParams.title;

  $scope.inc = function (list) {
    list.push('');
  };

  function get_values (fields) {
    var pairs = _.pairs(fields);
    var names = _.pluck(pairs, 0);
    var values = pairs.map(function (pair) {
      var name     = pair[0];
      var selector = pair[1];
      var elements = document.querySelectorAll(selector);
      return _.pluck(elements, 'value');
    });

    return _.zip.apply(_, values).map(function (value) {
      var result = {};
      value.map(function (value, i) {
        result[names[i]] = value;
      });
      return result;
    });
  }

  var saver      = $resource('/procedures.json');
  var step_saver = $resource('/steps.json');

  function save_steps (proc_id, steps) {
    console.log(steps);
    if (!steps.length) {
      location.hash = '#/procedure/' + proc_id;
      return;
    }

    var step = steps.shift();
    $scope.message = 'Saving step: ' + step.title;

    _.extend(step, { procedure_id: proc_id });
    step_saver.save(step, function success () {
      save_steps(proc_id, steps);
    }, function error () {
      $scope.message = 'Error saving step: ' + step.title;
      $scope.message_class = 'error';
    });
  }

  $scope.save = function () {
    $scope.message = "Submitting...";
    $scope.message_class = '';
    var steps = get_values({
      title:  '.step_title',
      to_do:  '.step_to_do',
      to_say: '.step_to_say'
    });

    saver.save({
      title:       $scope.title,
      consent:     $scope.consent,
      materials:   $scope.materials,
      precautions: $scope.precautions
    }, function success (answer) {
      $scope.message = "Saved procedure.";
      save_steps(answer.id, steps);
    }, function error () {
      $scope.message_class = 'error';
      $scope.message = "Coudn't submit your procedure. Try a different title.";
    });
  };
}

angular.module('SharpScratch', []);

function Procedure ($scope) {
  $scope.show = false;

  $scope.title = "Lumbar Puncture";

  $scope.consents = [{
    id: 1,
    text: 'qwer',
    points: 121
  }, {
    id: 2,
    text: 'asdf',
    points: 123
  }, {
    id: 3,
    text: 'zxcv',
    points: 567
  }];

  $scope.materials = [{
    id: 4,
    text: 'qwer',
    points: 121
  }, {
    id: 5,
    text: 'asdf',
    points: 123
  }, {
    id: 6,
    text: 'zxcv',
    points: 567
  }];

  $scope.steps = [{
    id: 11,
    title: 'Zzxcv qwerw asdf',
    variants: [{
      id: 7,
      points: 890,
      text: 'yui',
      say: 'zxcv'
    }, {
      id: 8,
      points: 1223,
      text: 'nmm',
      say: 'asf afasfs dfa as'
    }]
  }, {
    id: 12,
    title: 'asdfasdf',
    variants: [{
      id: 9,
      points: 890,
      text: 'yui',
      say: 'zxcv'
    }, {
      id: 10,
      points: 1223,
      text: 'nmm',
      say: 'zxcv'
    }]
  }];

  $scope.complications = [{}];

  $scope.all_steps = [].concat($scope.consents, $scope.materials, $scope.steps);

  function sort_variants (step) {
    step.variants = _.sortBy(step.variants, 'points');
    step.active   = step.variants[0];
    step.active   = "active";
  }

  $scope.steps.forEach(sort_variants);
}

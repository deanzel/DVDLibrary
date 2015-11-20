app.controller('MovieController', function($scope) {
    $scope.ratingClick = function(starValue) {
        console.log('You clicked rating: ' + starValue);
        $scope.movieRating = starValue;
    };
});
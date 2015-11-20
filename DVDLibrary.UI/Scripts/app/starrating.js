var app = angular.module("StarRating", []);

app.directive('ngStarRating', function () {
    return {
        restrict: 'EA',     // element or attribute
        templateUrl: '/Content/app/templates/starRating.html',      // what to display
        scope: {
            rating: '=rating',      // two-way binding
            hoverValue: '=hover',   // two-way binding
            label: '@',             // attribute
            maxRating: '@',         // attribute
            click: '&',             // function
            mouseHover: '&',        // function
            mouseLeave: '&'         // function
        },
        compile: function (element, attrs) {
            if (!attrs.maxRating || (Number(attrs.maxRating) <= 0)) {
                attrs.maxRating = '5';
            };

            if (!attrs.label) {
                attrs.label = 'Rating';
            };
        },
        controller: function ($scope, $element, $attrs) {
            $scope.maxRatings = [];
            $scope.rating = $scope._rating = 0;

            $scope.hoverValue = 0;

            for (var i = 0; i < $scope.maxRating; i++) {
                $scope.maxRatings.push({});
            };

            $scope.getStarPath = function (index) {
                if (($scope.hoverValue + $scope._rating) <= index) {
                    return "/Content/app/images/star-empty-24.png";
                }

                return "/Content/app/images/star-full-24.png";
            };

            $scope.starClick = function (starValue) {
                $scope.rating = $scope._rating = starValue;
                $scope.hoverValue = 0;
                $scope.click({ starValue: starValue });     // sending info to the parent
                $('#hiddenRating').val($scope._rating);
            };

            $scope.starMouseHover = function (starValue) {
                $scope._rating = 0;
                $scope.hoverValue = starValue;
                $scope.mouseHover({
                    starValue: starValue
                });
            };

            $scope.starMouseLeave = function (starValue) {
                $scope._rating = $scope.rating;
                $scope.hoverValue = 0;
                $scope.mouseLeave({
                    starValue: starValue
                });
            };

            $scope.getRating = function () {
                if ($scope.hoverValue != 0) {
                    return $attrs.label + ": " + $scope.hoverValue;
                }

                return $attrs.label + ": " + $scope.rating;
            };
        }
    };
});
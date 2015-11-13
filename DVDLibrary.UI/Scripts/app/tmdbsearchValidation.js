$(document).ready(function () {
    $('#searchForm').validate({
        rules: {
            movieSearchString: {
                required: true
            }
        },

        messages: {
            movieSearchString: "Please enter a movie title to search..."
        }
    });
});
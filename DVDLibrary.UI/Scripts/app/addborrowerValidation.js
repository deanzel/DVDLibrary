$(document).ready(function () {
    $('#addborrowerform').validate({
        rules: {
            FirstName: {
                required: true
            },
            LastName: {
                required: true
            },
            IsOwner: {
                required: true
            },
            Email: {
                required: true,
                email: true
            },
            Phone: {
                required: true
            },
            Address: {
                required: true
            },
            City: {
                required: true
            },
            State: {
                required: true
            },
            Zipcode: {
                required: true
            }
        },

        messages: {
            FirstName: "Please enter your first name",
            LastName: "Please enter your last name",
            IsOwner: "Please enter if you are the owner or not",
            Email: {
                required: "Enter your email address",
                email: "That's not a correct format for an email address"
            },
            Phone: "Please enter your phone number",
            Address: "Please enter your street address",
            City: "Please enter your city",
            State: "Please enter your state",
            Zipcode: "Please enter your zipcode"
        }
    });
});
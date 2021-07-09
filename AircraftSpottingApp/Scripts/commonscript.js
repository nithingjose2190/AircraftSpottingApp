
function showToasterDefaultError() {
    showToasterMessage("Error", "<strong>Oops!</strong> Something went wrong, please try again.", "error");
}

function showToasterAjaxFailError(xhr) {
    showToasterMessage("Error", "<strong>Error</strong> " + xhr.status + " " + xhr.statusText, "error");
}

function showToasterMessage(title, message, messageType) {
    //message types - success, error, info, warning
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "progressBar": false,
        "positionClass": "toast-top-right",
        "onclick": null,
        "showDuration": "10000",
        "hideDuration": "10000",
        "timeOut": "10000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };

    toastr[messageType](message, title);
}

function showDefaultError(element, message) {
    if (typeof element === 'undefined') {
        element = "#error";
    }
    if (typeof message === 'undefined' || message === "") {
        message = "Something went wrong. Please try again.";
    }
    let htmlString = "<i class='fa fa-warning'></i><button class=\"close\" data-dismiss=\"alert\" type=\"button\">×</button>" + message;
    $(element).show().html(htmlString);
}
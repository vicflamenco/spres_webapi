var model = {
    authenticated: ko.observable(false),
    username: ko.observable(null),
    password: ko.observable(null),
    error: ko.observable(""),
    gotError: ko.observable(false)
};

$(document).ready(function () {
    ko.applyBindings();
    setDefaultCallbacks(function (data) {
        if (data) {
            model.authenticated(true);
            sessionStorage.setItem("tokenKey", data.access_token);
        }
        model.gotError(false);
    },
    function (statusCode, statusText) {
        model.error(statusCode + " (" + statusText + ")");
        model.gotError(true);
    });
});
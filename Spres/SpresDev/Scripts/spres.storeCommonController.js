var authenticateUrl = getUrl("/authenticate");

var authenticate = function (successCallback, errorCallback) {
    sendRequest(authenticateUrl, "POST", {
        "grant_type": "password", username: model.username(), password: model.password()
    }, function (data) {
        model.authenticated(true);
        sessionStorage.username = model.username();
        setAjaxHeaders({
            Authorization: "bearer " + data.access_token
        });
        redirectToIndex();
        if (successCallback) {
            successCallback();
        }
    }, function (data) {
        model.authenticated(false);
        alert("El usuario ingresado no existe o la contraseña ingresada no coincide. Intente nuevamente.");
        if (errorCallback) {
            errorCallback();
        }
    });
};

function redirectToIndex() {
    window.location = getUrl("/Home/Index");
};
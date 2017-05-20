ej.WebApiAdaptor.prototype.beforeSend = function (dm, request, settings) {
    if (sessionStorage.getItem('tokenKey')) {
        request.setRequestHeader("Authorization", "Bearer " + sessionStorage.getItem('tokenKey'));
    }
};

ej.DatePicker.prototype.getDateValue = function () {
    return this._dateValue;
};

ej.Dialog.prototype.setContentUrl = function (url) {
    this.element.find("iframe").attr("src", url);
}

ej.WaitingPopup.showDefault = function () {
    var popup = $("#DefaultWaitingDiv").data("ejWaitingPopup");
    if (popup) {
        popup.show();
    }
};

ej.WaitingPopup.hideDefault = function () {
    var popup = $("#DefaultWaitingDiv").data("ejWaitingPopup");
    if (popup) {
        popup.hide();
    }
};

function findUserPermission(option) {

    if (sessionStorage.permissions != undefined) {
        var permissions = JSON.parse(sessionStorage.permissions);
        for (var i = 0; i < permissions.length; i++) {
            if (permissions[i].Option == option) {
                return permissions[i];
            }
        }
    }
    return null;
};

window.alert = function (text, callback) {

    sessionStorage.informationDialogText = text;

    var infoId = "informationDialog_" + (new Date()).getTime();
    var infoDiv = $("<div>").attr("id", infoId);
    $("body").append(infoDiv);
    
    var informationDialog = $("#" + infoId).ejDialog({
        callback: callback,
        enableModal: true,
        enableResize: false,
        contentType: "ajax",
        showOnInit: false,
        allowDraggable: true,
        isResponsive: true,
        actionButtons: ["close"],
        width: 500,
        close: function (args) {
            if (callback) {
                callback();
            }
            var infoDialog = this;
            setTimeout(function () {
                var element = infoDialog.element;
                infoDialog.destroy();
                setTimeout(function () {
                    $("#" + element.attr("id")).remove();
                }, 100);
            }, 100);                
        }        
    }).data("ejDialog");

    informationDialog.option({
        contentUrl: getUrl("/Home/_InformationDialog"),
        title: "Información"
    });

    informationDialog.open();

};

window.getUrl = function (url) {
    var baseUrl = localStorage.getItem("SpresAppUrl");
    if (!url || url == "/") {
        return baseUrl;
    }
    else {
        if (baseUrl.charAt(baseUrl.length - 1) != "/") {
            baseUrl += "/";
        }
        if (url.charAt(0) == "/") {
            url = url.slice(1);
        }
        return baseUrl + url;
    }
};

$(function () {

    if (sessionStorage.getItem('tokenKey')) {
        $.ajaxSetup({
            headers: { Authorization: "bearer " + sessionStorage.getItem('tokenKey') }
        });
    }

    var WaitingDiv = $("<div>").attr("id", "DefaultWaitingDiv");
    $("body").append(WaitingDiv);
    WaitingDiv.ejWaitingPopup({ showOnInit: false });
    easter_egg = new Konami(function () { alert('¡Esto no es un juego tío!') });
});

var Konami = function (callback) {
    var konami = {
        addEvent: function (obj, type, fn, ref_obj) {
            if (obj.addEventListener)
                obj.addEventListener(type, fn, false);
            else if (obj.attachEvent) {
                // IE
                obj["e" + type + fn] = fn;
                obj[type + fn] = function () {
                    obj["e" + type + fn](window.event, ref_obj);
                }
                obj.attachEvent("on" + type, obj[type + fn]);
            }
        },
        input: "",
        pattern: "38384040373937396665",
        load: function (link) {
            this.addEvent(document, "keydown", function (e, ref_obj) {
                if (ref_obj) konami = ref_obj; // IE
                konami.input += e ? e.keyCode : event.keyCode;
                if (konami.input.length > konami.pattern.length)
                    konami.input = konami.input.substr((konami.input.length - konami.pattern.length));
                if (konami.input == konami.pattern) {
                    konami.code(link);
                    konami.input = "";
                    e.preventDefault();
                    return false;
                }
            }, this);
            this.iphone.load(link);
        },
        code: function (link) {
            window.location = link
        },
        iphone: {
            start_x: 0,
            start_y: 0,
            stop_x: 0,
            stop_y: 0,
            tap: false,
            capture: false,
            orig_keys: "",
            keys: ["UP", "UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT", "TAP", "TAP"],
            code: function (link) {
                konami.code(link);
            },
            load: function (link) {
                this.orig_keys = this.keys;
                konami.addEvent(document, "touchmove", function (e) {
                    if (e.touches.length == 1 && konami.iphone.capture == true) {
                        var touch = e.touches[0];
                        konami.iphone.stop_x = touch.pageX;
                        konami.iphone.stop_y = touch.pageY;
                        konami.iphone.tap = false;
                        konami.iphone.capture = false;
                        konami.iphone.check_direction();
                    }
                });
                konami.addEvent(document, "touchend", function (evt) {
                    if (konami.iphone.tap == true) konami.iphone.check_direction(link);
                }, false);
                konami.addEvent(document, "touchstart", function (evt) {
                    konami.iphone.start_x = evt.changedTouches[0].pageX;
                    konami.iphone.start_y = evt.changedTouches[0].pageY;
                    konami.iphone.tap = true;
                    konami.iphone.capture = true;
                });
            },
            check_direction: function (link) {
                x_magnitude = Math.abs(this.start_x - this.stop_x);
                y_magnitude = Math.abs(this.start_y - this.stop_y);
                x = ((this.start_x - this.stop_x) < 0) ? "RIGHT" : "LEFT";
                y = ((this.start_y - this.stop_y) < 0) ? "DOWN" : "UP";
                result = (x_magnitude > y_magnitude) ? x : y;
                result = (this.tap == true) ? "TAP" : result;

                if (result == this.keys[0]) this.keys = this.keys.slice(1, this.keys.length);
                if (this.keys.length == 0) {
                    this.keys = this.orig_keys;
                    this.code(link);
                }
            }
        }
    }

    typeof callback === "string" && konami.load(callback);
    if (typeof callback === "function") {
        konami.code = callback;
        konami.load();
    }

    return konami;
};
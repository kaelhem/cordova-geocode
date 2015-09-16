var exec = require('cordova/exec');

exports.geocodeString = function(arg0, success, error, arg1) {
    var areBusinessFiltered = arg1 === true;
    exec(success, error, "CordovaGeocode", "geocodeString", [arg0, areBusinessFiltered]);
};
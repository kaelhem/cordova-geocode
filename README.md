cordova-geocode
======


This cordova plugin allow to retrieve long / lat coordinates from a given location string based.
It targets only iOS (for now), using MapKit framework.

The `cordova.plugins.GeoCode` object provides a unique `geocodeString` method.

When called, a JSON object is returned with the following informations :
**[{*latitude*, *longitude*, *address*}, ...]**

Note that the mapkit framework will never return more than 10 results.


Params
-------
The `geocodeString` method accepts 4 parameters.

* queryString [*String*]: location string based value
* successCallback [*Function*]: callback triggered when succeed
* errorCallback [*Function*]: callback triggered when failed
* businessFiltered [*Boolean*, optionnal]: Used to remove business from results. default: *false*



Usage sample
-------

```
var successCallback = function(items) {
	// your logic here
};
var errorCallback = function(error) {
	// your logic here
};
cordova.plugins.CordovaGeocode.geocodeString('New York', successCallback, errorCallback);
```


Supported Platforms
-------------------

- iOS
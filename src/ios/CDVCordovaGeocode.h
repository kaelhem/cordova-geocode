#import <Cordova/CDVPlugin.h>

@interface CDVCordovaGeocode : CDVPlugin

- (void)geocodeString:(CDVInvokedUrlCommand*)command;

@end
#import <Cordova/CDV.h>
#import "CDVCordovaGeocode.h"
#import <MapKit/MapKit.h>

@implementation CDVCordovaGeocode

- (NSDictionary *)locationDictionaryFromPlaceMark:(MKPlacemark *)aPlace {
    NSString *addressString = [[aPlace.addressDictionary objectForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
    
    NSDictionary *loc = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithDouble:aPlace.location.coordinate.latitude], @"latitude",
                         [NSNumber numberWithDouble:aPlace.location.coordinate.longitude ], @"longitude",
                         addressString, @"address", nil];
    return loc;
}

- (void)geocodeString:(CDVInvokedUrlCommand*)command;
{
    NSString* callbackId = command.callbackId;
    BOOL areBusinessFiltered = [command.arguments objectAtIndex:1];
    
    MKLocalSearchRequest* request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = [command.arguments objectAtIndex:0];
    request.region = MKCoordinateRegionForMapRect(MKMapRectWorld);
    
    MKLocalSearch* search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (error) {
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
            [self.commandDelegate sendPluginResult:result callbackId:callbackId];
        } else {
            NSMutableArray *locations = [NSMutableArray array];

            NSPredicate *noBusiness = [NSPredicate predicateWithFormat:@"business.uID == 0"];
            NSMutableArray *filteredItems = [response.mapItems mutableCopy];
			      if([areBusinessFiltered boolValue] == YES) {
	            [filteredItems filterUsingPredicate:noBusiness];
	          }

            MKPlacemark *place;
            NSDictionary *loc;
            for (MKMapItem *mapItem in filteredItems) //response.mapItems)
            {
                place = mapItem.placemark;
                loc = [self locationDictionaryFromPlaceMark:place];
                [locations addObject:loc];
            }
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:locations];
            [self.commandDelegate sendPluginResult:result callbackId:callbackId];
        }
    }];
}

@end

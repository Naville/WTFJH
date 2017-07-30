#import "../Global.h"
#import <CoreLocation/CoreLocation.h>
#define LogCLRegion(obj) \
					WTAdd(obj.identifier,@"identifier");\
					WTAdd([NSNumber numberWithDouble:obj.center.latitude],@"center.latitude");\
					WTAdd([NSNumber numberWithDouble:obj.center.longitude],@"center.longitude");\
					WTAdd([NSNumber numberWithDouble:obj.radius],@"radius");
typedef double CLLocationDegrees;

/*
 *  CLLocationAccuracy
 *
 *  Discussion:
 *    Type used to represent a location accuracy level in meters. The lower the value in meters, the
 *    more physically precise the location is. A negative accuracy value indicates an invalid location.
 */
typedef double CLLocationAccuracy;

/*
 *  CLLocationSpeed
 *
 *  Discussion:
 *    Type used to represent the speed in meters per second.
 */
typedef double CLLocationSpeed;

/*
 *  CLLocationDirection
 *
 *  Discussion:
 *    Type used to represent the direction in degrees from 0 to 359.9. A negative value indicates an
 *    invalid direction.
 */
typedef double CLLocationDirection;

%group CoreLocation
%hook CLLocationManager
- (void)startUpdatingLocation{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"startUpdatingLocation");
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)stopMonitoringSignificantLocationChanges{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"stopMonitoringSignificantLocationChanges");
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)startMonitoringSignificantLocationChanges{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"startMonitoringSignificantLocationChanges");
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)stopUpdatingLocation{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"stopUpdatingLocation");
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)stopUpdatingHeading{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"stopUpdatingHeading");
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)stopMonitoringForRegion:(CLRegion *)region{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"stopMonitoringForRegion:");
		LogCLRegion(region);
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)startMonitoringForRegion:(CLRegion *)region{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"startMonitoringForRegion:");
		LogCLRegion(region);
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)startUpdatingHeading{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"startUpdatingHeading");
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)requestStateForRegion:(CLRegion *)region{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"requestStateForRegion:");
		LogCLRegion(region);
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)stopRangingBeaconsInRegion:(CLBeaconRegion *)region{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"stopRangingBeaconsInRegion:");
		LogCLRegion(region);
		WTAdd(region.proximityUUID,@"proximityUUID");
		WTSave;
		WTRelease;
	}
	%orig;
}
- (void)startRangingBeaconsInRegion:(CLBeaconRegion *)region{
	if(WTShouldLog){
		WTInit(@"CLLocationManager",@"startRangingBeaconsInRegion:");
		LogCLRegion(region);
		WTAdd(region.proximityUUID,@"proximityUUID");
		WTSave;
		WTRelease;
	}
	%orig;
}
%end
/*%hook CLLocation
- (id)initWithLatitude:(CLLocationDegrees)latitude
	longitude:(CLLocationDegrees)longitude{

	}
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
	altitude:(CLLocationDistance)altitude
	horizontalAccuracy:(CLLocationAccuracy)hAccuracy
	verticalAccuracy:(CLLocationAccuracy)vAccuracy
	timestamp:(NSDate *)timestamp;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
    altitude:(CLLocationDistance)altitude
    horizontalAccuracy:(CLLocationAccuracy)hAccuracy
    verticalAccuracy:(CLLocationAccuracy)vAccuracy
    course:(CLLocationDirection)course
    speed:(CLLocationSpeed)speed
    timestamp:(NSDate *)timestamp
- (double)distanceFromLocation:(const CLLocation *)location{


}
%end*/


%end
extern void init_CoreLocation_hook() {
    %init(CoreLocation);
}
#undef LogCLRegion

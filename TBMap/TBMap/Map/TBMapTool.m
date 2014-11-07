//
//  TBMapTool.m
//  TBMap
//
//  Created by libo on 11/7/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBMapTool.h"

@implementation TBMapTool

+ (NSArray *)createAnnotations:(NSArray *)items
{
    NSMutableArray *ans = [[NSMutableArray alloc] initWithCapacity:0];
    for (TBLocationModel *item in items) {
        
        TBMapAnnotation *an = [[TBMapAnnotation alloc] initWithPlace:item];
        [ans addObject:an];
    }
    return ans;
}

+(void)findLocation
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        
        // ios6以下，调用google map //纬度,经度 s->d
        NSString *theString = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",40.035672,116.350161, 40.035672, 116.350061];
        theString =  [theString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        NSURL *url = [[NSURL alloc] initWithString:theString];
        
        [[UIApplication sharedApplication] openURL:url];
        
    } else { // 直接调用ios自己带的apple map
       
        CLLocationCoordinate2D to;
        
        to.latitude = 40.035672;
        to.longitude = 116.350061;
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
        
        toLocation.name = @"Destination";
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
    }
}

@end

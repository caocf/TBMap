//
//  TBAppDelegate.h
//  TBMap
//
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VDStruct.h"
#import "TBServiceContext.h"
#import <CoreLocation/CoreLocation.h>

@interface TBAppDelegate : UIResponder <UIApplicationDelegate,VDStructDelegate>
{
    TBServiceContext *_serviceContext;
}

@property (strong, nonatomic) UIWindow *window;

@end

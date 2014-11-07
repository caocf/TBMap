//
//  MyAnnotation.m
//  FindMe
//
//  Created by qianfeng on 13-1-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "TBMapAnnotation.h"

@implementation TBMapAnnotation

@synthesize place=_place;

-(id)init
{
    return [self initWithPlace:nil];
}

-(id)initWithPlace:(TBLocationModel *)p
{
    self = [super init];
    if(self)
    {
        self.place = p;
    }
    return self;
}

+(id)annotationWithPlace:(TBLocationModel *)p
{
    return [[[self class] alloc] initWithPlace:p];
}

-(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D center;
    if(_place)
    {
        center.latitude = _place.coor.latitude;
        center.longitude = _place.coor.longitude;
    }else
    {
    center.latitude = 40.029997;
    center.longitude = 116.346653;
    }
    return center;
}

-(NSString *)title
{
    if(_place)
    {
        return [NSString stringWithString:SAFE_STRING(_place.title)];
    }
    return @"未知";
}

-(NSString *)subtitle
{
    if(_place)
    {
        return [NSString stringWithString:_place.subtitle];
    }
    return @"未知";
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"MyAn %@ %@ %f %f",self.title,self.subtitle,self.coordinate.latitude,self.coordinate.longitude];
}

- (void)dealloc {
    self.place = nil;
}

@end

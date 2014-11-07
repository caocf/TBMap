//
//  TBMapView.h
//  TBMap
//
//  Created by libo on 11/7/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TBMapView : MKMapView

/*!
 *  @brief  加载地图
 *  @return TBMapView 实例
 */
+(TBMapView *)loadMapOnView:(UIView *)superview withFrame:(CGRect)frame;



@end

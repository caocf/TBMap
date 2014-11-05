//
//  TBLocationTool.h
//  TBMap
//
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "TBLocationConstant.h"

@interface TBLocationTool : NSObject

/*!
 *  @brief  GPS状态检测
 *  @return  返回nil表示正常，否则返回error
 */
+(NSError *)GPSStatusCheck;

/*!
 *  @brief  根据经纬度计算两点距离
 *
 */
double LantitudeLongitudeDist(double lon1,double lat1,
                              double lon2,double lat2);

@end

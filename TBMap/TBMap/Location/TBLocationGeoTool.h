//
//  TBLocationGeoTool
//  TBMap
//
//  地址编码与解码
//  Created by libo on 11/5/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
/*!
 *  @brief  解析结果返回
 *  @param placemarks 存放 CLPlacemark 类型数据
 */
typedef void (^CompleteBlock)(NSArray *placemarks);

@interface TBLocationGeoTool : NSObject

/*!
 *  @brief  地理编码：地名->经纬度
 *  @param address
 *
 */
-(void)gecode:(NSString *)address complete:(CompleteBlock)complete;


/*!
 *  @brief  地理解码: 经纬度 -> 地名
 *  @param coor 
 */
- (void)reverseGeocode:(CLLocationCoordinate2D)coor complete:(CompleteBlock)complete;


@end

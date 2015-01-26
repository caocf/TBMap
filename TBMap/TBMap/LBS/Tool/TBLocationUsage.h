//
//  TBLocationUsage
//  teambuild
//
//  Created by libo on 15-1-26.
//  Copyright (c) 2015年 sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLocationService.h"
#import "VDServiceFactory.h"
#import "TBLocationGeoTool.h"

@interface TBLocationUsage : NSObject

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(TBLocationUsage);

-(void)update:(void (^)())finished;

/*!
 *  @brief  原始定位信息
 */
@property (nonatomic,strong) CLPlacemark *placemark;

/*!
 *  @brief  经纬度
 */
@property (nonatomic,readwrite) CLLocationCoordinate2D localCoor;

/*!
 *  @brief  详细地址信息
 */
@property (nonatomic,strong) NSString *detailAddress;

/*!
 *  @brief  城市
 */
@property (nonatomic,strong) NSString *city;


@end

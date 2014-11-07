//
//  TBMapTool.h
//  TBMap
//
//  Created by libo on 11/7/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLocationModel.h"
#import "TBMapAnnotation.h"

@interface TBMapTool : NSObject

/*!
 *  @brief  根据 TBLocationModel 数据批量创建 TBMapAnnotation
 *  @param  TBLocationModel
 *  @return TBMapAnnotation
 */
+ (NSArray *)createAnnotations:(NSArray *)items;

@end

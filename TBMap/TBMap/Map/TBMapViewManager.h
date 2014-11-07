
/*!
 *  @brief  地图管理
 */


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TBMapAnnotation.h"
#import "TBLocationModel.h"
#import "TBMapView.h"

@interface TBMapViewManager : NSObject <MKMapViewDelegate>

-(void)addMapInViewController:(UIViewController *)viewController frame:(CGRect)frame;

-(void)setHiddenMap:(BOOL)hidden;

-(void)refreshAnnotations:(NSArray *)simpleItems;

@property (nonatomic,retain) TBMapView *mapview;

@property (nonatomic,retain) NSArray *annotations;

@property (nonatomic,retain) NSArray *simpleItemsArray;

@end

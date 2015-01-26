//
//  MyAnnotation.h
//  FindMe
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TBLocationModel.h"

@interface TBMapAnnotation : NSObject <MKAnnotation>
{
    TBLocationModel *_place;
}

@property (nonatomic,retain) TBLocationModel *place;

-(id)initWithPlace:(TBLocationModel *)p;

+(id)annotationWithPlace:(TBLocationModel *)p;

@end

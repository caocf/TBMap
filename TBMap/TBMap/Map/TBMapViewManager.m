

#import "TBMapViewManager.h"

@implementation TBMapViewManager
@synthesize mapview;
@synthesize annotations;
@synthesize simpleItemsArray;

-(void)addMapInViewController:(UIViewController *)viewController frame:(CGRect)frame
{
    mapview = [[TBMapView alloc] initWithFrame:frame];
    mapview.mapType = MKMapTypeStandard;
    
    //[self performSelector:@selector(updateRegion)];
    
    mapview.showsUserLocation =YES;
    mapview.delegate = self;
    [viewController.view addSubview:mapview];

}

-(void)setHiddenMap:(BOOL)hidden
{
    if (hidden) {
        [mapview setHidden:YES];
        [mapview removeAnnotations:annotations];
    }else
    {
        [mapview setHidden:NO];
        [self performSelector:@selector(updateRegion)];
    }
}

-(void)refreshAnnotations:(NSArray *)simpleItems
{
    simpleItemsArray = simpleItems;

    [mapview removeAnnotations:mapview.annotations];
    
    [self performSelector:@selector(updateRegion)];
    
    annotations =  [self performSelector:@selector(createAnnotations:) withObject:simpleItems];
    
    [mapview addAnnotations:annotations];
    
}

-(NSArray *)createAnnotations:(NSArray *)items
{
    NSMutableArray *ans = [[NSMutableArray alloc] initWithCapacity:0];
    for (TBLocationModel *item in items) {
        
        TBMapAnnotation *an = [[TBMapAnnotation alloc] initWithPlace:item];
        [ans addObject:an];
    }
    return ans;
}

//MKMapViewDelegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    NSString *AnnotationID = @"AnnotationID";
    MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationID];
    if (pinView == nil) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationID];
        pinView.canShowCallout = YES;
    }else
    {
        pinView.annotation = annotation;
    }
    //取数据
    long index = [annotations indexOfObject:annotation];
    if (index < [simpleItemsArray count]) {
        //TBLocationModel *item = [simpleItemsArray objectAtIndex:index];
       
        pinView.image = [UIImage imageNamed:@"class_meishi.png"];
        //pinView.transform = CGAffineTransformMakeScale(0.5, 0.5);
       
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        imageview.image = [UIImage imageNamed:@"life.png"];
        pinView.leftCalloutAccessoryView = imageview;
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view 
{
    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    view.transform = CGAffineTransformMakeScale(0.5, 0.5);
}


-(void)updateRegion
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    double latitude=[[userDefaults valueForKey:@"latitude"] doubleValue];
    double longitude = [[userDefaults valueForKey:@"longitude"] doubleValue];
    [userDefaults synchronize];
    latitude = 40.035672;
    longitude = 116.350061;
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.08, 0.08);
    MKCoordinateRegion region = MKCoordinateRegionMake(coor, span);
    [mapview setRegion:region animated:YES];
    
}

-(void)dealloc
{

}

@end

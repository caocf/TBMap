

#import "TBMapViewManager.h"

@implementation TBMapViewManager
@synthesize mapview;
@synthesize annotations;
@synthesize simpleItemsArray;

#pragma mark - Init

-(void)addMapInViewController:(UIViewController *)viewController frame:(CGRect)frame
{
    mapview = [[TBMapView alloc] initWithFrame:frame];
    mapview.mapType = MKMapTypeStandard;
    
    [self performSelector:@selector(updateRegion) withObject:nil afterDelay:0];
    
    mapview.userLocation.title = @"我的位置";
    mapview.showsUserLocation =YES;
   // mapview.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    mapview.delegate = self;
    [viewController.view addSubview:mapview];
    
}


#pragma mark - MKMapViewDelegate

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

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{

    MKPolyline *routeLine = [self getPolyline];
    
    MKPolylineView *routeLineView = [[MKPolylineView alloc] initWithPolyline:routeLine];
    routeLineView.fillColor = [UIColor blueColor];
    routeLineView.strokeColor = [UIColor blueColor];
    routeLineView.lineWidth = 7;
    
    return routeLineView;

}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    view.transform = CGAffineTransformMakeScale(1.5, 1.5);
}


- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
}



#pragma mark - MapControl

-(void)updateRegion
{
    CLLocationCoordinate2D coor =mapview.userLocation.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.08, 0.08);
    MKCoordinateRegion region = MKCoordinateRegionMake(coor, span);
    [mapview setRegion:region animated:YES];
    
    
    [mapview addOverlay:[self getPolyline]];
}

-(void)refreshAnnotations:(NSArray *)simpleItems
{
    simpleItemsArray = simpleItems;
    
    [mapview removeAnnotations:mapview.annotations];
    
    [self performSelector:@selector(updateRegion)];
    
    annotations = [TBMapTool createAnnotations:simpleItemsArray];
    
    [mapview addAnnotations:annotations];
    
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

#pragma mark - Tool

-(MKPolyline *)getPolyline
{
    MKMapPoint *pointArray = malloc(sizeof(CLLocationCoordinate2D) * 5);
    
    for (int i = 0; i < 5; i++) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.035672 + i*0.02, 116.350061);
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        pointArray[i] = point;
    }
    
    MKPolyline *routeLine = [MKPolyline polylineWithPoints:pointArray count:5];
    
    return routeLine;
}


-(void)dealloc
{
    
}

@end

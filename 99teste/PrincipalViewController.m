//
//  PrincipalViewController.m
//  99teste
//
//  Created by Samuel Catalano on 8/30/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "PrincipalViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <CoreLocation/CoreLocation.h>
#import "JPMBoundingCoordinates.h"
#import "Constants.h"


@interface PrincipalViewController ()
{
    CGFloat txtLatitude;
    CGFloat txtLongitude;
}

@end

@implementation PrincipalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView.showsUserLocation = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingLocation];
    
    //View Area
    MKCoordinateRegion region = {{0.0, 0.0}, {0.0, 0.0}};
    
    region.span.longitudeDelta = 0.15f;
    region.span.longitudeDelta = 0.15f;
    [_mapView setRegion:region animated:YES];
    [_mapView setDelegate:self];
    
    [self addPinToMap:region.center.longitude :region.center.latitude: YES];
    
    [self updateDriversByLocation];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)addPinToMap:(double)longt :(double)latit : (BOOL)isCurrentLocation
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latit, longt);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coord];
    if (isCurrentLocation) {
        [annotation setTitle:@"Current Location"];
    }
    [self.mapView addAnnotation:annotation];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    MKAnnotationView *annView = [[MKAnnotationView alloc ] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    if ([[annotation title] isEqualToString:@"Current Location"]) {
        UIImage *img = [UIImage imageNamed:@"location_icon.png"];
        img = [self imageWithImage:img scaledToSize:CGSizeMake(64,64)];
        annView.image = img;
    }
    else {
        UIImage *img = [UIImage imageNamed:@"car_pin_icon.png"];
        img = [self imageWithImage:img scaledToSize:CGSizeMake(35,30)];
        annView.image = img;
    }
    return annView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (NSString *)deviceLocation
{
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat
{
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}

- (NSString *)deviceLon
{
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt
{
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)btnRequestDriverClicked:(id)sender
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    [manager PUT:urlRequestNewRide parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        NSString *location = httpResponse.allHeaderFields[@"Location"];
        NSLog(@"%@",location);
        
        [manager GET:location parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
        {
            NSLog(@"%@",responseObject);
            NSNumber *idRide = responseObject[@"rideId"];
            NSString *msgTitle = @"Your ride number #";
            msgTitle = [msgTitle stringByAppendingString:[idRide stringValue]];
            NSString *msg = (NSString*) responseObject[@"msg"];
            
            [self showUIMessage:msg msgTitle:msgTitle];
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
        {
            NSLog(@"Fail");
            NSLog(@"%@",error);
        }];
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSString *msgTitle = @":(";
        NSString *msg = @"Unfortunately something happened with the ride. Try again in a few seconds";
        [self showUIMessage:msg msgTitle:msgTitle];
        NSLog(@"Fail");
        NSLog(@"%@",error);
    }];
}

- (void)updateDriversByLocation
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    NSString* latitudeStr = [NSString stringWithFormat: @"%f", txtLatitude];
    NSString* longituteStr = [NSString stringWithFormat: @"%f", txtLongitude];
    NSString *coordenadas = [latitudeStr stringByAppendingString:@","];
    coordenadas = [coordenadas stringByAppendingString:longituteStr];
    
    NSString *location = urlDriversLocation;
    location = [location stringByAppendingString:coordenadas];
    
    [manager GET:location parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSDictionary *dicionario = (NSDictionary *) responseObject;
        
        for(id key in dicionario) {
            NSDictionary *dic = key;
            NSNumber *latitude = dic[@"latitude"];
            NSNumber *longitude = dic[@"longitude"];
            
            [self addPinToMap:[longitude doubleValue] :[latitude doubleValue] :NO];
        }
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Fail");
             NSLog(@"%@",error);
         }];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    NSString *latitude = [NSString stringWithFormat:@"%g", currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%g", currentLocation.coordinate.longitude];
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:0];
    [temp addObject:latitude];
    [temp addObject:longitude];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:temp forKey:@"CLocation"];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(_mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
    txtLatitude = coord.latitude;
    txtLongitude = coord.longitude;

    [self updateDriversByLocation];
}

- (IBAction)btnShowCurrentLocationClicked:(id)sender
{
    MKCoordinateRegion region = {{0.0, 0.0}, {0.0, 0.0}};
    region.span.longitudeDelta = 0.01f;
    region.span.longitudeDelta = 0.01f;
    CLLocationCoordinate2D location;
    location.latitude = txtLatitude;
    location.longitude = txtLongitude;
    region.center = location;
    [_mapView setRegion:region animated:YES];
}

- (void)showUIMessage:(NSString *)msg msgTitle:(NSString *)msgTitle
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:msgTitle message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
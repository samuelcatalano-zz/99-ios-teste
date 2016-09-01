//
//  PrincipalViewController.h
//  99teste
//
//  Created by Samuel Catalano on 8/30/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"

@interface PrincipalViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@property(nonatomic,weak)   IBOutlet MKMapView  *mapView;
@property(nonatomic,retain) CLLocationManager   *locationManager;
@property(nonatomic,weak)   IBOutlet UIButton   *btnRequestDriver;
@property(nonatomic,weak)   IBOutlet UIButton   *btnShowCurrentLocation;

@end
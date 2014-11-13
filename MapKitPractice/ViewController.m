//
//  ViewController.m
//  MapKitPractice
//
//  Created by Chase Wasden on 11/11/14.
//  Copyright (c) 2014 Chase Wasden. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <AFNetworking/AFNetworking.h>
#import "MyAnnotation.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager * manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.manager = [[CLLocationManager alloc] init];
    [self.manager requestWhenInUseAuthorization];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(40.226192, -111.660807);
    float metersInMile = 1609;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 5*metersInMile, 5*metersInMile);
    
    [self.mapView setRegion:region];
    
    
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc] init];
    
    NSString * url = @"http://www.utah.gov/locationaware/getNearByLocations.html?zipCode=84601&locationType=4&type=json&listSize=100";
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray* objects) {
        [self displayAnnotations:objects];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@", error);
    }];
    
    
}


// Unused method, play around with it if you want!
-(void)trySearchRequest {
    MKLocalSearchRequest * request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"grocery";
    request.region = self.mapView.region;
    
    MKLocalSearch * search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        NSLog(@"response: %@", response);
    }];
}

-(void)displayAnnotations:(NSArray *)objects {
    for (NSDictionary * obj in objects) {
        MyAnnotation * annotation = [MyAnnotation new];
        
        NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber * latitude = [formatter numberFromString:obj[@"lat"]];
        NSNumber * longitude = [formatter numberFromString:obj[@"lon"]];
        annotation.coordinate = CLLocationCoordinate2DMake(latitude.doubleValue,longitude.doubleValue);
        annotation.title = obj[@"name"];
        annotation.subtitle = obj[@"street"];
        [self.mapView addAnnotation:annotation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MyAnnotation.h
//  MapKitPractice
//
//  Created by Chase Wasden on 11/11/14.
//  Copyright (c) 2014 Chase Wasden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end

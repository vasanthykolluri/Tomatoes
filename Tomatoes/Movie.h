//
//  Movie.h
//  Tomatoes
//
//  Created by Vasanthy Kolluri on 1/12/14.
//  Copyright (c) 2014 Vasanthy Kolluri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSMutableString *cast;
@property (nonatomic, strong) NSString *imageURL;

- (id)initWithDictionary:(NSDictionary *) dictionary;

@end

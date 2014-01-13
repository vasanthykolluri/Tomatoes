//
//  Movie.m
//  Tomatoes
//
//  Created by Vasanthy Kolluri on 1/12/14.
//  Copyright (c) 2014 Vasanthy Kolluri. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(id)initWithDictionary:(NSDictionary *) dictionary{
    
    self.title = [dictionary objectForKey:@"title"];
    self.synopsis = [dictionary objectForKey:@"synopsis"];
    
    NSDictionary *posters = [dictionary objectForKey:@"posters"];
    self.imageURL = [posters objectForKey:@"thumbnail"];
    
    self.cast = [[NSMutableString alloc] init];
    
    NSArray *abridged_cast = [dictionary objectForKey:@"abridged_cast"];
    for (int i = 0; i < [abridged_cast count]; i++) {
        NSString *name = [abridged_cast[i] objectForKey:@"name"];
        if (i) {
         [self.cast appendString:@","];
        }
        [self.cast appendString:name];
      
    }
    
    return self;
}

@end

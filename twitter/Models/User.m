//
//  User.m
//  twitter
//
//  Created by Ana Cismaru on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        NSString *blurryPicUrlString = dictionary[@"profile_image_url_https"];
        self.profilePicURLString = [blurryPicUrlString
        stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
      // Initialize any other properties
    }
    return self;
}

@end

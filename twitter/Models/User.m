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
        
        self.tagline = dictionary[@"description"];
        self.bannerPicURLString = dictionary[@"profile_banner_url"];
        self.followerCount = [dictionary[@"followers_count"] stringValue];
        self.followingCount = [dictionary[@"friends_count"] stringValue];
        self.tweetCount = [dictionary[@"statuses_count"] stringValue];
        self.memberSince = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        NSDate *date = [formatter dateFromString:self.memberSince];
        formatter.dateStyle = NSDateFormatterMediumStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        self.memberSince = [formatter stringFromDate:date];
        
        
        // Initialize any other properties
        
    }
    return self;
}

@end

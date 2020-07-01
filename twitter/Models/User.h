//
//  User.h
//  twitter
//
//  Created by Ana Cismaru on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicURLString;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *bannerPicURLString;
@property (nonatomic, strong) NSString *followerCount;
@property (nonatomic, strong) NSString *followingCount;
@property (nonatomic, strong) NSString *tweetCount;
@property (nonatomic, strong) NSString *memberSince;
//Other properties here

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END

//
//  TweetViewController.h
//  twitter
//
//  Created by Ana Cismaru on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetViewController : UIViewController

@property (strong, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END

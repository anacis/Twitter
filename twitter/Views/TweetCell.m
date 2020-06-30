//
//  TweetCell.m
//  twitter
//
//  Created by Ana Cismaru on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(id)sender {
    if (!self.tweet.favorited) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self refreshData];
    
}

- (IBAction)didTapRetweet:(id)sender {
    if (!self.tweet.retweeted) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self refreshData];
}

- (void)refreshData {
    NSURL *profilePicURL = [NSURL URLWithString:self.tweet.user.profilePicURLString];
    [self.userImage setImageWithURL:profilePicURL];
    self.name.text = self.tweet.user.name;
    
    if (self.tweet.user.screenName != nil) {
        NSString *atSym = @"@";
        self.username.text = [atSym stringByAppendingString:self.tweet.user.screenName];
    }
    else {
        self.username.text = @"";
    }
    
    self.date.text = self.tweet.timeAgoString;
    self.tweetLabel.text = self.tweet.text;
    
    //Twitter API doesn't support the reply Count
    //replyButton;
    NSUInteger randomNum = arc4random_uniform(2020);
    self.replyCount.text = [NSString stringWithFormat:@"%d", randomNum];
    
    if (self.tweet.retweeted) {
        UIImage *img = [UIImage imageNamed:@"retweet-icon-green"];
        [self.retweetButton setImage:img forState:UIControlStateNormal];
    }
    else {
        UIImage *img = [UIImage imageNamed:@"retweet-icon"];
        [self.retweetButton setImage:img forState:UIControlStateNormal];
    }
    
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    if (self.tweet.favorited) {
        UIImage *img = [UIImage imageNamed:@"favor-icon-red"];
        [self.favorButton setImage:img forState:UIControlStateNormal];
    }
    else {
        UIImage *img = [UIImage imageNamed:@"favor-icon"];
        [self.favorButton setImage:img forState:UIControlStateNormal];
    }
    
    self.favorCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    //messageImage;
}
@end

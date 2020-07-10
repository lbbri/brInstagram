//
//  PostTableViewCell.m
//  brInstagram
//
//  Created by brm14 on 7/8/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import "PostTableViewCell.h"
#import <Parse/Parse.h>
#import "NSDate+DateTools.h"


@implementation PostTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    //self.photoImageView.file = post[@"image"];
    self.photoImageView.file = post.image;
    self.captionLabel.text = post.caption;
    self.usernameLabel.text = post.author.username;
    self.usernameLabel2.text = post.author.username;
    self.timeStampLabel.text = [NSString stringWithFormat:@"%@ ago", [self formatDate:post.createdAt]];
    [self.photoImageView loadInBackground];
}

- (NSString*)formatDate:(NSDate *)date {
    NSString *timeStamp = date.shortTimeAgoSinceNow;
    return timeStamp;

}

@end

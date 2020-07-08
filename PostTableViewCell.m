//
//  PostTableViewCell.m
//  brInstagram
//
//  Created by brm14 on 7/8/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import "PostTableViewCell.h"
#import <Parse/Parse.h>

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

    [self.photoImageView loadInBackground];
}

@end

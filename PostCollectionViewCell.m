//
//  PostCollectionViewCell.m
//  brInstagram
//
//  Created by brm14 on 7/10/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import "PostCollectionViewCell.h"

@implementation PostCollectionViewCell


- (void)setPost:(Post *)post {
    _post = post;
    
    self.postImageView.file = post.image;
    [self.postImageView loadInBackground];
}

@end

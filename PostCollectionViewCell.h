//
//  PostCollectionViewCell.h
//  brInstagram
//
//  Created by brm14 on 7/10/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFImageView.h"

#import "Post.h"



NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionViewCell : UICollectionViewCell


@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) IBOutlet PFImageView *postImageView;

- (void)setPost:(Post *)post;


@end

NS_ASSUME_NONNULL_END

//
//  PostTableViewCell.h
//  brInstagram
//
//  Created by brm14 on 7/8/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

#import "PFImageView.h"

//@import Parse;


NS_ASSUME_NONNULL_BEGIN


@interface PostTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel2;


- (void)setPost:(Post *)post;

- (NSString*)formatDate:(NSDate *)date;



@end

NS_ASSUME_NONNULL_END

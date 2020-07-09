//
//  DetailsViewController.h
//  brInstagram
//
//  Created by brm14 on 7/9/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

#import "PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeStampLabel;


- (void)setPost:(Post *)post;
- (NSString*)formatDate:(NSDate *)date;


@end

NS_ASSUME_NONNULL_END

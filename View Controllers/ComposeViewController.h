//
//  ComposeViewController.h
//  brInstagram
//
//  Created by brm14 on 7/7/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *chosenImageView;
@property (strong, nonatomic) IBOutlet UITextView *captionView;

@end

NS_ASSUME_NONNULL_END

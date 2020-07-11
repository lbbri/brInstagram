//
//  ComposeViewController.m
//  brInstagram
//
//  Created by brm14 on 7/7/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import "ComposeViewController.h"
#import "../brInstagram/Post.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.chosenImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage)];
    
    imageTap.numberOfTapsRequired = 1;
    
    [imageTap setDelegate:self];
    [self.chosenImageView addGestureRecognizer:imageTap];
}

- (void)chooseImage {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)])
    {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        //NSLog(@"Camera not available");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary<NSString *, id>*)info {
    
    //gets the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.chosenImageView.image = editedImage;
        
    //dismiss picker and go back to original vc
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)shareTap:(id)sender {
    
    UIImage *image = self.chosenImageView.image;
    NSString *caption = self.captionView.text;
    
    image = [self resizeImage:image withSize:CGSizeMake(150.0, 150.0)];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [Post postUserImage:image withCaption:caption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded)
        {
            //NSLog(@"success");
            [self dismissViewControllerAnimated:YES completion:nil];

        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

}
- (IBAction)cancelTap:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)onScreenTap:(id)sender {
    [self.view endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

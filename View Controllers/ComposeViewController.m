//
//  ComposeViewController.m
//  brInstagram
//
//  Created by brm14 on 7/7/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        NSLog(@"Camera not available");
        //imagePickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary<NSString *, id>*)info {
    
    //gets the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.chosenImageView.image = editedImage;
    
    //do something with the images
    
    //dismiss picker and go back to original vc
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

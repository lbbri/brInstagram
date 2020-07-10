//
//  DetailsViewController.m
//  brInstagram
//
//  Created by brm14 on 7/9/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import "DetailsViewController.h"
#import <Parse/Parse.h>
#import "NSDate+DateTools.h"



@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setPost:self.post];
}


- (void)setPost:(Post *)post {
    _post = post;
    //self.photoImageView.file = post[@"image"];
    self.photoImageView.file = post.image;
    self.captionLabel.text = post.caption;
    self.usernameLabel.text = post.author.username;
    //self.timeStampLabel.text = [NSString stringWithFormat:@"%@", post.createdAt];
    self.timeStampLabel.text = [NSString stringWithFormat:@"%@ ago", [self formatDate:post.createdAt]];

    [self.photoImageView loadInBackground];
}

- (NSString*)formatDate:(NSDate *)date {
    
    NSString *timeStamp = date.shortTimeAgoSinceNow;
    
    return timeStamp;

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

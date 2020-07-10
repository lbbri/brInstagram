//
//  UserFeedViewController.h
//  brInstagram
//
//  Created by brm14 on 7/10/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserFeedViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *userPostsArray;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *postsCountLabel;

@end

NS_ASSUME_NONNULL_END

//
//  UserFeedViewController.m
//  brInstagram
//
//  Created by brm14 on 7/10/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import "UserFeedViewController.h"

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "SceneDelegate.h"
#import "Post.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import "PostCollectionViewCell.h"


@interface UserFeedViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation UserFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    [self fetchFeed];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    
    //can also set in storyboard
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    CGFloat postersPerLine = 3;
    
    //correctly calculates layout based on how many movies are on each row
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine-1)) / postersPerLine;
    CGFloat itemHeight = itemWidth;
    
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}


- (void)fetchFeed {
    
    //set up the query
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"caption"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    //postQuery.limit = 20;
    
    //asynchronously get data from database
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray <Post *>* _Nullable posts, NSError * _Nullable error) {
        if(posts)
        {
            self.userPostsArray = (NSMutableArray *)posts;
            //do something == load an array with posts
            [self.collectionView reloadData];
            //self.usernameLabel.text =[NSString stringWithFormat:@"@%@", posts[0].author.username];
            [self.navigationController.navigationBar.topItem setTitle:[NSString stringWithFormat:@"@%@", posts[0].author.username]];


            //NSLog(@"hi");
        }
        else
        {
            NSLog(@"error: %@", error.localizedDescription);
        }

    }];
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([sender isKindOfClass:[PostCollectionViewCell class]]){
        
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath= [self.collectionView indexPathForCell:tappedCell];
        Post *post = self.userPostsArray[indexPath.row];
        
        DetailsViewController *currentDVC = [segue destinationViewController];
        currentDVC.post = post;
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}




//necessary function to implement UICollectionViewDataSource similar to TableView
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    Post *post = self.userPostsArray[indexPath.item];
    
    [cell setPost:post];
    
    return cell;
}

//necessary function to implement UICollectionViewDataSource similar to TableView
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.userPostsArray.count;
}

@end

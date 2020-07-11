//
//  FeedViewController.m
//  brInstagram
//
//  Created by brm14 on 7/7/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "SceneDelegate.h"
#import "Post.h"
#import "PostTableViewCell.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"


@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (assign, nonatomic) BOOL isMoreDataLoading;
@property NSInteger loadNum;



@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.loadNum = 20;
    
    [self fetchFeed:self.loadNum];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    //would keep spinning if this method was not called... it calls fetchTimeLine on self
    [self.refreshControl addTarget:self action:@selector(fetchFeed:) forControlEvents:UIControlEventValueChanged];
    //add the refreshcontrol to the tableview
    [self.tableView addSubview:self.refreshControl];
    //which is better?  [self.tableView insertSubview:self.refreshControl atIndex:0];
    
}

- (IBAction)didTapLogout:(id)sender {
    
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil] ;
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    myDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        //current user is now nil
    }];
    
}

- (void)fetchFeed:(NSInteger)numofPosts {
    
    //set up the query
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"caption"];
    postQuery.limit = numofPosts;
    
    
    //asynchronously get data from database
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray <Post *>* _Nullable posts, NSError * _Nullable error) {
        if(posts)
        {
            self.feedPostsArray = (NSMutableArray *)posts;
            [self.tableView reloadData];

        }
        
        [self.refreshControl endRefreshing];

    }];
    
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     if([sender isKindOfClass:[PostTableViewCell class]]){
         
         UITableViewCell *tappedCell = sender;
         NSIndexPath *indexPath= [self.tableView indexPathForCell:tappedCell];
         Post *post = self.feedPostsArray[indexPath.row];
         
         DetailsViewController *currentDVC = [segue destinationViewController];
         currentDVC.post = post;
         
     }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(!self.isMoreDataLoading)
    {
        //calculates the position of one screen length before the bottom of the results (should probably do it earler)
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetthreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetthreshold && self.tableView.isDragging)
        {
            self.isMoreDataLoading = true;
            //load more data
            self.loadNum += 20;
            [self fetchFeed:self.loadNum];
        }
        
    }
    
}


//necessary for UITableViewSource implementation: gets # of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedPostsArray.count;
}

//necessary for UITableViewSource implementation: asks data source for a cell to insert
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.feedPostsArray[indexPath.row];

    [cell setPost:post];
        
    return cell;
}

@end

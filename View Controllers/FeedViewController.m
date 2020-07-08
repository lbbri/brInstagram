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

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchFeed];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    // Do any additional setup after loading the view.
    
    
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

- (void)fetchFeed {
    
    //set up the query
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    //asynchronously get data from database
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray <Post *>* _Nullable posts, NSError * _Nullable error) {
        if(posts)
        {
            self.feedPostsArray = (NSMutableArray *)posts;
            //do something == load an array with posts
            [self.tableView reloadData];

            NSLog(@"hi");
        }
        else
        {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//necessary for UITableViewSource implementation: gets # of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedPostsArray.count;
}
//necessary for UITableViewSource implementation: asks data source for a cell to insert
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    //use the Post cell that's set up on the storyboard
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    //NSLog(@"cell: %@", cell);
    
    Post *post = self.feedPostsArray[indexPath.row];

    [cell setPost:post];
        
    return cell;
}

@end

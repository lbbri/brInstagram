//
//  LoginViewController.m
//  brInstagram
//
//  Created by brm14 on 7/7/20.
//  Copyright © 2020 brm14. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)signUpTap:(id)sender {
    
    PFUser *newUser = [PFUser user];
    
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Message" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //handle try agin here. Doing nothing will dismiss the view.
    }];
    [alert addAction:tryAgainAction];
    
    
    if([self.usernameField.text isEqual:@""])
    {
        alert.message = @"User Name cannot be empty";
        [self presentViewController:alert animated:YES completion:^{
        }];

    }
    else if ([self.passwordField.text isEqual:@""])
    {
        alert.message = @"Password cannot be empty";
        [self presentViewController:alert animated:YES completion:^{
        }];
        
    }
    else
    {
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
           if (error != nil)
           {
               alert.message = error.localizedDescription;
               [self presentViewController:alert animated:YES completion:^{
               }];
           }
           else
           {
               
               [self performSegueWithIdentifier:@"loginSegue" sender:nil];
           }
        }];
        
    }
}
- (IBAction)logInTap:(id)sender {
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Message" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Doing nothing will dismiss the view.
    }];
    [alert addAction:tryAgainAction];
    
    
    if([self.usernameField.text isEqual:@""])
    {
        alert.message = @"User Name cannot be empty";
        [self presentViewController:alert animated:YES completion:^{
        }];

    }
    else if ([self.passwordField.text isEqual:@""])
    {
        alert.message = @"Password cannot be empty";
        [self presentViewController:alert animated:YES completion:^{
        }];
        
    }
    else
    {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil)
            {
                //NSLog(@"User log in failed %@", error.localizedDescription);
                alert.message = error.localizedDescription;
                [self presentViewController:alert animated:YES completion:^{
                       //what happens after altert controller has finsihed presinting
                    }];
                
            }
            else
            {
                //NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
        
    }
    
}


- (IBAction)cancelTap:(id)sender {
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

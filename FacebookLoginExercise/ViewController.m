//
//  ViewController.m
//  FacebookLoginExercise
//
//  Created by GIGIGUN on 19/10/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(test:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    
    
    // get facebook user info
    NSLog(@"Get notification appID %@", [[FBSDKAccessToken currentAccessToken] appID]);
    NSLog(@"Get notification tokenString %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
    NSLog(@"Get notification expirationDate %@", [[FBSDKAccessToken currentAccessToken] expirationDate]);
    NSLog(@"Get notification userID %@", [[FBSDKAccessToken currentAccessToken] userID]);

    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
             }
         }];
    }
    
    // For more complex open graph stories, use `FBSDKShareAPI`
    // with `FBSDKShareOpenGraphContent`
    /* make the API call */
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"me/picture"
                                  parameters:@{@"height" : @100, @"redirect" : @0, @"type": @"square", @"width" : @100}
                                  HTTPMethod:@"GET"];
    
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        // Handle the result
        NSLog(@"fetched user:%@", result);
        
        // TODO: convert imageUrl to UIImage and base64 string

    }];
    
    
    //FBSDKAccessTokenDidChangeNotification
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) test:(NSNotification*) notification
{
    NSLog(@"Get notification appID %@", [[FBSDKAccessToken currentAccessToken] appID]);
    NSLog(@"Get notification tokenString %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
    NSLog(@"Get notification expirationDate %@", [[FBSDKAccessToken currentAccessToken] expirationDate]);
    NSLog(@"Get notification userID %@", [[FBSDKAccessToken currentAccessToken] userID]);
    NSLog(@"Get notification permissions %@", [[FBSDKAccessToken currentAccessToken] permissions]);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

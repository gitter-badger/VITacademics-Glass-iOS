//
//  BaseViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/18/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@property (nonatomic) BOOL menuShowing;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation BaseViewController

- (HomeCollectionViewController *)homeScreenCollectionViewController
{
    if(!_homeScreenCollectionViewController)
    {
        _homeScreenCollectionViewController = [[UIStoryboard storyboardWithName:@"Main"
                                                                         bundle:nil] instantiateViewControllerWithIdentifier:@"HomeCollectionViewController"];
    }
    return _homeScreenCollectionViewController;
}



- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(![[NSUserDefaults standardUserDefaults] stringForKey:@"firstTime"]){
        [self beginLoginProcess];
    }
    else{
        [self addChildViewController:self.homeScreenCollectionViewController];
        [self.view insertSubview:self.homeScreenCollectionViewController.view belowSubview:self.menuButton];
        
        [self addshadows];
    }
    
    [self.buttonsView removeFromSuperview];
    [self.view insertSubview:self.buttonsView belowSubview:self.homeScreenCollectionViewController.view];
    
    for(UIButton *button in self.MenuButtons){
        button.alpha = 0;
    }
    
    [UIView animateWithDuration:0.8 animations:^{
        for(UIButton *button in self.MenuButtons){
            button.alpha = 1;
        }
    }];
    

}

-(void)beginLoginProcess
{
    
    LoginViewController *loginViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self presentViewController:loginViewController animated:NO completion:nil];
}


- (void) addshadows
{
    self.homeScreenCollectionViewController.view.layer.shadowRadius = 10.0;
    self.homeScreenCollectionViewController.view.layer.shadowOpacity = 0.8;
    self.homeScreenCollectionViewController.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.homeScreenCollectionViewController.view.layer.shadowOffset = CGSizeZero;
}

- (IBAction)menuButtonTapped:(id)sender
{
    if(self.menuShowing)
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.homeScreenCollectionViewController.view.transform = CGAffineTransformIdentity;
                             self.homeScreenCollectionViewController.view.layer.cornerRadius = 0;
                             self.homeScreenCollectionViewController.view.userInteractionEnabled = YES;
                         }];
        self.menuShowing = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.homeScreenCollectionViewController.view.transform = CGAffineTransformMakeTranslation(0, 400);
                             self.homeScreenCollectionViewController.view.userInteractionEnabled = NO;
                         }];
        self.menuShowing = YES;
    }
}

@end
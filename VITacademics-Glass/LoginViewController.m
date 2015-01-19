//
//  LoginViewController.m
//  VITacademics-Glass
//
//  Created by Siddharth Gupta on 1/18/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (){
    UIDatePicker *datePicker;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.regNoTextField.delegate = self;
    self.dobTextField.delegate = self;
     datePicker = [[UIDatePicker alloc] init];
    
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"]){
        self.regNoTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"registrationNumber"];
    }
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"]){
        self.dobTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfBirth"];
    }
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButtonPressed:(id)sender {
    
    if([self.regNoTextField.text length] < 6 || [self.dobTextField.text length] < 8){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Check Fields" message:@"Please enter your correct details." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"registrationNumber"];
    [prefs removeObjectForKey:@"dateOfBirth"];
    [prefs setObject:self.regNoTextField.text forKey:@"registrationNumber"];
    [prefs setObject:self.dobTextField.text forKey:@"dateOfBirth"];
    NSLog(@"Preferences Saved");
    
    [prefs removeObjectForKey:@"firstTime"];
    [prefs setObject:@"YES" forKey:@"firstTime"];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"credentialsChanged" object:nil];
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == self.dobTextField){
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(pickerChanged) forControlEvents:UIControlEventValueChanged];
        self.dobTextField.inputView = datePicker;
    }
}

-(void)pickerChanged{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ddMMYYYY"];
    self.dobTextField.text = [dateFormatter stringFromDate:[datePicker date]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
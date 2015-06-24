//
//  PasswordViewController.h
//  AnsaP
//
//  Created by Rahul Singha Roy on 12/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Left.h"
#import "TGGlobalClass.h"
@interface PasswordViewController : UIViewController<UITextFieldDelegate>
{
     Left *object;
     BOOL leftbar_status;
}
@property (strong, nonatomic) IBOutlet UIView *baseview;
- (IBAction)Leftmenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *save_btn;
- (IBAction)save_button:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *old_password;

@property (strong, nonatomic) IBOutlet UITextField *New_password;

@property (strong, nonatomic) IBOutlet UITextField *confirm_password;

@property (strong, nonatomic) IBOutlet UILabel *header_title;




@end

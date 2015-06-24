//
//  SjukurViewController.h
//  AnsaP
//
//  Created by Rahul Singha Roy on 08/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Left.h"
@interface SjukurViewController : UIViewController
{
    Left *object;

}
@property (strong, nonatomic) IBOutlet UIView *mainview;
- (IBAction)yesbtn:(id)sender;
- (IBAction)nobtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *leftmenu;
- (IBAction)leftmenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *NoButton;

@property (weak, nonatomic) IBOutlet UIView *baseview;
@property (weak, nonatomic) IBOutlet UILabel *sjukarLabel;
@property (strong, nonatomic) IBOutlet UILabel *header_title;

@end

//
//  FreeViewController.h
//  AnsaP
//
//  Created by Rahul Singha Roy on 09/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Left.h"
@interface FreeViewController : UIViewController
{
     Left *object;
     BOOL leftbar_status,picker_open,ticbool;
    
    int getting_sender;
    
    NSString *finaldate;
    
    NSMutableArray *datelist_array;
    
    NSString *subadminID,*childrenID,*roomID;
    
    UIImageView *tickimage;
    
    NSString *remove_dates;
    
    NSMutableArray *remove_array;
    
}
- (IBAction)leftmenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *baseview;

- (IBAction)Calendar_open:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIVisualEffectView *datepickerbase;

@property (strong, nonatomic) IBOutlet UIDatePicker *date_picker;
- (IBAction)set_date:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *from_date;
@property (strong, nonatomic) IBOutlet UILabel *till_date;
@property (strong, nonatomic) IBOutlet UIButton *tiil_date_btn;

- (IBAction)submit_button:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *datelist_table;

@property (strong, nonatomic) IBOutlet UILabel *header_title;

@property (strong, nonatomic) IBOutlet UIButton *submit_button;

@end

//
//  NotesViewController.h
//  AnsaP
//
//  Created by Rahul Singha Roy on 07/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Left.h"
@interface NotesViewController : UIViewController
{
    Left *object;
    BOOL leftbar_status;
    
    NSMutableArray *server_data;
    
    
}
@property (weak, nonatomic) IBOutlet UIView *NodataFound;
@property (strong, nonatomic) IBOutlet UIView *mainview;
- (IBAction)Leftmenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *DateView;
@property (strong, nonatomic) IBOutlet UITableView *maintable;
@property (strong, nonatomic) IBOutlet UIView *baseview;
@property (strong, nonatomic) IBOutlet UIView *spinn;
@property (strong, nonatomic) IBOutlet UILabel *header_title;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property(nonatomic,strong)NSString *Change_Page;
@property (weak, nonatomic) IBOutlet UILabel *nodatafound;

@property (strong, nonatomic) IBOutlet UILabel *header_title1;

@end

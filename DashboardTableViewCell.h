//
//  DashboardTableViewCell.h
//  AnsaP
//
//  Created by Rahul Singha Roy on 08/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Posted_On;
@property (weak, nonatomic) IBOutlet UIView *LineView;

@property (strong, nonatomic) IBOutlet UILabel *title1;
@end

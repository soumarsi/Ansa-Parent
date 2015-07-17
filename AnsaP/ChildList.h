//
//  ChildList.h
//  AnsaP
//
//  Created by anirban on 17/07/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildList : UIViewController
{
    NSInteger getindex;
}

@property (weak, nonatomic) IBOutlet UITableView *childTbl;
- (IBAction)back_button:(id)sender;
@end

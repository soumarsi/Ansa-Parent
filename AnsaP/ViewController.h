//
//  ViewController.h
//  AnsaP
//
//  Created by anirban on 05/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGGlobal.h"


@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{

    UIAlertView *Alert;
    int selectedIndex;
    NSInteger *selectedKinderId;

}
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)Login:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *selectKinderLbl;

@property (strong, nonatomic) IBOutlet UIView *spinn;
- (IBAction)clickedOnOk:(id)sender;
- (IBAction)clickedOnCancel:(id)sender;

@end


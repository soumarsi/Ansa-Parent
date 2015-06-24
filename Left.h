//
//  Left.h
//  AnsaP
//
//  Created by Rahul Singha Roy on 07/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Leftdelegate<NSObject>
@optional
-(void)pushmethod:(UIButton *)sender;

@end
@interface Left : UIView

- (IBAction)LeftMenu_buttontap:(UIButton *)sender;

@property(assign)id<Leftdelegate>Delegate;

-(void)TapCheck:(int)Buttontag;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;
@property (strong, nonatomic) IBOutlet UIButton *btn7;
@property (strong, nonatomic) IBOutlet UIButton *btn8;



- (IBAction)button03:(id)sender;

- (IBAction)button2:(id)sender;





@end

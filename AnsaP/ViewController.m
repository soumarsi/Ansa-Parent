//
//  ViewController.m
//  AnsaP
//
//  Created by anirban on 05/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "ViewController.h"
#import "TGGlobalClass.h"
#import "UIFont+Allfont.h"
#import "Ansap.pch"
#import <UIKit/UIKit.h>
@interface ViewController ()<UITextFieldDelegate>
{
    TGGlobalClass *GlobalClass;
    
    NSMutableArray *kinderArray;
    
    IBOutlet UIVisualEffectView *kinderPickerBackView;
    
    IBOutlet UIPickerView *kinderPicekr;
    
    
    IBOutlet UIButton *kinderPickerOkBtn;
    
    
    IBOutlet UIButton *kinderPickerCnclBtn;
    
    
}

@property (strong, nonatomic) IBOutlet UIButton *selectKindergardenBtn;

@property (strong, nonatomic) IBOutlet UILabel *selectKindergardenLbl;

@property (strong, nonatomic) IBOutlet UIView *demoviewGray;
- (IBAction)openPicker:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GlobalClass = [[TGGlobalClass alloc]init];
    
    kinderArray=[[NSMutableArray alloc]init];
    selectedIndex = 0;
    _selectKindergardenBtn.layer.opacity=0.9;
    kinderPicekr.delegate = self;
    
    
    kinderPickerBackView.hidden=YES;
    self.demoviewGray.hidden = YES;
//   _email.text = @"aljo@olivant.fo";
//  _password.text = @"123456";
    //[_email becomeFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    
    
    [self kindergardenFunc];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
 
    [textField resignFirstResponder];
    return YES;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    kinderPickerBackView.hidden = YES;
    self.demoviewGray.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)kindergardenFunc
{
    
    [GlobalClass GlobalDict:[NSString stringWithFormat:@"%@allkinder.php",App_Domain_Url] Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        if(result)
        {
        
            kinderArray=[result mutableCopy];
            
            NSLog(@"Kindergarden list.... %lu",(unsigned long)kinderArray.count);
            [kinderPicekr reloadAllComponents];
        
        }
        
        
    }];
    
    
    
}


#pragma all the delegate of pickerview

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    selectedIndex = row;
    
    NSLog(@"......%d",selectedIndex);
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{

    return 60.0f;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return kinderArray.count;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont boldSystemFontOfSize:25]];
        tView.textAlignment = NSTextAlignmentCenter;
        
        
    }
    tView.text=[[kinderArray objectAtIndex:row] objectForKey:@"site_name"];
    return tView;
}


#pragma picker view delegate close


- (IBAction)Login:(id)sender
{
    [_spinn setHidden:NO];
    
    if (GlobalClass.connectedToNetwork == YES)
    {
        
        if ([_email.text isEqualToString:@""])
       {
            _email.placeholder = check_username;
            [_email setValue:[UIColor redColor]forKeyPath:@"_placeholderLabel.textColor"];
            [_email setValue:[UIFont Helvitica] forKeyPath:@"_placeholderLabel.font"];
           
           [_spinn setHidden:YES];
        }
        else if ([_password.text isEqualToString:@""])
        {
            [_spinn setHidden:YES];
            _password.placeholder = check_password;
            [_password setValue:[UIColor redColor]forKeyPath:@"_placeholderLabel.textColor"];
            [_password setValue:[UIFont Helvitica] forKeyPath:@"_placeholderLabel.font"];
            
        }else if ([self.selectKinderLbl.text isEqualToString:@"Select Kindergarden"])
        {
            [_spinn setHidden:YES];
            self.selectKinderLbl.text = selectKinder;
            self.selectKinderLbl.textColor = [UIColor redColor];
            self.selectKinderLbl.font = [UIFont boldSystemFontOfSize:18];
         
            
        }
        
        else{
            
            [_email resignFirstResponder];
            [_password resignFirstResponder];
        
            [GlobalClass GlobalDict:[NSString stringWithFormat:@"%@login_parent_multi.php?email=%@&password=%@&subAdminId=%ld",App_Domain_Url,[_email.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_password.text,selectedKinderId] Globalstr:@"array" Withblock:^(id result, NSError *error) {
               
                if (result)
                {
                    DebugLog(@"result-- %@",result);
                    
                    if ([[result objectForKey:@"auth"] isEqualToString:success])
                    {
                        
                        [_spinn setHidden:YES];
                        
                        [GlobalClass Userdict:[result objectForKey:@"details"]];
                        
                        
                        /// Setting Languge ///
                        
            NSUserDefaults *Language_status = [[NSUserDefaults alloc]init];
                        
            [Language_status setObject:[result objectForKey:@"site_language"] forKey:@"lang"];
                        [Language_status synchronize];
                        
                        
                        
                        NSLog(@"some text..%@",result);
                    
    
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                        ViewController *dest = [storyboard instantiateViewControllerWithIdentifier:@"landing"];
                        [self.navigationController pushViewController:dest animated:YES];
                        
                    }
                  // else if ([[result objectForKey:@"message"] isEqualToString:Login_Failed])
                    else
                    {
                        Alert = [[UIAlertView alloc]initWithTitle:nil message:Login_Failed delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [Alert show];
                        
                       // _email.text = @"";
                        _password.text = @"";
                        
                        [_spinn setHidden:YES];
                    }
                }
                else if (error)
                {
                    NSLog(@"error  %@", error);
                    
                    [_spinn setHidden:YES];
                }
                
            }];
            
            
        
        }

    }
}
- (IBAction)openPicker:(id)sender {
    
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    
    
    if(kinderPickerBackView.hidden == NO){
       
            kinderPickerBackView.hidden=YES;
            self.demoviewGray.hidden = YES;
         
       
    
    }else{
 
            
            kinderPickerBackView.hidden=NO;
            self.demoviewGray.hidden = NO;
        
    }
    

}
- (IBAction)clickedOnOk:(id)sender {
    
    selectedKinderId = [[[kinderArray objectAtIndex:selectedIndex] objectForKey:@"id"] integerValue];
    kinderPickerBackView.hidden=YES;
    self.demoviewGray.hidden = YES;
    
    self.selectKinderLbl.text = [[kinderArray objectAtIndex:selectedIndex] objectForKey:@"site_name"];
    
    
}

- (IBAction)clickedOnCancel:(id)sender {
    
    kinderPickerBackView.hidden=YES;
    self.demoviewGray.hidden = YES;
}
@end

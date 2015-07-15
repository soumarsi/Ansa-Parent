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




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GlobalClass = [[TGGlobalClass alloc]init];
    
    kinderArray=[[NSMutableArray alloc]init];
    
    _selectKindergardenBtn.layer.opacity=0.9;
    
    
    
    kinderPicekr.hidden=YES;
    
//   _email.text = @"aljo@olivant.fo";
//  _password.text = @"123456";
    //[_email becomeFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
 
    [textField resignFirstResponder];
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)kindergardenFunc:(id)sender
{
    
    [GlobalClass GlobalDict:[NSString stringWithFormat:@"%@allkinder.php",App_Domain_Url] Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        if(result)
        {
        
            kinderArray=[result mutableCopy];
            
            NSLog(@"Kindergarden list.... %@",kinderArray);
        
        }
        
        
    }];
    
    
    
}

-(void)openKinderPicker
{

    
    


}


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
            
        }else{
            
            [_email resignFirstResponder];
            [_password resignFirstResponder];
        
            [GlobalClass GlobalDict:[NSString stringWithFormat:@"%@login_parent.php?email=%@&password=%@",App_Domain_Url,[_email.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_password.text] Globalstr:@"array" Withblock:^(id result, NSError *error) {
               
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
@end

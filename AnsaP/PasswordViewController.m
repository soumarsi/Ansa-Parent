//
//  PasswordViewController.m
//  AnsaP
//
//  Created by Rahul Singha Roy on 12/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "PasswordViewController.h"
#import "Left.h"
#import "NotesViewController.h"
#import "TGGlobalClass.h"
#import "Ansap.pch"
@interface PasswordViewController ()<Leftdelegate>

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///---/// Language Change ///---///
    
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
    {
        
        [_header_title setText:[NSString PasswordD]];
        
        _old_password.placeholder=@"Nuværende password";
        _New_password.placeholder=@"Nyt password";
        _confirm_password.placeholder=@"Bekræft nyt password";
        
        [_save_btn setTitle:@"Opdater" forState:UIControlStateNormal];
    }
   
    
    
    leftbar_status=0;
    
    object=[[Left alloc]init];
    object.frame=CGRectMake(-self.view.frame.size.width*1.4,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
    [object TapCheck:8];
    [object setHidden:YES];
    object.Delegate=self;
    [self.view addSubview:object];
    
    
    
    _save_btn.layer.cornerRadius=3;
    
    
    
    
}
- (IBAction)Leftmenu:(id)sender
{
    [object setHidden:NO];
    
    if (leftbar_status==0)
    {
        [UIView transitionWithView:_baseview duration:0.5 options:UIViewAnimationOptionCurveEaseIn animations:
         ^{
             
             
             
             object.frame=CGRectMake(0,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
             
             
             [_baseview setFrame:CGRectMake(+_baseview.frame.size.width*0.7,0,_baseview.frame.size.width,_baseview.frame.size.height)];
             
             leftbar_status=1;
             
             
         }
                        completion:^(BOOL finished)
         {
             
             
         }];
        
        
    }
    else
    {
        [UIView transitionWithView:_baseview duration:0.4 options:UIViewAnimationOptionCurveEaseIn animations:
         ^{
             
             
             object.frame=CGRectMake(-self.view.frame.size.width*1.4,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
             
             
             [_baseview setFrame:CGRectMake(0,0,_baseview.frame.size.width, _baseview.frame.size.height)];
             
             leftbar_status=0;
             
             
         }
                        completion:nil];    }
    
    
    
    
}
-(void)pushmethod:(UIButton *)sender
{
    NSLog(@"test on....%ld",(long)sender.tag);
    
    
    
    if (sender.tag==1)
    {
        
        PasswordViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if (sender.tag==5)
    {
        PasswordViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"sjukurPage"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if (sender.tag==3)
    {
        NotesViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"NotesPage"];
        obj.Change_Page=@"Page_mode1";
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==2)
    {
        NotesViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"NotesPage"];
        obj.Change_Page=@"Page_mode2";
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==6)
    {
        PasswordViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"FriPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==7)
    {
        PasswordViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==4)
    {
        PasswordViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==8)
    {
        PasswordViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"PasswordPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }

    else
    {
        
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save_button:(id)sender
{
    
    if ([_old_password.text isEqualToString:@""]&&[_New_password.text isEqualToString:@""]&&[_confirm_password.text isEqualToString:@""])
    {
        
          }
             else if ([_old_password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
              {
        
                }
             else if ([_New_password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
               {
    
                }
         else if ([_confirm_password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1)
          {
    
          }
    else if (![_New_password.text isEqualToString:_confirm_password.text])
    {
        _confirm_password.text=@"";
        _confirm_password.placeholder=@"password not matched";
    }
    else
    {
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
      NSString  *subadminID= [standardUserDefaults stringForKey:@"subAdminId"];
      NSString  *roomID=[standardUserDefaults stringForKey:@"room_id"];
      NSString  *ParentID=[standardUserDefaults stringForKey:@"id"];


        
        TGGlobalClass *globalobj=[[TGGlobalClass alloc]init];
        [globalobj GlobalDict:[NSString stringWithFormat:@"%@change_pass.php?room_id=%@&subAdminId=%@&parent_id=%@&CurrPassword=%@&ConPAssword=%@",App_Domain_Url,roomID,subadminID,ParentID,_old_password.text,_confirm_password.text] Globalstr:@"str" Withblock:^(id result, NSError *error)
         
         {
        
             if ([result isEqualToString:@"success"])
             {
                 PasswordViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
                 [self.navigationController pushViewController:obj animated:YES];
                 
                 UIAlertView *password_alert=[[UIAlertView alloc]initWithTitle:@"Password Changed" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [password_alert show];

             }
             else
             {
                 UIAlertView *password_alert=[[UIAlertView alloc]initWithTitle:@"Wrong Password" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [password_alert show];
                 
                 _old_password.text=@"";
                 _New_password.text=@"";
                 _confirm_password.text=@"";
                 
                 [_old_password resignFirstResponder];
                 [_New_password resignFirstResponder];
                 [_confirm_password resignFirstResponder];
             }
             
        
             NSLog(@"password change Data...%@",result);
             
             
             
         }];
        
        
        
    }

    
    
    
    
    
    
    
    
}
@end

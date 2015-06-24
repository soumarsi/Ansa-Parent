//
//  SjukurViewController.m
//  AnsaP
//
//  Created by Rahul Singha Roy on 08/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "SjukurViewController.h"
#import "NotesViewController.h"
#import "DashboardViewcontroller.h"
#import "TGGlobalClass.h"
#import "Ansap.pch"
@interface SjukurViewController ()<Leftdelegate>
{
        BOOL leftbar_status;
    TGGlobalClass *global;
}

@end

@implementation SjukurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ///---/// Language Change ///---///
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
    {
        [_header_title setText:[NSString SickF]];
        
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"status"] isEqualToString:@"Y"])
        {
            _sjukarLabel.text = @"Ikki sjúk/ur í dag?";
        }
        else
        {
            _sjukarLabel.text = @"Sjúk/ur í dag?";
        }

        [self.NoButton setTitle:@"Nei" forState:UIControlStateNormal];
       
}
    else
    {
         [_header_title setText:[NSString SickD]];
        
        
   
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"status"] isEqualToString:@"YES"])
        {
            _sjukarLabel.text = @"Ikke syg idag?";
        }
        else
        {
            _sjukarLabel.text = @"Syg idag?";
        }

        
        [self.NoButton setTitle:@"Nej" forState:UIControlStateNormal];
        
    }

    
    
    
    
    object=[[Left alloc]init];
    object.frame=CGRectMake(-self.view.frame.size.width*1.4,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
    object.Delegate=self;
    [object setHidden:YES];
    [object TapCheck:5];
    [self.view addSubview:object];
    
    global = [[TGGlobalClass alloc]init];
    
    
    
    // Do any additional setup after loading the view.
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

- (IBAction)yesbtn:(id)sender
{
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"status"] isEqualToString:@"Y"])
    {
    
    [global GlobalDict:[NSString stringWithFormat:@"%@parent_sick_unsick.php?subAdminId=%@&room_id=%@&children_id=%@&change_type=1",App_Domain_Url,[[NSUserDefaults standardUserDefaults]objectForKey:@"subAdminId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"room_id"],[[NSUserDefaults standardUserDefaults]objectForKey:@"child_id"]] Globalstr:@"string" Withblock:^(id result, NSError *error) {
        
        
        
        SjukurViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
        [self.navigationController pushViewController:obj animated:YES];

        
    }];
    }
    else
    {
        [global GlobalDict:[NSString stringWithFormat:@"%@parent_sick_unsick.php?subAdminId=%@&room_id=%@&children_id=%@&change_type=0",App_Domain_Url,[[NSUserDefaults standardUserDefaults]objectForKey:@"subAdminId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"room_id"],[[NSUserDefaults standardUserDefaults]objectForKey:@"child_id"]] Globalstr:@"string" Withblock:^(id result, NSError *error) {
            
            
            
            SjukurViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
            [self.navigationController pushViewController:obj animated:YES];
            
            
        }];

    }
    

}

- (IBAction)nobtn:(id)sender
{
    
    SjukurViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
    [self.navigationController pushViewController:obj animated:YES];
    

}

-(void)pushmethod:(UIButton *)sender
{
    NSLog(@"test on");
    
    if (sender.tag==1)
    {
        
        SjukurViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if (sender.tag==5)
    {
        SjukurViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"sjukurPage"];
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
        SjukurViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"FriPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==7)
    {
        SjukurViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==4)
    {
        SjukurViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==8)
    {
        SjukurViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"PasswordPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }

    else
    {
        
    }
    
}

- (IBAction)leftmenu:(id)sender {
    [object setHidden:NO];
    
    if (leftbar_status==0)
    {
        [UIView transitionWithView:_mainview duration:0.5 options:UIViewAnimationOptionCurveEaseIn animations:
         ^{
             
             
             
             object.frame=CGRectMake(0,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
             
             
             [_baseview setFrame:CGRectMake(+self.view.frame.size.width*0.7,0,_baseview.frame.size.width,_baseview.frame.size.height)];
             
             leftbar_status=1;
             
         }
                        completion:^(BOOL finished)
         {
             
             
         }];
        
        
    }
    else
    {
        [UIView transitionWithView:_mainview duration:0.4 options:UIViewAnimationOptionCurveEaseIn animations:
         ^{
             
             
             object.frame=CGRectMake(-self.view.frame.size.width*1.4,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
             
             
             [_baseview setFrame:CGRectMake(0,0,_baseview.frame.size.width, _baseview.frame.size.height)];
             
             leftbar_status=0;
             
         }
                        completion:nil];
    }
    
    

}
@end

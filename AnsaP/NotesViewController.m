//
//  NotesViewController.m
//  AnsaP
//
//  Created by Rahul Singha Roy on 07/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "NotesViewController.h"
#import "Left.h"
#import "NoteTableViewCell.h"
#import "TGGlobalClass.h"
#import "Ansap.pch"
#import "DashboardViewcontroller.h"
@interface NotesViewController ()<UITableViewDataSource,UITableViewDelegate,Leftdelegate>

@end
@implementation NotesViewController
@synthesize Change_Page;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    leftbar_status=0;
    
  
    NSLog(@"Page Status...%@",Change_Page);
    
    [_baseview addSubview:_NodataFound];
    
    
    //--//
    
    [_spinn setHidden:NO];
    
    server_data=[[NSMutableArray alloc]init];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *subadminID= [standardUserDefaults stringForKey:@"subAdminId"];
    NSString *childrenID= [standardUserDefaults stringForKey:@"child_id"];
    NSString *roomID=[standardUserDefaults stringForKey:@"room_id"];

    NSLog(@"Testing Data...%@",roomID);
    
    
    
    if ([Change_Page isEqualToString:@"Page_mode2"])
    {
        
        
        object=[[Left alloc]init];
        object.frame=CGRectMake(-self.view.frame.size.width*1.4,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
        object.Delegate=self;
        [object setHidden:YES];
        [object TapCheck:2];
        [self.view addSubview:object];
        
        
        ///---/// Language Change ///---///
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
        {
            [_header_title setText:[NSString NewsF]];
        }
        else
        {
            [_header_title setText:[NSString NewsD]];
        }

        
        TGGlobalClass *globalobj=[[TGGlobalClass alloc]init];
        [globalobj GlobalDict:[NSString stringWithFormat:@"%@individual_news.php?room_id=%@&subAdminId=%@",App_Domain_Url,roomID,subadminID] Globalstr:@"array" Withblock:^(id result, NSError *error) {
            
            server_data=[result mutableCopy];
            
            NSLog(@"Server Data...%@",server_data);
            
            if (server_data.count == 0)
            {
                _NodataFound.hidden = NO;
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
                {
                    self.nodatafound.text = @"Eingi nýggj tíðindi….";
                }
                else
                {
                    self.nodatafound.text = @"Ingen nyhed";
                }
                
            }
            else
            {
                _NodataFound.hidden = YES;
                 [_maintable reloadData];
            }
            
           
            
            [_spinn setHidden:YES];
        }];

    }
    else
    {
        
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
        {
            [_header_title setText:[NSString NotesF]];
        }
        else
        {
            [_header_title setText:[NSString NotesD]];
        }

        
        
        object=[[Left alloc]init];
        object.frame=CGRectMake(-self.view.frame.size.width*1.4,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
        object.Delegate=self;
        [object setHidden:YES];
        [object TapCheck:3];
        [self.view addSubview:object];
        
        
    
    TGGlobalClass *globalobj=[[TGGlobalClass alloc]init];
    [globalobj GlobalDict:[NSString stringWithFormat:@"%@unread_notes.php?room_id=%@&subAdminId=%@&children_id=%@",App_Domain_Url,roomID,subadminID,childrenID] Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        server_data=[result mutableCopy];
        
        NSLog(@"Server Data...%@",server_data);
        
        
        if (server_data.count == 0)
        {
            _NodataFound.hidden = NO;
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
            {
                self.nodatafound.text = @"Eingi nýggj boð….";
            }
            else
            {
               self.nodatafound.text = @"Ingen ny besked….";
            }
        }
        else
        {
            _NodataFound.hidden = YES;
        [_maintable reloadData];
        }
         [_spinn setHidden:YES];
    }];

    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return server_data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.backgroundColor=[UIColor clearColor];
    
     if ([Change_Page isEqualToString:@"Page_mode2"])
     {
         
         UIFont *font1 = [UIFont fontWithName:@"MyriadPro-Light" size:20];
         NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
         NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[[server_data objectAtIndex:indexPath.row]objectForKey:@"news_desc"] attributes: arialDict];
         
         CGRect rect;
         
         rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
         
         cell.description.attributedText=aAttrString1;
         
         cell.description.numberOfLines = 0;
         cell.description.clipsToBounds = YES;
         
         NSString *getfulldate=[NSString stringWithFormat:@"%@",[[server_data objectAtIndex:indexPath.row]objectForKey:@"posted_on"]];
         
         NSArray *Datearray = [getfulldate componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
         
         cell.date.text=[NSString stringWithFormat:@"%@",[Datearray objectAtIndex:1]];
         
         cell.month_year.text=[NSString stringWithFormat:@"%@ %@",[Datearray objectAtIndex:0],[Datearray objectAtIndex:2]];
         
         cell.description.frame = CGRectMake(90, 1, 230, rect.size.height+47);
         cell.DateView.frame =CGRectMake(0, 1, 82, rect.size.height+48);
         
         cell.lineView.frame = CGRectMake(1, rect.size.height + 49.0f, self.view.frame.size.width-2, 0.5f);

     }
    else
    {
    
        UIFont *font1 = [UIFont fontWithName:@"MyriadPro-Light" size:20];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[[server_data objectAtIndex:indexPath.row]objectForKey:@"notes"] attributes: arialDict];
        
        CGRect rect;
        
        rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        
        cell.description.attributedText=aAttrString1;

        cell.description.numberOfLines = 0;
        cell.description.clipsToBounds = YES;
    
    NSString *getfulldate=[NSString stringWithFormat:@"%@",[[server_data objectAtIndex:indexPath.row]objectForKey:@"posted_on"]];

    NSArray *Datearray = [getfulldate componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    cell.date.text=[NSString stringWithFormat:@"%@",[Datearray objectAtIndex:1]];
    
    cell.month_year.text=[NSString stringWithFormat:@"%@ %@",[Datearray objectAtIndex:0],[Datearray objectAtIndex:2]];
    
        cell.description.frame = CGRectMake(90, 1, 230, rect.size.height+47);
        cell.DateView.frame =CGRectMake(0, 1, 82, rect.size.height+48);
        
        cell.lineView.frame = CGRectMake(1, rect.size.height + 49.0f, self.view.frame.size.width-2, 0.5f);
    
    }
    
    return cell;


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([Change_Page isEqualToString:@"Page_mode2"])
    {
    
    UIFont *font1 = [UIFont fontWithName:@"MyriadPro-Light" size:20];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[[server_data objectAtIndex:indexPath.row]objectForKey:@"news_desc"] attributes: arialDict];
    
    CGRect rect;
    
    rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    
    return rect.size.height + 50;
    }
    else
    {
        UIFont *font1 = [UIFont fontWithName:@"MyriadPro-Light" size:20];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[[server_data objectAtIndex:indexPath.row]objectForKey:@"notes"] attributes: arialDict];
        
        CGRect rect;
        
        rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        
        
        return rect.size.height + 50;
    }
    return 0;
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

- (IBAction)Leftmenu:(id)sender
{
    
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
                        completion:nil];    }
    
    
    

}
-(void)pushmethod:(UIButton *)sender
{
    NSLog(@"test on");
    
    if (sender.tag==1)
    {
        
        NotesViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if (sender.tag==5)
    {
        NotesViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"sjukurPage"];
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
        NotesViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"FriPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==7)
    {
        NotesViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==4)
    {
        NotesViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==8)
    {
        NotesViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"PasswordPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }

    else
    {
        
    }
    
}

@end

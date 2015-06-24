//
//  FreeViewController.m
//  AnsaP
//
//  Created by Rahul Singha Roy on 09/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "FreeViewController.h"
#import "Left.h"
#import "TGGlobalClass.h"
#import "Ansap.pch"
#import "NotesViewController.h"
#import "FreeTableViewCell.h"
@interface FreeViewController ()<Leftdelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation FreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
    {
        [_header_title setText:[NSString FreeD]];
        
        _from_date.text=@"Fra dato";
        _till_date.text=@"Til Dato";
        
        [_submit_button setTitle:[NSString stringWithFormat:@"Gem"] forState:UIControlStateNormal];



    }
    
    
    
    picker_open=0;
    ticbool=0;

    object=[[Left alloc]init];
    object.frame=CGRectMake(-self.view.frame.size.width*1.4,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
    [object TapCheck:6];
    [object setHidden:YES];
    object.Delegate=self;
    [self.view addSubview:object];
    
    
    remove_array=[[NSMutableArray alloc]init];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
    datelist_array=[[NSMutableArray alloc]init];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    subadminID= [standardUserDefaults stringForKey:@"subAdminId"];
    childrenID= [standardUserDefaults stringForKey:@"child_id"];
    roomID=[standardUserDefaults stringForKey:@"room_id"];
    
    TGGlobalClass *globalobj=[[TGGlobalClass alloc]init];
    [globalobj GlobalDict:[NSString stringWithFormat:@"%@freelist.php?subAdminId=%@&room_id=%@&children_id=%@",App_Domain_Url,subadminID,roomID,childrenID]Globalstr:@"array"  Withblock:^(id result, NSError *error)
     
     {
         //NSString *data_str=[[NSString alloc]init];
         
         for (NSString *str in result )
         {
             [datelist_array addObject:str];
         }
         
         
         NSLog(@"Server Data...%@",datelist_array);
         
         [_datelist_table reloadData];
         
         
     }];
    
    

    
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
-(void)pushmethod:(UIButton *)sender
{
    NSLog(@"test on....%ld",(long)sender.tag);
    
    
    
    if (sender.tag==1)
    {
        
        FreeViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if (sender.tag==5)
    {
        FreeViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"sjukurPage"];
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
        FreeViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"FriPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==7)
    {
        FreeViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==4)
    {
        FreeViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==8)
    {
        FreeViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"PasswordPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }

    else
    {
        
    }
    
}

- (IBAction)leftmenu:(id)sender
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datelist_array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
   
    
    
    cell.Date_Title.text=[NSString stringWithFormat:@"%@",[datelist_array objectAtIndex:indexPath.row]];

    
    tickimage=[[UIImageView alloc]initWithFrame:CGRectMake(84, 13, 35, 29)];
    tickimage.image=[UIImage imageNamed:@"tickimg"];
    tickimage.tag=indexPath.row;
    [cell addSubview:tickimage];
    
    
    BOOL contains = [remove_array containsObject:[datelist_array objectAtIndex:indexPath.row]];
    
    
    if (contains)
    {
        NSLog(@"#######");
        [tickimage setImage:[UIImage imageNamed:@"unticimg"]];
    }

    
    
    cell.tag=indexPath.row;
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 56;
}

- (IBAction)Calendar_open:(UIButton *)sender
{
    NSDate *myDate = _date_picker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    finaldate = [dateFormat stringFromDate:myDate];
    
    [_date_picker setMinimumDate:_date_picker.date];
    
    getting_sender=(int)sender.tag;
    
    if (picker_open==0)
    {
        [UIView transitionWithView:_datepickerbase duration:0.9 options:UIViewAnimationOptionTransitionFlipFromBottom animations:
         ^{
             
             [_datepickerbase setHidden:NO];
             
             picker_open=1;
             
             
         }
                        completion:^(BOOL finished)
         {
             
             
         }];

    }
    else
    {
        [UIView transitionWithView:_datepickerbase duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:
         ^{
             
             [_datepickerbase setHidden:YES];
             
             picker_open=0;
             
             
         }
                        completion:^(BOOL finished)
         {
             
             
         }];

    }
    
    }
- (IBAction)set_date:(id)sender
{
    NSDate *myDate = _date_picker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    finaldate = [dateFormat stringFromDate:myDate];
    
     [_date_picker setMinimumDate:_date_picker.date];
    
    if (getting_sender==1)
    {
        [UIView transitionWithView:_datepickerbase duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:
         ^{
             
             
            

             [_datepickerbase setHidden:YES];
             
             picker_open=0;
             
             
         }
                        completion:^(BOOL finished)
         {
              _from_date.text=finaldate;
             
             _till_date.text=@"Til Dato";
             
             NSDate *now = _date_picker.date;
             int daysToAdd = 0;
             NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
             
             [_date_picker setMinimumDate:newDate1];
             
         }];

}
    else if (getting_sender==2)
    {
        [UIView transitionWithView:_datepickerbase duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:
         ^{
             
             
             
             
             [_datepickerbase setHidden:YES];
             
             picker_open=0;
             
             
         }
                        completion:^(BOOL finished)
         {
             
                 _till_date.text=finaldate;
        
         }];

    }
    else
    {
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Test New....%@",remove_array);
    
    if (remove_dates.length==0)
    {
         remove_dates=[NSString stringWithFormat:@"%@",[datelist_array objectAtIndex:indexPath.row]];
    }
    else
    {
        remove_dates=[NSString stringWithFormat:@"%@,%@",remove_dates,[datelist_array objectAtIndex:indexPath.row]];
    }
    
    NSLog(@"testing data...%@",remove_dates);
   
    
    FreeTableViewCell *getcell=(FreeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
    NSLog(@"into tap gesture tag:%ld",(long)getcell.tag);
    
    NSArray *subArray=[getcell subviews];
    


        for (UIImageView *img in subArray)
            
        {
            
            if ([img isKindOfClass:[UIImageView class]])
                
            {
               // if (ticbool==0)
              //  {
                
                     [remove_array addObject:[datelist_array objectAtIndex:indexPath.row]];
                    [img setImage:[UIImage imageNamed:@"unticimg"]];
                
        
                
             //       ticbool=1;
             //   }
             //   else
              //  {
                    
             //        [remove_array removeObject:[datelist_array objectAtIndex:indexPath.row]];
             //       [img setImage:[UIImage imageNamed:@"tickimg"]];
                    
                    
                    
              //      ticbool=0;
             //   }
                
                
            }
            
            
        }
        
    

    
}

- (IBAction)submit_button:(id)sender
{
    
    
    if ([_from_date.text isEqualToString:@"Frá dato"]||[_till_date.text isEqualToString:@"Til Dato"])
    {
        TGGlobalClass *globalobj=[[TGGlobalClass alloc]init];
        [globalobj GlobalDict:[NSString stringWithFormat:@"%@free_parent.php?subAdminId=%@&room_id=%@&children_id=%@&FromFree=&ToFree=&removeFromFree=%@",App_Domain_Url,subadminID,roomID,childrenID,remove_dates] Globalstr:@"" Withblock:^(id result, NSError *error)
         
         {
             
             
             NSLog(@"Update Data...%@",result);
             
             [self viewDidAppear:YES];

             
         }];

    }
    else
    {
    
    TGGlobalClass *globalobj=[[TGGlobalClass alloc]init];
    [globalobj GlobalDict:[NSString stringWithFormat:@"%@free_parent.php?subAdminId=%@&room_id=%@&children_id=%@&FromFree=%@&ToFree=%@&removeFromFree=%@",App_Domain_Url,subadminID,roomID,childrenID,_from_date.text,_till_date.text,remove_dates] Globalstr:@"array" Withblock:^(id result, NSError *error)
     
     {
         
         
         NSLog(@"Update Data...%@",result);
         
         [self viewDidAppear:YES];
         
         
     }];
        

        
    }
    
}

@end

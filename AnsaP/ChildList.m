//
//  ChildList.m
//  AnsaP
//
//  Created by anirban on 17/07/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "ChildList.h"
//#import "childCell.h"
#import "TGGlobalClass.h"
#import "Ansap.pch"
#import "UIImageView+WebCache.h"
@interface ChildList ()<UITableViewDataSource,UITableViewDelegate>
{
 
    TGGlobalClass *globalobj;
    NSMutableArray *Data_array;
}
@property (weak, nonatomic) IBOutlet UILabel *Children;

@end

@implementation ChildList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _childTbl.delegate=self;
    _childTbl.dataSource=self;
    
    
    _Children.text = [NSString BornF];
    
   NSString  *pid= [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
    globalobj=[[TGGlobalClass alloc]init];
    [globalobj GlobalDict:[NSString stringWithFormat:@"%@childList.php?pid=%@",App_Domain_Url,pid]Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        Data_array=[[NSMutableArray alloc]init];
        Data_array=[result mutableCopy];
        
        NSLog(@"getting cheld data >>>>> %@",Data_array);
        
        [_childTbl reloadData];
        
         }];
    
    
   getindex= [[NSUserDefaults standardUserDefaults] integerForKey:@"check_tick_id"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Data_array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    UIImageView *child_image=[[UIImageView alloc]initWithFrame:CGRectMake(10,10,70,70)];
    child_image.layer.cornerRadius=70.0f/2;
    child_image.clipsToBounds=YES;
    [cell addSubview:child_image];
    
    NSLog(@">>>>>>>> %@",[NSString stringWithFormat:@"%@%@",App_Image_Url2,[[Data_array objectAtIndex:indexPath.row]objectForKey:@"photo"]]);
    
    [child_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",App_Image_Url2,[[Data_array objectAtIndex:indexPath.row]objectForKey:@"photo"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];

    
    UILabel *child_name=[[UILabel alloc]initWithFrame:CGRectMake(child_image.frame.origin.x+90, 15,200, 40)];
    child_name.font=[UIFont fontWithName:@"MyriadPro" size:15];
    child_name.text=[NSString stringWithFormat:@"%@",[[Data_array objectAtIndex:indexPath.row]objectForKey:@"name"]];
    child_name.textColor=[UIColor darkGrayColor];
    child_name.textAlignment=NSTextAlignmentLeft;
    [cell addSubview:child_name];
    
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,99,[UIScreen mainScreen].bounds.size.width,1)];
    line.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.8f];
    [cell addSubview:line];
    
    
    UIImageView *tickimage=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50,15,42,42)];
   
    tickimage.tag=011;
    [cell addSubview:tickimage];
    
    if (indexPath.row==getindex)
    {
         tickimage.image=[UIImage imageNamed:@"tick2"];
    }
    else
    {
         tickimage.image=[UIImage imageNamed:@""];
    }
    
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=NO;
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
   NSUserDefaults *UserData = [[NSUserDefaults alloc]init];
    
    NSMutableDictionary *child_data=[[NSMutableDictionary alloc]init];
    child_data=[[Data_array objectAtIndex:indexPath.row] mutableCopy];
    
    NSLog(@">>>>>>>>###### %@",child_data);
    
    [UserData setObject:[child_data objectForKey:@"room_id"] forKey:@"room_id"];
    [UserData setObject:[child_data objectForKey:@"id"] forKey:@"child_id"];
    [UserData setObject:[child_data objectForKey:@"name"] forKey:@"child_name"];
    [UserData setObject:[child_data objectForKey:@"photo"] forKey:@"photo"];
    [UserData synchronize];
    
    UITableViewCell *getcell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSArray *subArray=[getcell subviews];
    
    for (UIImageView *img in subArray)
        
    {
        
        if ([img isKindOfClass:[UIImageView class]])
            
        {
            if (img.tag==011)
            {
                
            img.image=[UIImage imageNamed:@"tick2"];
                     
            getindex=indexPath.row;
                     
           [_childTbl reloadData];
      
        [UserData  setInteger:getindex forKey:@"check_tick_id"];
        [UserData synchronize];
                
    [self performSelector:@selector(gotoMainPage) withObject:nil afterDelay:0.5];
               
            }
            
            
            
        }
        
        
    }

    
    


}


-(void)gotoMainPage
{
    ChildList *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
    [self.navigationController pushViewController:obj animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back_button:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end

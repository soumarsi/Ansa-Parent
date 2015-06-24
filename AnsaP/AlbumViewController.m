//
//  AlbumViewController.m
//  AnsaP
//
//  Created by Rahul Singha Roy on 11/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "AlbumViewController.h"
#import "Left.h"
#import "TGGlobalClass.h"
#import "Ansap.pch"
#import "NotesViewController.h"
#import "AlbumCollectionViewCell.h"
#import "AlbumCollectionReusableView.h"
#import "UIImageView+WebCache.h"

@interface AlbumViewController ()<Leftdelegate>

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ///---/// Language Change ///---///
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
    {
        [_header_title setText:[NSString GalleryF]];
    }
    else
    {
        [_header_title setText:[NSString GalleryD]];
    }
    
    
    object=[[Left alloc]init];
    object.frame=CGRectMake(-self.view.frame.size.width*1.4,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
    [object TapCheck:4];
    [object setHidden:YES];
    object.Delegate=self;
    [self.view addSubview:object];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_spinn setHidden:NO];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *subadminID= [standardUserDefaults stringForKey:@"subAdminId"];
    NSString *roomID=[standardUserDefaults stringForKey:@"room_id"];
    
    
    TGGlobalClass *globalobj=[[TGGlobalClass alloc]init];
    [globalobj GlobalDict:[NSString stringWithFormat:@"%@parent_album.php?subAdminId=%@&room_id=%@",App_Domain_Url,subadminID,roomID] Globalstr:@"array" Withblock:^(id result, NSError *error)
     
     {
         
         server_data=[[NSMutableArray alloc]init];
         
         result2=[[NSMutableArray alloc]init];
         
         result2=[result mutableCopy];
         
         
         if (result2.count>0)
         {
             
             result2=[[NSMutableArray alloc]init];
             
             result2=[result mutableCopy];
             
             
             
             for (int i=0;i<result2.count; i++)
             {
                 [server_data addObject:[result2 objectAtIndex:i]];
             }
             
             
             NSLog(@"Album Data....%@",[[server_data objectAtIndex:0]objectForKey:@"album_images"]);
             
             
             [_collection_view reloadData];
             
             [_spinn setHidden:YES];
             
         }
         else
         {
             if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
             {
                 _Alert_lable.text=@"Einki funnið . .";
                 [_Alert_view setHidden:NO];
                 
             }
             else
             {
                 _Alert_lable.text=@"Ingen data . .";
                 [_Alert_view setHidden:NO];
             }
             
             [_spinn setHidden:YES];
             
         }
         
         
         
         
         
         
         
         
         
         
     }];
    
    
    
}

-(void)pushmethod:(UIButton *)sender
{
    NSLog(@"test on....%ld",(long)sender.tag);
    
    
    
    if (sender.tag==1)
    {
        
        AlbumViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if (sender.tag==5)
    {
        AlbumViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"sjukurPage"];
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
        AlbumViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"FriPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==7)
    {
        AlbumViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==4)
    {
        AlbumViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==8)
    {
        AlbumViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"PasswordPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    
    else
    {
        
    }
    
}

- (IBAction)leftmenu:(id)sender
{
    [object setHidden:NO];
    
    [_spinn setHidden:YES];
    
    [_Alert_view setHidden:YES];
    
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[server_data objectAtIndex:section]objectForKey:@"album_images"]count];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return server_data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    [cell.cell_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",App_Image_Url,[[[[server_data objectAtIndex:indexPath.section]objectForKey:@"album_images"]objectAtIndex:indexPath.row]objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"demoimage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    // cell.cell_image.clipsToBounds = YES;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        return CGSizeMake(118, 118);
    }
    else
    {
        return CGSizeMake(100, 100);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"sectionView";
    
    AlbumCollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
    
    supplementaryView.Section_title.text=[NSString stringWithFormat:@"    %@",[[server_data objectAtIndex:indexPath.section]objectForKey:@"album_name"]];
    
    
    return supplementaryView;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"getting index path ..... %ld",(long)indexPath.row);
    
    
    [_photo_scroll setContentSize:CGSizeMake(self.view.frame.size.width*[[[server_data objectAtIndex:indexPath.section]objectForKey:@"album_images"]count], self.view.frame.size.height)];
    
    
    [_photo_scroll setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width*indexPath.row, 0) animated:NO];
    
    
    
    [_cross_btn setHidden:NO];
    [_photo_view setHidden:NO];
    
    
    Description_TXTview=[[UITextView alloc]initWithFrame:CGRectMake(0,428,[UIScreen mainScreen].bounds.size.width,115)];
    Description_TXTview.editable=NO;
    Description_TXTview.font=[UIFont fontWithName:@"MyriadPro-Regular" size:16];
    Description_TXTview.backgroundColor=[UIColor clearColor];
    Description_TXTview.showsVerticalScrollIndicator=NO;
    Description_TXTview.textColor=[UIColor whiteColor];
    Description_TXTview.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:Description_TXTview];
    
    
    Description_TXTview.text=[NSString stringWithFormat:@"%@",[[server_data objectAtIndex:indexPath.section]objectForKey:@"album_desc"]];
    
    
    
    int AX=0;
    
    for (int p=0;p<[[[server_data objectAtIndex:indexPath.section]objectForKey:@"album_images"]count]; p++)
    {
        
        zoom_image=[[UIImageView alloc]initWithFrame:CGRectMake(AX, [UIScreen mainScreen].bounds.origin.y+150,[UIScreen mainScreen].bounds.size.width,250)];
        
        [_photo_scroll addSubview:zoom_image];
        
        [zoom_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",App_Image_Url,[[[[server_data objectAtIndex:indexPath.section]objectForKey:@"album_images"]objectAtIndex:p]objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
        
        zoom_image.layer.borderColor=[UIColor whiteColor].CGColor;
        zoom_image.layer.borderWidth=2.0;
        
        AX=AX+[UIScreen mainScreen].bounds.size.width;
        
    }
    
    NSLog(@"Image Count...%lu",(unsigned long)[[[server_data objectAtIndex:indexPath.section]objectForKey:@"album_images"]count]);
    
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

- (IBAction)Photoview_close:(id)sender
{
    
    [Description_TXTview removeFromSuperview];
    
    [_cross_btn setHidden:YES];
    [_photo_view setHidden:YES];
    
    for(UIView *subview in [_photo_scroll subviews]) {
        [subview removeFromSuperview];
    }
    
    [zoom_image removeFromSuperview];
    
}
@end

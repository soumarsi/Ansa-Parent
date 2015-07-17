//
//  DashboardViewcontroller.m
//  AnsaP
//
//  Created by Rahul Singha Roy on 07/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "DashboardViewcontroller.h"
#import "Left.h"
#import "NotesViewController.h"
#import "TGGlobalClass.h"
#import "Ansap.pch"
#import "DashboardTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface UIViewController ()<Leftdelegate>
{
    
}
@end
@implementation DashboardViewcontroller

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    ///---/// Language Change ///---///
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
    {
        [_Header_titel setText:[NSString HomeF]];
        [_Table_header_title setText:[NSString NewsF]];
        [_FirstButton setTitle:[NSString BTN1F] forState:UIControlStateNormal];
        [_Secondbutton setTitle:[NSString BTN2F] forState:UIControlStateNormal];
        [_thirdbutton setTitle:[NSString BTN3F] forState:UIControlStateNormal];
        [_fourthbutton setTitle:[NSString BTN4F] forState:UIControlStateNormal];
        
        
    }
    else
    {
        [_Header_titel setText:[NSString HomeD]];
        [_Table_header_title setText:[NSString NewsD]];
        
        [_FirstButton setTitle:[NSString BTN1D] forState:UIControlStateNormal];
        [_Secondbutton setTitle:[NSString BTN2D] forState:UIControlStateNormal];
        [_thirdbutton setTitle:[NSString BTN3D] forState:UIControlStateNormal];
        [_fourthbutton setTitle:[NSString BTN4D] forState:UIControlStateNormal];
        
        
    }
    
    
    ///---///
    
    
    downtoolbar=0;
    leftbar_status=0;
    
    _notes_table.separatorStyle=NO;
    
    
    //--//
    self.view.userInteractionEnabled=YES;
    object=[[Left alloc]init];
    object.frame=CGRectMake(-self.view.frame.size.width*1.4,0,self.view.frame.size.width*0.7,self.view.frame.size.height);
    [object TapCheck:1];
    [object setHidden:YES];
    object.Delegate=self;
    [self.view addSubview:object];
    
    
    _ParentName.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"child_name"]];
    server_data=[[NSMutableArray alloc]init];
    pagedata=[[NSMutableArray alloc]init];
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *subadminID= [standardUserDefaults stringForKey:@"subAdminId"];
    NSString *childrenID= [standardUserDefaults stringForKey:@"child_id"];
    NSString *roomID=[standardUserDefaults stringForKey:@"room_id"];
    NSString *Photo_link=[standardUserDefaults stringForKey:@"photo"];
    
    
    NSLog(@"photo------ %@", [[NSUserDefaults standardUserDefaults]objectForKey:@"photo"]);
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"gender"] isEqualToString:@"M"])
    {
         [_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://ansa.fo/upload/children_photo/thumb/%@",Photo_link]] placeholderImage:[UIImage imageNamed:@"maleimage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    }
    
    else
    {
    [_profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://ansa.fo/upload/children_photo/thumb/%@",Photo_link]] placeholderImage:[UIImage imageNamed:@"femaleimage"] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    }
    _profile_image.layer.cornerRadius=51/2;
    _profile_image.clipsToBounds=YES;
   
    
    
    
    globalobj=[[TGGlobalClass alloc]init];
    [globalobj GlobalDict:[NSString stringWithFormat:@"%@parentnews_list.php?room_id=%@&subAdminId=%@&children_id=%@",App_Domain_Url,roomID,subadminID,childrenID]Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        Data_dictionary=[[NSMutableDictionary alloc]init];
        
        Data_dictionary=[result mutableCopy];
        
        id result2=[result objectForKey:@"newslist"];
        
        server_data=[result2 mutableCopy];
        
        pagedata=[result objectForKey:@"notelist"];
        
        NSLog(@"Dashboard Data...%@ %lu",pagedata, (unsigned long)pagedata.count);
        
        
        [_notes_table reloadData];
        
        
        int X1=0;
        
        if (pagedata.count == 0)
        {
            _Page_Scroll.scrollEnabled=NO;
            
            pageview1=[[UIView alloc]initWithFrame:CGRectMake(X1,0,self.view.frame.size.width,_Page_Scroll.frame.size.height)];
            pageview1.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(247.0f/255.0f) blue:(107.0f/255.0f) alpha:1];
            [_Page_Scroll addSubview:pageview1];
            
            
            UILabel *NodataFound = [[UILabel alloc]initWithFrame:CGRectMake(30,20, self.view.frame.size.width-70, 40)];
            [NodataFound setBackgroundColor:[UIColor clearColor]];
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
            {
                [NodataFound setText:@"Eingi nýggj boð…."];
            }
            else
            {
                [NodataFound setText:@"Ingen ny besked….."];
            }
            
            [NodataFound setTextAlignment:NSTextAlignmentCenter];
            [NodataFound setTextColor:[UIColor darkGrayColor]];
            [NodataFound setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:19]];
            [pageview1 addSubview:NodataFound];
            
        }
        else
        {
            for (int i= 0 ; i<pagedata.count; i++)
            {
                _Page_Scroll.delegate=self;
                _Page_Scroll.pagingEnabled=YES;
                _Page_Scroll.scrollEnabled=YES;
                
                pageview1=[[UIView alloc]initWithFrame:CGRectMake(X1,0,self.view.frame.size.width,_Page_Scroll.frame.size.height)];
                pageview1.backgroundColor=[UIColor colorWithRed:(255.0f/255.0f) green:(247.0f/255.0f) blue:(107.0f/255.0f) alpha:1];
                [_Page_Scroll addSubview:pageview1];
                NSLog(@"height..%f",pageview1.frame.size.height);
                
                UITextView *pagetitle=[[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+30,10,self.view.frame.size.width-70,90)];
                pagetitle.text=[NSString stringWithFormat:@"%@",[[pagedata objectAtIndex:i]objectForKey:@"notes"]];
                pagetitle.textAlignment=NSTextAlignmentCenter;
                pagetitle.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:19];
                pagetitle.textColor=[UIColor darkGrayColor];
                pagetitle.editable = NO;
                pagetitle.scrollEnabled = YES;
                pagetitle.backgroundColor = [UIColor clearColor];
                pagetitle.indicatorStyle = NO;
                pagetitle.delegate = self;
                [pageview1 addSubview:pagetitle];
                
                checkbox=[[UIButton alloc]initWithFrame:CGRectMake(pageview1.frame.size.width-45,10,35,29)];
                [checkbox setBackgroundImage:[UIImage imageNamed:@"unticimg"] forState:UIControlStateNormal];
                [checkbox setBackgroundImage:[UIImage imageNamed:@"tickimg"] forState:UIControlStateHighlighted];
                [checkbox setBackgroundImage:[UIImage imageNamed:@"tickimg"] forState:UIControlStateSelected];
                pageview1.userInteractionEnabled=YES;
                [checkbox setTitle:@"Ok" forState:UIControlStateNormal];
                checkbox.titleLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:15];
                checkbox.tag = i;
                [checkbox addTarget:self action:@selector(checkBox_Tap:) forControlEvents:UIControlEventTouchUpInside];
                [pageview1 addSubview:checkbox];
                
                
                
                
                UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+35,112,self.view.frame.size.width-75,1)];
                lineview.backgroundColor=[[UIColor lightGrayColor]colorWithAlphaComponent:.7];
                [pageview1 addSubview:lineview];
                
                
                
                UILabel *pagetime=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+32,100,self.view.frame.size.width-70,90)];
                pagetime.text=[NSString stringWithFormat:@"%@",[[pagedata objectAtIndex:i]objectForKey:@"posted_on"]];
                pagetime.numberOfLines=1;
                [pagetime setBackgroundColor:[UIColor clearColor]];
                pagetime.textAlignment=NSTextAlignmentCenter;
                pagetime.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:18];
                pagetime.textColor=[UIColor darkGrayColor];
                [pageview1 addSubview:pagetime];
                
                
                //            _pagecontroll.backgroundColor =[UIColor colorWithRed:(255.0f/255.0f) green:(247.0f/255.0f) blue:(107.0f/255.0f) alpha:1];
                
                X1=X1+pageview1.frame.size.width+1.5;
                
                [_Page_Scroll setContentSize:CGSizeMake(X1,_Page_Scroll.frame.size.height)];
                
                pagecontrolforzoomimage = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 3, self.view.frame.size.width, 18)];
                
                pagecontrolforzoomimage.currentPage = 0;
                
                pagecontrolforzoomimage.currentPageIndicatorTintColor = [UIColor darkGrayColor];
                
                pagecontrolforzoomimage.pageIndicatorTintColor = [UIColor whiteColor];
                
                pagecontrolforzoomimage.numberOfPages = pagedata.count;
                
                [_pagecontroll addSubview:pagecontrolforzoomimage];
                
            }
        }
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[result objectForKey:@"sick"] forKey:@"status"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
        {
            
            NSArray *Date_chunks1 = [[result objectForKey:@"sick_status"] componentsSeparatedByString: @"@@@@"];
            
            NSString *sick_komin=[Date_chunks1 objectAtIndex:0];
            
            if ([sick_komin isEqualToString:@"ARRIVE_AT"])
            {
                
                if ([[Date_chunks1 objectAtIndex:2] isEqualToString:@"00:00:00"])
                {
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Komin:  %@",[Date_chunks1 objectAtIndex:1]];
                }
                else
                {
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Heim:  %@",[Date_chunks1 objectAtIndex:2]];
                }
                
            }else if ([sick_komin isEqualToString:@"SICK"])
                
            {
                
                _FooterUnderLbael.text = [NSString SickF];
                
            }
            
            else if ([sick_komin isEqualToString:@"FREE"])
                
            {
                
                _FooterUnderLbael.text = [NSString FreeF];
                
            }
            else
            {
                _FooterUnderLbael.text = @"Ikki komin";
            }
            
            
            
        }
        else
        {
            NSArray *Date_chunks1 = [[result objectForKey:@"sick_status"] componentsSeparatedByString: @"@@@@"];
            
            NSString *sick_komin=[Date_chunks1 objectAtIndex:0];
            
            if ([sick_komin isEqualToString:@"ARRIVE_AT"])
            {
                
                
                if ([[Date_chunks1 objectAtIndex:2] isEqualToString:@"00:00:00"])
                {
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Fremmødt:  %@",[Date_chunks1 objectAtIndex:1]];
                }
                else
                {
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Hejm:  %@",[Date_chunks1 objectAtIndex:2]];
                }
            }else if ([sick_komin isEqualToString:@"SICK"])
                
            {
                
                _FooterUnderLbael.text = [NSString SickD];
                
            }
            
            else if ([sick_komin isEqualToString:@"FREE"])
                
            {
                
                _FooterUnderLbael.text = [NSString FreeD];
                
            }
            else
            {
                
                _FooterUnderLbael.text = @"Ikke fremmødt";
            }
            
        }
        
        birthday = [NSString stringWithFormat:@"%@",[result objectForKey:@"birthday_name"]];
        // Sovi = [NSString stringWithFormat:@"%@",[result objectForKey:@"birthday_name"]];
        imagenametext = [NSString stringWithFormat:@"%@",[result objectForKey:@"album_name"]];
        AlbumImage = [NSString stringWithFormat:@"%@",[result objectForKey:@"img_link"]];
        
        
        
        NSLog(@"###### test mode .. %@",[result objectForKey:@"room_slip_mode"]);
        
        if (![[result objectForKey:@"room_slip_mode"] isEqualToString:@"YES"])
        {
            
            _Secondbutton.hidden=YES;
            
            _thirdbutton.frame=CGRectMake(_thirdbutton.frame.origin.x-_Secondbutton.frame.size.width+40,_thirdbutton.frame.origin.y, _thirdbutton.frame.size.width,  _thirdbutton.frame.size.height);
            
        }
        else
        {
            if(![[result objectForKey:@"slipText"] isEqualToString:@""])
            {
                NSArray *Date_chunks = [[result objectForKey:@"slipText"] componentsSeparatedByString:@"@@@@"];
                
                firststr = [Date_chunks objectAtIndex:0];
                secondstr =[Date_chunks objectAtIndex:1];
                thirdstr = [Date_chunks objectAtIndex:2];
                
            }
            else
            {
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
                {
                    firststr = @"Einki funnið";
                }
                else
                {
                    firststr = @"Der blev ikke fundet noget";
                }
                
                secondstr=@"";
                thirdstr=@"";
            }
            
        }
    }];
    
    
    
    
    
    
    footer_table=[[UITableView alloc]initWithFrame:CGRectMake(0,_downarrow_base.frame.origin.y+_downarrow_base.frame.size.width,self.view.frame.size.width,_downarrow_base.frame.size.height)];
    footer_table.backgroundColor=[UIColor clearColor];
    [self.view addSubview:footer_table];
    
    
    
    if ([UIScreen mainScreen].bounds.size.width>320)
    {
        _FooterUnderLbael.frame=CGRectMake(_FooterUnderLbael.frame.origin.x, _FooterUnderLbael.frame.origin.y-40, _FooterUnderLbael.frame.size.width, _FooterUnderLbael.frame.size.height);
        
        
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return server_data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DashboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell.backgroundColor=[UIColor clearColor];
    
    
    UIFont *font1 = [UIFont fontWithName:@"MyriadPro-It" size:16];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[[server_data objectAtIndex:indexPath.row]objectForKey:@"news_desc"] attributes: arialDict];
    CGRect rect;
    rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    
    
    cell.title1.numberOfLines = 0;
    cell.title1.clipsToBounds = YES;
    cell.title1.attributedText =aAttrString1;
    
    
    cell.Posted_On.text = [NSString stringWithFormat:@"%@",[[server_data objectAtIndex:indexPath.row]objectForKey:@"posted_on"]];
    
    
    
    cell.title1.frame = CGRectMake(30, 7, self.view.frame.size.width-90, rect.size.height +30);
    cell.Posted_On.frame = CGRectMake(30, rect.size.height +42, self.view.frame.size.width-90, 25);
    cell.LineView.frame = CGRectMake(30, rect.size.height +42+28, self.view.frame.size.width-40, 1);
    
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    UIFont *font1 = [UIFont fontWithName:@"MyriadPro-It" size:16];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[[server_data objectAtIndex:indexPath.row]objectForKey:@"news_desc"] attributes: arialDict];
    
    CGRect rect;
    
    rect =[aAttrString1 boundingRectWithSize:CGSizeMake(290, 800) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    
    return rect.size.height + 70;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"test data...%f",_Page_Scroll.contentOffset.x);
    
}
-(void)checkBox_Tap:(UIButton *)sender
{
    
    [UIView transitionWithView:_Page_Scroll duration:0.9 options:UIViewAnimationOptionTransitionCurlUp animations:
     ^{
         
         [checkbox setBackgroundImage:[UIImage imageNamed:@"tickimg"] forState:UIControlStateNormal];
         [checkbox setTitle:@"" forState:UIControlStateNormal];
         
         
     }
                    completion:^(BOOL finished)
     {
         
         
         for(UIView *subview in [_Page_Scroll subviews]) {
             [subview removeFromSuperview];
         }
         
         for(UIView *subview2 in [_pagecontroll subviews]) {
             [subview2 removeFromSuperview];
         }
         
         
         if (sender.selected == NO)
         {
             sender.selected = YES;
         }
         
         [globalobj GlobalDict:[NSString stringWithFormat:@"%@mark_unmark.php?room_id=%@&subAdminId=%@&children_id=%@&noteId=%@&as=read",App_Domain_Url,[[NSUserDefaults standardUserDefaults]objectForKey:@"room_id"],[[NSUserDefaults standardUserDefaults]objectForKey:@"subAdminId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"child_id"],[[pagedata objectAtIndex:sender.tag] objectForKey:@"id"]] Globalstr:@"string" Withblock:^(id result, NSError *error) {
             
             
             [self viewDidLoad];
             
         }];
         
     }];
}

- (IBAction)Down_arrow_btn:(id)sender
{
    
    if (downtoolbar==0)
    {
        
        [UIView transitionWithView:_Footer_view duration:0.7 options:UIViewAnimationOptionCurveEaseIn animations:
         ^{
             [_Footer_view setFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-_Footer_view.frame.size.height,_baseview.frame.size.width,_Footer_view.frame.size.height)];
             
             downtoolbar=1;
             
             
             _FooterUnderLbael.hidden = YES;
             _FooterUnderView.hidden = YES;
         }
                        completion:^(BOOL finished){
                            
                            
                            [_notes_table setHidden:NO];
                            
                            
                        }];
        
        
        
    }
    else
    {
        
        [UIView transitionWithView:_Footer_view duration:0.6 options:UIViewAnimationOptionCurveEaseIn animations:
         ^{
             
             [_Footer_view setFrame:CGRectMake(0,_downarrow_base.frame.origin.y+_downarrow_base.frame.size.height,_baseview.frame.size.width,_Footer_view.frame.size.height)];
             
             downtoolbar=0;
             
             [_notes_table setHidden:YES];
             
             
         }
                        completion:^(BOOL finished){
                            
                            _FooterUnderLbael.hidden = NO;
                            _FooterUnderView.hidden = NO;
                            
                        }];
        
        
    }
    
    
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
        
        DashboardViewcontroller *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"landing"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if (sender.tag==5)
    {
        DashboardViewcontroller *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"sjukurPage"];
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
        DashboardViewcontroller *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==4)
    {
        DashboardViewcontroller *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else if (sender.tag==8)
    {
        DashboardViewcontroller *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"PasswordPage"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else
    {
        
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    if(scrollView==scrollViewForZoomImage){
    //        float width = self.scrollViewForZoomImage.frame.size.width;
    //        float xPos = self.scrollViewForZoomImage.contentOffset.x+10;
    //        pagecontrolforzoomimage.currentPage = (int)xPos/width;
    //    }else{
    float width = _Page_Scroll.frame.size.width;
    float xPos = _Page_Scroll.contentOffset.x+10;
    
    //Calculate the page we are on based on x coordinate position and width of scroll view
    pagecontrolforzoomimage.currentPage = (int)xPos/width;
    //}
}
- (IBAction)imagetap:(id)sender
{
    
    DashboardViewcontroller *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"AlbumPage"];
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (IBAction)firstbutton:(UIButton *)sender {
    
    _ImageName.hidden = YES;
    _Image.hidden = YES;
    _uparrow2.hidden = YES;
    _uparrow3.hidden = YES;
    _uparrow4.hidden = YES;
    _uparrow1.hidden = NO;
    _FooterUnderLbael.text = @"";
    _FooterUnderLbael.hidden = NO;
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
    {
        
        NSArray *Date_chunks1 = [[Data_dictionary objectForKey:@"sick_status"] componentsSeparatedByString: @"@@@@"];
        
        NSString *sick_komin=[Date_chunks1 objectAtIndex:0];
        
        if ([sick_komin isEqualToString:@"ARRIVE_AT"])
        {
            if ([[Date_chunks1 objectAtIndex:2] isEqualToString:@"00:00:00"])
            {
                _FooterUnderLbael.text = [NSString stringWithFormat:@"Komin:  %@",[Date_chunks1 objectAtIndex:1]];
            }
            else
            {
                _FooterUnderLbael.text = [NSString stringWithFormat:@"Heim:  %@",[Date_chunks1 objectAtIndex:2]];
            }
        }
        else if ([sick_komin isEqualToString:@"SICK"])
            
        {
            
            _FooterUnderLbael.text = [NSString SickF];
            
        }
        
        else if ([sick_komin isEqualToString:@"FREE"])
            
        {
            
            _FooterUnderLbael.text = [NSString FreeF];
            
        }
        else
        {
            _FooterUnderLbael.text = @"Ikki komin";
        }
        
        
        
    }
    else
    {
        NSArray *Date_chunks1 = [[Data_dictionary objectForKey:@"sick_status"] componentsSeparatedByString: @"@@@@"];
        
        NSString *sick_komin=[Date_chunks1 objectAtIndex:0];
        
        if ([sick_komin isEqualToString:@"ARRIVE_AT"])
        {
            
            if ([[Date_chunks1 objectAtIndex:2] isEqualToString:@"00:00:00"])
            {
                _FooterUnderLbael.text = [NSString stringWithFormat:@"Fremmødt:  %@",[Date_chunks1 objectAtIndex:1]];
            }
            else
            {
                _FooterUnderLbael.text = [NSString stringWithFormat:@"Hejm:  %@",[Date_chunks1 objectAtIndex:2]];
            }
        }
        else if ([sick_komin isEqualToString:@"SICK"])
            
        {
            
            _FooterUnderLbael.text = [NSString SickD];
            
        }
        
        else if ([sick_komin isEqualToString:@"FREE"])
            
        {
            
            _FooterUnderLbael.text = [NSString FreeD];
            
        }
        else
        {
            
            _FooterUnderLbael.text = @"Ikke fremmødt";
        }
        
    }
    
}

- (IBAction)secondbutton:(UIButton *)sender {
    
    _ImageName.hidden = YES;
    _Image.hidden = YES;
    _FooterUnderLbael.hidden = NO;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
    {
        
        if ([[Data_dictionary objectForKey:@"slipText"]isEqualToString:@""])
        {
            _FooterUnderLbael.text=firststr;
        }
        else
        {
            NSArray *chunks = [secondstr componentsSeparatedByString: @" - "];
            NSArray *chunks2 = [firststr componentsSeparatedByString: @" - "];
            
            
            NSLog(@"#### Test...%@",chunks);
            
            
            if ([[chunks2 objectAtIndex:1] isEqualToString:@"00:00"])
            {
                _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                //_FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                
                
                //            if ([[chunks objectAtIndex:0] isEqualToString:@"00:00"])
                //            {
                //
                //        _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                //
                //            }
                //            else
                //            {
                //                 _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                //
                //
                //            }
                
            }
            
            else
            {
                // _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                
                
                if ([[chunks objectAtIndex:0] isEqualToString:@"00:00"] && [[chunks objectAtIndex:1] isEqualToString:@"00:00"])
                {
                    
                    
                    // _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                    
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                }
                else if (![[chunks objectAtIndex:0] isEqualToString:@"00:00"] && [[chunks objectAtIndex:1] isEqualToString:@"00:00"])
                {
                    //                if([[chunks objectAtIndex:1] isEqualToString:@"00:00"])
                    //                {
                    //                     _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                    //
                    //                    if ([[chunks objectAtIndex:0] isEqualToString:@"00:00"])
                    //                    {
                    //
                    //                         _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                    //                    }
                    //
                    //                    else
                    //                    {
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                    //                    }
                    //
                    //                }
                    //                else
                    //                {
                    //
                    //                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                    //                }
                    
                }
                else if (![[chunks objectAtIndex:0] isEqualToString:@"00:00"] && ![[chunks objectAtIndex:1] isEqualToString:@"00:00"])
                {
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                }
                
                
                
            }
            
            
            
            NSString *str =_FooterUnderLbael.text;
            
            str =[str stringByReplacingOccurrencesOfString:@"H" withString:@" Tíma/r "];
            
            str =[str stringByReplacingOccurrencesOfString:@"M" withString:@" Min "];
            
            str =[str stringByReplacingOccurrencesOfString:@"00:00 - 00:00" withString:@""];
            
            
            
            
            _FooterUnderLbael.text =str;
            
            
        }
    }
    else
    {
        if ([[Data_dictionary objectForKey:@"slipText"]isEqualToString:@""])
        {
            _FooterUnderLbael.text=firststr;
        }
        
        else
        {
            
            NSArray *chunks = [secondstr componentsSeparatedByString: @" - "];
            NSArray *chunks2 = [firststr componentsSeparatedByString: @" - "];
            
            
            
            if ([[chunks2 objectAtIndex:1] isEqualToString:@"00:00"])
            {
                _FooterUnderLbael.text = [NSString stringWithFormat:@"Sover nu"];
                //_FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                
                
                //            if ([[chunks objectAtIndex:0] isEqualToString:@"00:00"])
                //            {
                //
                //        _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                //
                //            }
                //            else
                //            {
                //                 _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                //
                //
                //            }
                
            }
            
            else
            {
                // _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                
                
                if ([[chunks objectAtIndex:0] isEqualToString:@"00:00"] && [[chunks objectAtIndex:1] isEqualToString:@"00:00"])
                {
                    
                    
                    // _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                    
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                }
                else if (![[chunks objectAtIndex:0] isEqualToString:@"00:00"] && [[chunks objectAtIndex:1] isEqualToString:@"00:00"])
                {
                    //                if([[chunks objectAtIndex:1] isEqualToString:@"00:00"])
                    //                {
                    //                     _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                    //
                    //                    if ([[chunks objectAtIndex:0] isEqualToString:@"00:00"])
                    //                    {
                    //
                    //                         _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                    //                    }
                    //
                    //                    else
                    //                    {
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Sover nu"];
                    //                    }
                    //
                    //                }
                    //                else
                    //                {
                    //
                    //                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Svevur nú"];
                    //                }
                    
                }
                else if (![[chunks objectAtIndex:0] isEqualToString:@"00:00"] && ![[chunks objectAtIndex:1] isEqualToString:@"00:00"])
                {
                    _FooterUnderLbael.text = [NSString stringWithFormat:@"Í dag:\n%@\n%@\n%@",firststr,secondstr,thirdstr];
                }
                
                
                
            }
            
            NSString *str =_FooterUnderLbael.text;
            
            str =[str stringByReplacingOccurrencesOfString:@"H" withString:@" Time/r "];
            
            str =[str stringByReplacingOccurrencesOfString:@"M" withString:@" Min "];
            
            str =[str stringByReplacingOccurrencesOfString:@"00:00 - 00:00" withString:@""];
            
            _FooterUnderLbael.text =str;
            
            
            
        }
    }
    _FooterUnderLbael.numberOfLines = 4;
    _FooterUnderLbael.font = [UIFont fontWithName:@"MyriadPro-Regular" size:20];
    
    _uparrow2.hidden = NO;
    _uparrow3.hidden = YES;
    _uparrow4.hidden = YES;
    _uparrow1.hidden = YES;
}

- (IBAction)thirdbutton:(id)sender {
    _ImageName.hidden = YES;
    _Image.hidden = YES;
    _uparrow2.hidden = YES;
    _uparrow3.hidden = NO;
    _uparrow4.hidden = YES;
    _uparrow1.hidden = YES;
    _FooterUnderLbael.hidden = NO;
    if ([birthday isEqual:@"NO"])
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
        {
            _FooterUnderLbael.text = @"Einki funnið";
        }
        else
        {
            _FooterUnderLbael.text = @"Der blev ikke fundet noget";
        }
        
    }
    else
    {
        _FooterUnderLbael.text = birthday;
    }
    
}

- (IBAction)fourthbutton:(UIButton *)sender {
    
    
    _ImageName.hidden = NO;
    _ImageName.userInteractionEnabled=YES;
    [_image_tap setHidden:NO];
    [_image_tap bringSubviewToFront:_ImageName];
    _Image.hidden = NO;
    _uparrow2.hidden = YES;
    _uparrow3.hidden = YES;
    _uparrow4.hidden = NO;
    _uparrow1.hidden = YES;
    //_FooterUnderLbael.text = @"";
    //_FooterUnderLbael.hidden = YES;
    
    if ([imagenametext isEqualToString:@"NO"])
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
        {
            _ImageName.text = @"";
            _FooterUnderLbael.text = @"Einki funnið";
        }
        else
        {
            _ImageName.text = @"";
            _FooterUnderLbael.text = @"Einki funnið";
        }
        
    }
    else
    {
        
        _ImageName.text = imagenametext;
        _ImageName.frame=CGRectMake(_ImageName.frame.origin.x, _Image.frame.origin.y+10, _ImageName.frame.size.width, _ImageName.frame.size.height);
        
    }
    
    
    [_Image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",App_Image_Url,AlbumImage]] placeholderImage:[UIImage imageNamed:@""] options:/* DISABLES CODE */ (0) == 0?SDWebImageRefreshCached : 0];
    _Image.clipsToBounds = YES;
    _Image.contentMode=UIViewContentModeScaleAspectFill;
    
}
- (IBAction)pushTootherChld:(id)sender {
    
    
    NSLog(@"test");
    DashboardViewcontroller *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"childList"];
    [self.navigationController pushViewController:obj animated:YES];
    
}
@end

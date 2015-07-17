//
//  DashboardViewcontroller.h
//  AnsaP
//
//  Created by Rahul Singha Roy on 07/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Left.h"
#import "TGGlobalClass.h"
@interface DashboardViewcontroller : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,Leftdelegate,UITextViewDelegate>
{
    UIView *pageview1;
    UIButton *checkbox;
    UIImageView *dot_image;
    UITableView *footer_table;
    BOOL downtoolbar,leftbar_status;
    Left *object;
     TGGlobalClass *globalobj;
      NSMutableArray *server_data;
    NSMutableArray *pagedata;
    UIPageControl *pagecontrolforzoomimage;
    UIImageView *TickImage;
    NSString *birthday;
    NSString *Sovi;
    NSString *imagenametext;
    NSString *AlbumImage;
    NSString *firststr,*secondstr,*thirdstr;
    
    NSMutableDictionary *Data_dictionary;
    
}
- (IBAction)pushTootherChld:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *Page_Scroll;
@property (strong, nonatomic) IBOutlet UIView *Footer_view;
- (IBAction)Down_arrow_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *downarrow_base;
@property (weak, nonatomic) IBOutlet UIView *pagecontroll;
@property (strong, nonatomic) IBOutlet UIButton *buttontem2;
- (IBAction)Leftmenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIView *baseview;
@property (strong, nonatomic) IBOutlet UITableView *notes_table;
@property (weak, nonatomic) IBOutlet UIView *FooterUnderView;
@property (weak, nonatomic) IBOutlet UILabel *FooterUnderLbael;
@property (weak, nonatomic) IBOutlet UIButton *FirstButton;
@property (weak, nonatomic) IBOutlet UIButton *Secondbutton;
@property (weak, nonatomic) IBOutlet UIButton *thirdbutton;
@property (weak, nonatomic) IBOutlet UIButton *fourthbutton;
@property (weak, nonatomic) IBOutlet UILabel *ParentName;
@property (weak, nonatomic) IBOutlet UIImageView *uparrow1;
@property (weak, nonatomic) IBOutlet UIImageView *uparrow2;
@property (weak, nonatomic) IBOutlet UIImageView *uparrow3;
@property (weak, nonatomic) IBOutlet UIImageView *uparrow4;
@property (weak, nonatomic) IBOutlet UIImageView *Image;

@property (weak, nonatomic) IBOutlet UILabel *ImageName;
- (IBAction)imagetap:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *image_tap;
@property (strong, nonatomic) IBOutlet UIImageView *profile_image;

- (IBAction)firstbutton:(UIButton *)sender;
- (IBAction)secondbutton:(UIButton *)sender;
- (IBAction)thirdbutton:(id)sender;
- (IBAction)fourthbutton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *Header_titel;

@property (strong, nonatomic) IBOutlet UILabel *Table_header_title;


@end

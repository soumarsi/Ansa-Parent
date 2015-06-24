//
//  AlbumViewController.h
//  AnsaP
//
//  Created by Rahul Singha Roy on 11/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Left.h"
@interface AlbumViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    Left *object;
    BOOL leftbar_status;
    NSMutableArray *server_data;
    NSMutableArray *result2;
    UIImageView *zoom_image;
    UITextView *Description_TXTview;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collection_view;
@property (strong, nonatomic) IBOutlet UIView *baseview;
- (IBAction)leftmenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *photo_view;

- (IBAction)Photoview_close:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *photo_scroll;
@property (strong, nonatomic) IBOutlet UIButton *cross_btn;
@property (strong, nonatomic) IBOutlet UIView *spinn;
@property (strong, nonatomic) IBOutlet UILabel *header_title;
@property (strong, nonatomic) IBOutlet UIView *Alert_view;

@property (strong, nonatomic) IBOutlet UILabel *Alert_lable;

@end

//
//  Left.m
//  AnsaP
//
//  Created by Rahul Singha Roy on 07/05/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "Left.h"
#import "Ansap.pch"
@implementation Left
@synthesize Delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"left" owner:self options:nil]objectAtIndex:0];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"lang"] isEqualToString:@"fo"])
        {
            [_btn1 setTitle:[NSString HomeF] forState:UIControlStateNormal];
            [_btn2 setTitle:[NSString NewsF] forState:UIControlStateNormal];
            [_btn3 setTitle:[NSString NotesF] forState:UIControlStateNormal];
            [_btn4 setTitle:[NSString GalleryF] forState:UIControlStateNormal];
          [_btn5 setTitle:[NSString SickF ] forState:UIControlStateNormal];
           [_btn6 setTitle:[NSString FreeF] forState:UIControlStateNormal];
            [_btn7 setTitle:[NSString LogoutF] forState:UIControlStateNormal];
            [_btn8 setTitle:[NSString PasswordF] forState:UIControlStateNormal];
        }
        else
        {
            [_btn1 setTitle:[NSString HomeD] forState:UIControlStateNormal];
            [_btn2 setTitle:[NSString NewsD] forState:UIControlStateNormal];
            [_btn3 setTitle:[NSString NotesD] forState:UIControlStateNormal];
            [_btn4 setTitle:[NSString GalleryD] forState:UIControlStateNormal];
            [_btn5 setTitle:[NSString SickD ] forState:UIControlStateNormal];
            [_btn6 setTitle:[NSString FreeD] forState:UIControlStateNormal];
            [_btn7 setTitle:[NSString LogoutD] forState:UIControlStateNormal];
            [_btn8 setTitle:[NSString PasswordD] forState:UIControlStateNormal];
        }

        
    }
    return self;
}


- (IBAction)LeftMenu_buttontap:(UIButton *)sender
{
    
    if ([Delegate respondsToSelector:@selector(pushmethod:)])
    {
        [Delegate pushmethod:sender];
    }
   

}
-(void)TapCheck:(int)Buttontag
{
    if (Buttontag==1)
    {
        [_btn1 setBackgroundColor:[UIColor orangeColor]];
        
    }
    else if (Buttontag==2)
    {
        [_btn2 setBackgroundColor:[UIColor orangeColor]];
               
    }
    else if (Buttontag==3)
    {
        [_btn3 setBackgroundColor:[UIColor orangeColor]];
        
    }
    else if (Buttontag==4)
    {
        [_btn4 setBackgroundColor:[UIColor orangeColor]];
        
    }
    else if (Buttontag==5)
    {
        [_btn5 setBackgroundColor:[UIColor orangeColor]];
        
    }
    else if (Buttontag==6)
    {
        [_btn6 setBackgroundColor:[UIColor orangeColor]];
        
    }
    else if (Buttontag==7)
    {
        [_btn7 setBackgroundColor:[UIColor orangeColor]];
        
    }
    else if (Buttontag==8)
    {
        [_btn8 setBackgroundColor:[UIColor orangeColor]];
        
    }


    else
    {
        
    }
}

- (IBAction)button03:(id)sender
{
   
}

- (IBAction)button2:(id)sender
{

}
@end

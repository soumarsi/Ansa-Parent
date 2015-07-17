//
//  ChildList.m
//  AnsaP
//
//  Created by anirban on 17/07/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "ChildList.h"
#import "childCell.h"
#import "TGGlobalClass.h"
#import "Ansap.pch"
@interface ChildList (){
 
    TGGlobalClass *globalobj;
    NSMutableArray *Data_array;
}
@property (strong, nonatomic) IBOutlet UITableView *childTbl;

@end

@implementation ChildList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    globalobj=[[TGGlobalClass alloc]init];
    [globalobj GlobalDict:[NSString stringWithFormat:@"%@childList.php?pid=38",App_Domain_Url]Globalstr:@"array" Withblock:^(id result, NSError *error) {
        
        
        Data_array=[[NSMutableArray alloc]init];
        Data_array=[result mutableCopy];
        
        NSLog(@".....%@",[[Data_array objectAtIndex:0] objectForKey:@"name"]);
        self.childTbl.frame = CGRectMake(self.childTbl.frame.origin.x, self.childTbl.frame.origin.y, self.childTbl.frame.size.width, (Data_array.count*80));
        [self.childTbl reloadData];
        
         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Data_array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"childCell";
    childCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    [cell.cellbtn setTitle:[NSString stringWithFormat:@"%@",[[Data_array objectAtIndex:indexPath.row] objectForKey:@"name"]] forState:UIControlStateNormal];
    
    
    return cell;
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

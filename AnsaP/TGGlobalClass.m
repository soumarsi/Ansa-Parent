//
//  TGGlobalClass.m
//  Taligate
//
//  Created by Soumarsi Kundu on 23/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "TGGlobalClass.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
@implementation TGGlobalClass
{
    Urlresponceblock _responce;
    NSString *check;

}

-(void)GlobalDict:(NSString *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce
{
    
    NSLog(@"parameter--- %@", parameter);
    
    NSURL *url = [NSURL URLWithString:parameter];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    check  = parametercheck;
    connection=nil;
    _responce=[responce copy];
 
}
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"Did Fail");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([check  isEqual: @"array"])
    {
       id result=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        _responce(result,nil);
    }
    else
    {
        id result = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        _responce(result,nil);
    }
    
    

}

-(void)Userdict:(NSDictionary *)userdetails
{
    UserData = [[NSUserDefaults alloc]init];
    
    [UserData setObject:[userdetails objectForKey:@"id"] forKey:@"id"];
    [UserData setObject:[userdetails objectForKey:@"name"] forKey:@"firstname"];
    [UserData setObject:[userdetails objectForKey:@"name"] forKey:@"lastname"];
    [UserData setObject:[userdetails objectForKey:@"email"] forKey:@"email"];
    [UserData setObject:[userdetails objectForKey:@"address"] forKey:@"address"];
    [UserData setObject:[userdetails objectForKey:@"referer"] forKey:@"reffrer"];
    if ([NSString stringWithFormat:@"%@",[userdetails objectForKey:@"child_name"] ].length > 0) {
    [UserData setObject:[userdetails objectForKey:@"child_name"] forKey:@"child_name"];
    }
        if ([NSString stringWithFormat:@"%@",[userdetails objectForKey:@"photo"] ].length > 0) {
        [UserData setObject:[userdetails objectForKey:@"photo"] forKey:@"photo"];
        }
        else
        {
            [UserData setObject:@"efde.png" forKey:@"photo"];
        }

    [UserData setObject:[userdetails objectForKey:@"subAdminId"] forKey:@"subAdminId"];
    [UserData setObject:[userdetails objectForKey:@"room_id"] forKey:@"room_id"];
    [UserData setObject:[userdetails objectForKey:@"child_id"] forKey:@"child_id"];
//    [UserData setObject:[userdetails objectForKey:@"photo"] forKey:@"photo"];
    [UserData setObject:[userdetails objectForKey:@"id"] forKey:@"id"];
    [UserData setObject:@"YES" forKey:@"Logout"];
    [UserData setObject:[userdetails objectForKey:@"gender"] forKey:@"gender"];
    [UserData synchronize];
}
- (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}
@end

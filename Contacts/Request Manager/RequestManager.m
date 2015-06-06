//
//  RequestManager.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    
    return self;
}

- (void)callContactsWithCallback:(ContactsAPICallback)callback;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://private-c7557-talkstables.apiary-mock.com/conversations" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        callback(nil, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)callAvatarWithCallback:(AvatarAPICallback)callback;
{
    NSString *myURLString = @"http://avatars.io/7ac66c0f148de9519b8bd264312c4d64/abcdefg?size=medium";
    NSURL *myURL = [NSURL URLWithString:myURLString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:myURL];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        callback(nil, responseObject);
        //self.imageView = [UIImage imageWithData:responseObject];
        //self.myView.backgroundColor =[UIColor colorWithPatternImage:self.imageView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    
    [requestOperation start];
}

- (void)gettingContactsWithCallback:(void (^)(NSError *error, NSDictionary *result))callback
{
    [self callContactsWithCallback:callback];
}

- (void)gettingAvatarWithCallback:(void (^)(NSError *error, NSData *result))callback
{
    [self callAvatarWithCallback:callback];
}


@end

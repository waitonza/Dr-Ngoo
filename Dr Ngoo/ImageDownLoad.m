//
//  ImageDownLoad.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/20/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "ImageDownLoad.h"

@implementation ImageDownLoad

@synthesize delegate;
@synthesize path;


-(void)startDownloadImageWithUrl:(NSURL*)imageUrl withLocalFilePath:(NSString*)filePath{
    path = filePath;
    receiveData = [NSMutableData data];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:imageUrl];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [(id)delegate performSelector:@selector(saveData:inFilePath:) withObject:receiveData withObject:path];
}

-(void)saveData:(NSData*)data inFilePath:(NSString*)filePath{
    
    [data writeToFile:filePath atomically:YES];
    
}


@end

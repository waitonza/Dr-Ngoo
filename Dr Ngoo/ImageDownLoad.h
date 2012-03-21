//
//  ImageDownLoad.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/20/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownLoad : NSObject {
    NSMutableData *receiveData;
}

@property(nonatomic,assign) id delegate;
@property(nonatomic,retain) NSString *path;

-(void)startDownloadImageWithUrl:(NSURL*)imageUrl withLocalFilePath:(NSString*)filePath;
@end

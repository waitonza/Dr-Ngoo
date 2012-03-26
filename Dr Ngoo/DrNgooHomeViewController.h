//
//  DrNgooHomeViewController.h
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/7/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrNgooDatabaseViewController.h"
#import "ImageDownLoad.h"

@interface DrNgooHomeViewController : UIViewController <UIAlertViewDelegate> {
    UIAlertView* myAlert;
    UIAlertView* updateAlert;
    DrNgooDatabaseViewController *dataBaseController;
    ImageDownLoad *lastObject;
    
    int max_count;
    int download_finished;
    
    BOOL isChecked;
}

@property (strong, nonatomic) NSMutableDictionary *settingInfo;

-(IBAction)buttonPressed:(id)sender;
-(void)saveData:(NSData*)data inFilePath:(NSString*)filePath;

@end
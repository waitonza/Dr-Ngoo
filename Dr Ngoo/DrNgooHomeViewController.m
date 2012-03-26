//
//  DrNgooHomeViewController.m
//  Dr Ngoo
//
//  Created by Wairung Tiranalinvit on 3/7/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DrNgooHomeViewController.h"
#import <sqlite3.h>
#import "DrNgooSnake.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "ImageDownLoad.h"

#define kFileDBname             @"data.sqlite3"
#define kFileSettingname        @"setting.plist"

@interface DrNgooHomeViewController ()

@end

@implementation DrNgooHomeViewController

@synthesize settingInfo;

#pragma mark - Data File Path

- (NSString *)dataFileDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileDBname];
}

- (NSString *)dataFileSettingPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileSettingname];
}

- (NSString*)dataFile:(NSString*)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:filename];
}

#pragma mark - Database Loading

- (int)currentOnlineVersion {
    NSString *path = @"http://exitosus.no.de/drngoo/database/0";
    NSURL *url = [NSURL URLWithString:path];
    NSString *urlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *listItems = [urlString componentsSeparatedByString:@"\n"];
    return [[listItems objectAtIndex:0] intValue];
}

- (int)checkDatabase {
    NSString *filePath = [self dataFileSettingPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        self.settingInfo = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        NSString *ver = [self.settingInfo objectForKey:@"DBVersion"];
        return [ver intValue];
    } else {
        self.settingInfo = [[NSMutableDictionary alloc] init];
        [self.settingInfo setObject:[NSString stringWithFormat:@"%d",-1] forKey:@"DBVersion"];
        [self.settingInfo writeToFile:filePath atomically:YES];
        return -1;
    }
    
}

- (int)createDataBase:(int)ver {
    NSString *path = @"http://exitosus.no.de/drngoo/database/";
    path = [path stringByAppendingFormat:@"%d",ver];
    NSURL *url = [NSURL URLWithString:path];
    NSString *urlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *listItems = [urlString componentsSeparatedByString:@"\n"];
    
    sqlite3 *database;
    if (sqlite3_open([[self dataFileDBPath] UTF8String], &database)
        != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    NSString *createSQL = [listItems objectAtIndex:1];
    char *errorMsg;
    if (sqlite3_exec (database, [createSQL UTF8String],
                      NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table: %s", errorMsg);
    }
    
    for (int i = 2; i < [listItems count]; i++) {
        if (sqlite3_exec (database, [[listItems objectAtIndex:i] UTF8String],
                          NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"Error updating table: %s", errorMsg);
        }
    }
    NSString *dbver = [listItems objectAtIndex:0];
    return [dbver intValue];
}

- (int)updateDataBase:(int)ver {
    NSString *path = @"http://exitosus.no.de/drngoo/database/";
    path = [path stringByAppendingFormat:@"%d",ver];
    NSURL *url = [NSURL URLWithString:path];
    NSString *urlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *listItems = [urlString componentsSeparatedByString:@"\n"];
    char *errorMsg;
    sqlite3 *database;
    if (sqlite3_open([[self dataFileDBPath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        return ver;
    }
    
    for (int i = 1; i < [listItems count]; i++) {
        if (sqlite3_exec (database, [[listItems objectAtIndex:i] UTF8String],
                          NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"Error updating table: %s", errorMsg);
        }
    }
    NSString *dbver = [listItems objectAtIndex:0];
    return [dbver intValue];
    
}

- (void)updateImage {
    NSString *snake_ico_file = @"snake_ico_";
    NSString *snake_img_file = @"snake_img_";
    NSString *filePath = [self dataFile:[snake_ico_file stringByAppendingFormat:@"%d.jpg",max_count-1]];
    lastObject = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        for (int i = 0; i < max_count; i++) {
            NSString *path = @"http://exitosus.no.de/drngoo/image/";
            path = [path stringByAppendingFormat:@"%d",i];
            NSString *ico_path = [path stringByAppendingFormat:@"/ico"];
            NSString *img_path = [path stringByAppendingFormat:@"/img"];
            
            //icon
            NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *filename = [snake_ico_file stringByAppendingFormat:@"%d.jpg",i];
            NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:filename];
            
            ImageDownLoad *imageDown = [[ImageDownLoad alloc]init];
            //if (i == max_count-1)
            //    lastObject = imageDown;
            imageDown.delegate = self;
            [imageDown startDownloadImageWithUrl:[NSURL URLWithString:ico_path] withLocalFilePath:localFilePath];
            
            //img
            NSArray *paths1 =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory1 = [paths1 objectAtIndex:0];
            NSString *filename1 = [snake_img_file stringByAppendingFormat:@"%d.jpg",i];
            NSString *localFilePath1 = [documentsDirectory1 stringByAppendingPathComponent:filename1];            
            ImageDownLoad *imageDown1 = [[ImageDownLoad alloc]init];
            imageDown1.delegate = self;
            [imageDown1 startDownloadImageWithUrl:[NSURL URLWithString:img_path] withLocalFilePath:localFilePath1];
        }
    }
}

-(void)saveData:(NSData*)data inFilePath:(NSString*)filePath {
    
    [data writeToFile:filePath atomically:YES];
    download_finished++;
    if (download_finished == max_count*2) {
        [self performSelectorOnMainThread:@selector(operationCompleted) withObject:nil waitUntilDone:YES];
        lastObject = nil;
    }
}
    
- (NSMutableArray*)readData
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.dataFileDBPath];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        
        return 0;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM SnakeDB"];
    NSMutableArray *snakes = [[NSMutableArray alloc] init];
    NSString *snake_ico_file = @"snake_ico_";
    NSString *snake_img_file = @"snake_img_";
    int i = 0;
    while ([rs next]) {
        NSString *new_file_name = [snake_ico_file stringByAppendingFormat:@"%d.jpg",i];
        NSString *new_file_img_name = [snake_img_file stringByAppendingFormat:@"%d.jpg",i];
        
        DrNgooSnake *snake = [[DrNgooSnake alloc] initWithName:[rs stringForColumn:@"ThaiName"] andPicPath:new_file_name];
        snake.ident = [[rs stringForColumn:@"ID"] intValue];
        snake.snakeName = [[rs stringForColumn:@"Name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        snake.snakeThaiName = [[rs stringForColumn:@"ThaiName"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        snake.picPathSnake = new_file_img_name;
        snake.snakeImage = [self getImagewithName:new_file_img_name];
        snake.science = [rs stringForColumn:@"ScienceName"];
        snake.family = [rs stringForColumn:@"Family"];
        snake.otherName = [rs stringForColumn:@"OtherName"];
        snake.geography = [rs stringForColumn:@"Geography"];
        snake.poisonous = [rs stringForColumn:@"Poisonous"];
        snake.serum = [rs stringForColumn:@"Serum"];
        snake.color = [rs stringForColumn:@"Color"];
        snake.size = [rs stringForColumn:@"Size"];
        snake.characteristice = [rs stringForColumn:@"Characteristics"];
        snake.reproduction = [rs stringForColumn:@"Reproduction"];
        snake.food = [rs stringForColumn:@"Food"];
        snake.location = [rs stringForColumn:@"Location"];
        snake.distribution = [rs stringForColumn:@"Distribution"];
        [snakes addObject:snake];
        i++;
    }
    return snakes;
}

- (UIImage *) getImagewithName:(NSString*) imagepath
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    UIImage *gimage = [UIImage imageWithContentsOfFile: [NSString stringWithFormat:@"%@/%@",docDir,imagepath]];
    
    //NSLog(@"%@/%@",docDir,imagepath);
    
    return gimage;
}

#pragma mark - Popup

- (void)showConfirmUpdateAlert
{
	UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:@"มีอัพเดดใหม่"];
	[alert setMessage:@"มีฐานข้อมูลเวอร์ชั่นใหม่ให้อัพเดด คุณต้องการอัพเดดหรือไม่"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"อัพเดด"];
	[alert addButtonWithTitle:@"ไม่อัพเดด"];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
	{
		// Yes, do something
        [self operatePopupUpdating];
	}
	else if (buttonIndex == 1)
	{
		// No
	}
}

- (void)operateUpdate {
    
    NSString *filePath = [self dataFileSettingPath];
    int updatedVer = 0;
    int version = [self checkDatabase];
    if (version == -1) {
        updatedVer = [self createDataBase:0];
    } else {
        updatedVer = [self updateDataBase:version];
    }
    
    [self.settingInfo setObject:[NSString stringWithFormat:@"%d",updatedVer] forKey:@"DBVersion"];
    [self.settingInfo writeToFile:filePath atomically:YES];
}

- (void) operatePopupUpdating {
    myAlert = [[UIAlertView alloc] initWithTitle:@"กำลังอัพเดดฐานข้อมูล..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [myAlert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    indicator.center = CGPointMake(myAlert.bounds.size.width / 2, myAlert.bounds.size.height - 50);
    [indicator startAnimating];
    [myAlert addSubview:indicator];
    
    [self operateUpdate];
    if (max_count == -1) {
        max_count = [[self readData] count];
    }    
    [self updateImage];
    
}

-(void) operationCompleted
{
    [myAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ข้อความจากระบบ" message:@"อัพเดดฐานข้อมูลเรียบร้อย" delegate:nil cancelButtonTitle:@"ตกลง" otherButtonTitles: nil];
    
    [alert show];
}



#pragma mark - GUI phase

-(IBAction)buttonPressed:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    UITabBarController *tabbar = [super tabBarController];
    if (button.tag == 0) {
        [tabbar setSelectedIndex:1];
    } else if (button.tag == 1) {
        [tabbar setSelectedIndex:3];
    } else if (button.tag == 2) {
        [tabbar setSelectedIndex:2];
    } else {
        [tabbar setSelectedIndex:4];
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG.png"]];
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    max_count = -1;
    download_finished = 0;
    
    isChecked = false;
}

- (void)viewDidAppear:(BOOL)animated {
    if (!isChecked) {
        if ([self checkDatabase] == -1) {
            [self operatePopupUpdating];
        } else if ([self checkDatabase] != [self currentOnlineVersion] && ([self currentOnlineVersion] != 0)) {
            [self showConfirmUpdateAlert];
        }
        
        UITabBarController *controller = [super tabBarController];
        NSArray *controllers = [controller viewControllers];
        
        UINavigationController *databaseNav = [controllers objectAtIndex:2];
        NSArray *viewController =[databaseNav viewControllers];
        DrNgooDatabaseViewController *databaseView = [viewController objectAtIndex:0];
        databaseView.snakes = [self readData];
        isChecked = true;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end

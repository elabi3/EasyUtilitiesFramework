//
//  AppDelegate.h
//  EasyUtilities
//
//  Created by elabi3 on 05/10/13.
//  Copyright (c) 2013 elabi3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) MainViewController * mainViewController;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

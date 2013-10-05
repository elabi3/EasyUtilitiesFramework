//
//  MainViewController.m
//  EasyUtilities
//
//  Created by elabi3 on 05/10/13.
//  Copyright (c) 2013 elabi3. All rights reserved.
//

#import "MainViewController.h"
#import "UtilitiesHeaders.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSMutableArray *array = [[AddressBookHandler getInstance] getReduceAddressBook];
    for (AddressBookReduceEntry * entry in array) {
        NSLog(@"%@\n", entry.name);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

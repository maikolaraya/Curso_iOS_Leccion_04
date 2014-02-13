//
//  FirstViewController.h
//  Leccion #4
//
//  Created by Maikol Araya on 2/12/14.
//  Copyright (c) 2014 La Creativeria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface FirstViewController : UIViewController{
    DAO *database;
}
@property (strong, nonatomic) IBOutlet UITextField *txtName;
- (IBAction)btnAddToDataBase:(id)sender;

@end

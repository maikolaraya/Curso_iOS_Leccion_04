//
//  TableViewController.h
//  Leccion #4
//
//  Created by Maikol Araya on 2/12/14.
//  Copyright (c) 2014 La Creativeria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface TableViewController : UITableViewController{
    NSMutableArray *tableViewObjects;
    DAO *dataBase;
}

@end

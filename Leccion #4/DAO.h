//
//  DAO.h
//  Leccion #4
//
//  Created by Maikol Araya on 2/12/14.
//  Copyright (c) 2014 La Creativeria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DAO : NSObject

//Propios de la clase
-(id) init;
-(DAO*) retrieveSinglenton;

//Parte del ejemplo
-(NSMutableArray *) getTableViewSource;
-(BOOL) addPersonToDataBase:(NSString *) newPerson;

@end






















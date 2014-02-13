//
//  DAO.m
//  Leccion #4
//
//  Created by Maikol Araya on 2/12/14.
//  Copyright (c) 2014 La Creativeria. All rights reserved.
//

#import "DAO.h"

#define DATABASE_NAME @"Clase_iOS_03_DB.sqlite"
#define SELECT_QUERY "SELECT * FROM Person"
#define INSERT_QUERY "INSERT INTO Person (Name) VALUES (?)"

static sqlite3 *database    = nil;
static DAO *sharedSingleton = nil;

@implementation DAO

// Singleton Instance of DAO object
-(DAO *) retrieveSinglenton {
    @synchronized(self) {
        if (sharedSingleton == nil) {
            sharedSingleton = [[DAO alloc] init];
        }
    }
    return sharedSingleton;
}



// Get the root path of database
- (NSString *) getDBPath {
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:DATABASE_NAME];
}

//Database initialization
-(id)init {
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
    NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Error creating database: '%@'.", [error localizedDescription]);
    }
    return self;
}

-(NSMutableArray *) getTableViewSource {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    const char *dbpath = [[self getDBPath] UTF8String];
    sqlite3_stmt *statement = nil;
    
    // Abrimos la base de datos
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        const char *querySQL = SELECT_QUERY;
        
        if (sqlite3_prepare_v2(database, querySQL, -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSMutableString *personName = [[NSMutableString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                [result addObject:personName];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return result;
}


-(BOOL) addPersonToDataBase:(NSString *)newPerson {
    BOOL result = YES;
    
    sqlite3_stmt *statement;
    const char *dbpath = [[self getDBPath] UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        const char *insert_stmt = INSERT_QUERY;
        
        if (sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [newPerson UTF8String], -1, SQLITE_TRANSIENT);
        }
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            result = YES;
        }
        else {
            NSAssert1(0, @"Error insertando en la base de datos %s", sqlite3_errmsg(database));
            result = NO;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    else result = NO;
    
    return result;
}

@end


























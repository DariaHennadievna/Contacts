//
//  DataManager.m
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DataManager.h"
#import "Contact.h"
#import "Avatar.h"
#import "Message.h"

// my keys
#define AVATAR_URL @"avatar_url"
#define USER_ID    @"user_id"
#define USER_NAME  @"username"

@interface DataManager ()

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

@implementation DataManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static DataManager *sharedstore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedstore = [[self alloc] init];
    });
    
    return sharedstore;
}


#pragma mark - Load Data

- (void)setAllContacts:(NSArray *)array
{
    for (NSDictionary *params in array)
    {
        [self setContactWithDictionary:params];
    }
}

- (NSUInteger)numberOfContacts
{    
    NSUInteger number = 0;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Contact"];
    NSError *error = nil;
    NSArray *matches = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Error in executeFetchRequest in numberOfContacts func");
        return number;
    }
    else
    {
        number = [matches count];
    }
    NSLog(@"numberOfContacts %lu", (unsigned long)number);
    return number;
}


- (void)setContactWithDictionary:(NSDictionary *)params
{
    NSNumber *userID = nil;
    Contact *userContact = nil;
    if ([params objectForKey:USER_ID])
    {
        userID = [params objectForKey:USER_ID];
    }
    if (userID)
    {
        userContact = [self contactWithUserID:userID];
    }
    if (userContact)
    {
        if ([params objectForKey:USER_NAME])
        {
            userContact.username = [params objectForKey:USER_NAME];
        }
        if ([params objectForKey:AVATAR_URL])
        {
            userContact.avatarURL = [params objectForKey:AVATAR_URL];
        }
        
        [self saveContext];
    }
}

- (Contact *)contactWithUserID:(NSNumber *)userID
{
    Contact * userContact = nil;
    NSInteger intUserID = [userID intValue];
    if (intUserID)
    {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Contact"];
        request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", userID];
        
        NSError *error = nil;
        NSArray *matches = [self.managedObjectContext executeFetchRequest:request error:&error];
        if (error)
        {
            NSLog(@"Error in executeFetchRequest in contactWithUserID func");
            return nil;
        }
        
        if (!matches || (matches.count > 1))
        {
            NSLog(@"Error in Core Data, contactWithUserID ");
            return nil;
        }
        // проверяем есть ли такой контакт с таким ID и создаем новый если нет
        else if (!matches.count)
        {
            userContact  =  [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:self.managedObjectContext];
            userContact.userID = userID;
        }
        // такой контакт есть и берем его
        else
        {
            userContact = [matches lastObject];
        }
        
        [self saveContext];
    }
    
    return userContact;
}





#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory
{
    // The directory the application uses to store the Core Data store file. This code uses a directory named "dasha.ruto.Contacts" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Contacts" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Contacts.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext
{
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator)
    {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}





@end

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
    NSArray * array = [self arrayOfContacts];
    if (array)
    {
        number = [array count];
    }
    
    NSLog(@"numberOfContacts %lu", (unsigned long)number);
    return number;
}


- (NSArray *)arrayOfContacts
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Contact"];
    NSError *error = nil;
    NSArray *matches = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Error in executeFetchRequest in numberOfContacts func");
        return nil;
    }
    
    return matches;
}


- (NSArray *)unsortedDictionaryArrayOfContacts
{
    NSMutableArray *dictionaryArray = [NSMutableArray array];
    NSArray *arrayOfContacts = [self arrayOfContacts];
    for (Contact *userContact in arrayOfContacts)
    {
        NSDictionary *dictionary = [userContact toDictionaryWithNoRelationship];
        [dictionaryArray addObject:dictionary];
    }
    
    return [dictionaryArray copy];
}


- (void)setContactWithDictionary:(NSDictionary *)params
{
    NSNumber * userID = nil;
    Contact * userContact = nil;
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
        /// получем сообщения из массива сообщений
        NSArray * messages = [params objectForKey:MESSAGES];
        // если есть сообщения в массиве
        if ([messages count])
        {
            // заполняем сообщения
            for (NSDictionary * dict in messages)
            {
                NSNumber * created = [dict objectForKey:CREATED];
                if (created)
                {
                    NSString *text = [dict objectForKey:TEXT];
                    [self setMessageCreated:created withText:text ? text:@"" forContact:userContact];
                }
            }
            userContact.numberOfMessages = [NSNumber numberWithUnsignedInteger:[userContact.messages count]];
        }
    }
}


- (Contact *)contactWithUserID:(NSNumber *)userID
{
    Contact *userContact = nil;
    if ([userID intValue])
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
        
        if (!matches || ([matches count] > 1))
        {
            NSLog(@"Error in Core Data, contactWithUserID ");
            return nil;
        }
        // проверяем есть ли такой контакт с таким ID и создаем новый если нет
        else if (![matches count])
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


- (void)setMessageCreated:(NSNumber *)created
                 withText:(NSString *)text
               forContact:(Contact *)userContact
{
    if (userContact)
    {
        //проверяем есть ли вообще сообщения у данного юзера
        BOOL isExist = NO;
        if ([userContact.messages count])
        {
            for (Message *tempUserMessage in userContact.messages)
            {
                //  убираем повторяющиеся сообщения по содержанию и по времени (не может один юзер создать 2
                //  сообшения одновременно)
                if ([tempUserMessage.created isEqualToNumber:created] && [tempUserMessage.text isEqualToString:text])
                {
                    isExist = YES;
                }
            }
            // если в списке уже имеющихся сообщений нет этого
            if (!isExist)
            {
                // добавляем его..
                [self createMessageEntityCreated:created withText:text forContact:userContact];
            }
        }
        // если сообщений нету, то добавляем без всяких "НО и ЕСЛИ"..
        else
        {
            [self createMessageEntityCreated:created withText:text forContact:userContact];
        }
    }
}

- (void)createMessageEntityCreated:(NSNumber *)created
                          withText:(NSString *)text
                        forContact:(Contact *)userContact
{
    Message *userMessage = nil;
    
    userMessage  =  [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    
    userMessage.created  = created;
    userMessage.text = text;
    userMessage.from = userContact;
    
    [self saveContext];
}

- (NSDictionary *)contactDictionaryWithUserId:(NSNumber *)userID
{
    Contact *userContact = nil;
    NSDictionary *contactDictionary = nil;
    if (userID)
    {
        userContact = [self contactWithUserID:userID];
    }
    if (userContact)
    {
        contactDictionary = [userContact toDictionaryWithNoRelationship];
    }
    
    return contactDictionary;
}

- (NSArray *)sortedArrayOfContacts
{
    NSArray *unsortedArray = [self unsortedDictionaryArrayOfContacts];
    
    NSSortDescriptor *descriptor= [NSSortDescriptor sortDescriptorWithKey:NUMBER_OF_MESSAGES ascending: NO];
    NSSortDescriptor *descriptor2 = [NSSortDescriptor sortDescriptorWithKey:USER_NAME ascending: YES];
    NSArray *sortedArray= [unsortedArray sortedArrayUsingDescriptors:@[ descriptor, descriptor2 ]];
    
    return  sortedArray;
}

- (void)saveAvatarForUserContact:(NSNumber *)userID withImage:(NSData *)imageData;
{
    Contact *userContact = nil;
    if (userID)
    {
        userContact = [self contactWithUserID:userID];
    }
    if (userContact)
    {
        //  если есть фото то просто меняем
        if (userContact.photo)
        {
            userContact.photo.image = imageData;
        }
        //если нет то создаем
        else
        {
            Avatar *photoAvatar = nil;
            photoAvatar  =  [NSEntityDescription insertNewObjectForEntityForName:AVATAR inManagedObjectContext:self.managedObjectContext];
            photoAvatar.image  = imageData;
            photoAvatar.owner = userContact;
        }
        
        [self saveContext];
    }
}

- (NSData *)avatarForUserContact:(NSNumber *)userID
{
    NSData *imageData = nil;
    Contact *userContact = nil;
    if (userID)
    {
        userContact = [self contactWithUserID:userID];
    }
    if (userContact)
    {
        imageData = userContact.photo.image;
    }
    
    return imageData;
}

- (NSArray *)messagesFromUser:(NSNumber *)userID
{
    NSMutableArray *messagesArray = [NSMutableArray array];
    Contact *userContact = nil;
    if (userID)
    {
        userContact = [self contactWithUserID:userID];
    }
    if (userContact)
    {
        for (Message *tempUserMessage in userContact.messages)
        {
            NSDictionary *dict =  [tempUserMessage toDictionaryWithNoRelationship];
            [messagesArray addObject:dict];
        }
    }
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:CREATED ascending: YES];
    NSArray *sortedArray= [messagesArray sortedArrayUsingDescriptors:@[descriptor]];
    
    return sortedArray;
}


- (NSArray *)allMessages
{
    NSMutableArray *messagesArray = [NSMutableArray array];
    NSArray *contacts = [self arrayOfContacts];
    // получаем все контактики
    for (Contact *contact in contacts)
    {
        //получаем все сообщения для каждого контактика
        for (Message *message in contact.messages)
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[message toDictionaryWithNoRelationship]];
            // добавляем в словарь еще и userID, чтоб понятно было от какого user сообщения и еще потом
            // по нему можно взять картинку
            [dict setObject:contact.userID forKey:USER_ID];
            // добавляем словарь в массив
            [messagesArray addObject:dict];
        }
    }
    
    // сортируем по времени массив
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:CREATED ascending:YES];
    NSArray* sortedArray= [messagesArray sortedArrayUsingDescriptors:@[descriptor]];
    
    return sortedArray;
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

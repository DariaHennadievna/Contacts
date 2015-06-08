#import <CoreData/CoreData.h>


@interface NSManagedObject (Serialization)

- (NSDictionary*) toDictionary;
- (void) populateFromDictionary:(NSDictionary*)dict;
+ (NSManagedObject*) createManagedObjectFromDictionary:(NSDictionary*)dict
                                             inContext:(NSManagedObjectContext*)context;
- (NSDictionary*) toDictionaryWithNoRelationship;

@end

@interface NSDictionary (BVJSONString)

-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint;

@end
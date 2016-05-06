//
//  Auth+CoreDataProperties.h
//  Movistar
//
//  Created by Frank Travieso on 6/5/16.
//  Copyright © 2016 Wikot. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Auth.h"

NS_ASSUME_NONNULL_BEGIN

@interface Auth (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *num;
@property (nullable, nonatomic, retain) NSString *ip;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSString *typeAuth;
@property (nullable, nonatomic, retain) NSNumber *active;

@end

NS_ASSUME_NONNULL_END

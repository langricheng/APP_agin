//
//  JRFMDBResultSetHandler.h
//  JRDB
//
//  Created by JMacMini on 16/5/11.
//  Copyright © 2016年 Jrwong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRPersistent.h"

@class FMResultSet, JRDBChain;

typedef enum {
    RetDataTypeInt = 1,
    RetDataTypeUnsignedInt,
    RetDataTypeLong,
    RetDataTypeLongLong,
    RetDataTypeUnsignedLong,
    RetDataTypeUnsignedLongLong,
    RetDataTypeDouble,
    RetDataTypeFloat,
    RetDataTypeString,
    
    RetDataTypeNSNumber,
    RetDataTypeNSData,
    RetDataTypeNSDate,
    
    RetDataTypeUnsupport
} RetDataType;

@interface JRFMDBResultSetHandler : NSObject

+ (NSArray<id<JRPersistent>> * _Nonnull)handleResultSet:(FMResultSet * _Nonnull)resultSet forClazz:(Class<JRPersistent> _Nonnull)clazz;

+ (RetDataType)typeWithEncode:(NSString * _Nonnull)encode;

@end



@interface JRFMDBResultSetHandler (Chain)

+ (id _Nonnull)handleResultSet:(FMResultSet * _Nonnull)resultSet forChain:(JRDBChain * _Nonnull)chain;


@end

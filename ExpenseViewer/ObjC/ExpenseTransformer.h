//
//  ExpenseTransformer.h
//  ExpenseViewer
//
//  Created by BALA SHIVA SHANKAR TELUGU on 14/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Objective-C utility class responsible for transforming
// raw JSON data into Swift-friendly objects.
@interface ExpenseTransformer : NSObject

// Transforms raw JSON NSData into an NSArray of NSDictionary
// Each dictionary contains:
// - id     : NSString
// - title  : NSString
// - amount : NSNumber
// - date   : NSDate
+ (nullable NSArray *)transformJSONData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END

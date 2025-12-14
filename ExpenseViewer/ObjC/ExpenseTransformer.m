//
//  ExpenseTransformer.m
//  ExpenseViewer
//
//  Created by BALA SHIVA SHANKAR TELUGU on 14/12/25.
//

#import "ExpenseTransformer.h"

@implementation ExpenseTransformer

+ (NSArray *)transformJSONData:(NSData *)data {
    // Ensure data is not nil
    if (!data) return nil;
    NSError *err = nil;
    // Parse raw JSON data into Foundation objects
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    // Validate JSON structure
    if (err || ![json isKindOfClass:[NSArray class]]) {
        NSLog(@"Parse error %@", err);
        return nil;
    }
    // Output array to return
    NSMutableArray *output = [NSMutableArray array];
    // ISO-8601 date formatter (created once for performance)
    static NSISO8601DateFormatter *iso = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        iso = [[NSISO8601DateFormatter alloc] init];
    });
    // Iterate through JSON array
    for (NSDictionary *item in (NSArray *)json) {
        // Extract required fields
        NSString *idStr = item[@"id"];
        NSString *title = item[@"title"];
        id amountObj = item[@"amount"];
        NSString *dateStr = item[@"date"];
        // Skip invalid entries
        if (!idStr || !title || !amountObj || !dateStr) continue;
        // Normalize amount (string or number → NSNumber)
        NSNumber *amount =
        [amountObj isKindOfClass:[NSNumber class]]
        ? amountObj
        : @([amountObj doubleValue]);
        // Convert ISO-8601 date string → NSDate
        NSDate *date = [iso dateFromString:dateStr];
        
        if (!date) continue;
        // Add normalized dictionary
        [output addObject:@{
            @"id": idStr,
            @"title": title,
            @"amount": amount,
            @"date": date
        }];
    }
    // Return immutable array
    return [output copy];
}

@end

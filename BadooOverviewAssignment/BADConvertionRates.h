//
//  BADConvertionRates.h
//  
//
//  Created by Valeriy Van on 19.12.15.
//
//

#import <Foundation/Foundation.h>

@interface BADConvertionRates : NSObject
-(instancetype)initWithRates:(NSArray*)rates;
-(double)rateFrom:(NSString*)from to:(NSString*)to; // returns negative if there's no convertion
@end

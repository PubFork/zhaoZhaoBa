//
//  LinerViewController.h
//  LvCheng
//
//  Created by 中科创奇 on 15/4/26.
//  Copyright (c) 2015年 中科创奇. All rights reserved.
//

#import "NSObject+NSCoding.h"
#import <objc/runtime.h>


@implementation NSObject (NSCoding)

- (NSMutableDictionary *)propertiesForClass:(Class)klass {
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *pname = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *pattrs = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        
        pattrs = [[pattrs componentsSeparatedByString:@","] objectAtIndex:0];
        pattrs = [pattrs substringFromIndex:1];
        
        [results setObject:pattrs forKey:pname];
    }
    free(properties);
    
    if ([klass superclass] != [NSObject class]) {
        [results addEntriesFromDictionary:[self propertiesForClass:[klass superclass]]];
    }
    
    return results;
}

- (NSDictionary *)properties {
    return [self propertiesForClass:[self class]];
}

- (void)autoEncodeWithCoder:(NSCoder *)coder {
    NSDictionary *properties = [self properties];
    for (NSString *key in properties) {
        NSString *type = [properties objectForKey:key];
        id value;
        unsigned long long ullValue;
        BOOL boolValue;
        float floatValue;
        double doubleValue;
        NSInteger intValue;
        unsigned long ulValue;
		long longValue;
		unsigned unsignedValue;
		short shortValue;
        NSString *className;
		
        NSMethodSignature *signature = [self methodSignatureForSelector:NSSelectorFromString(key)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:NSSelectorFromString(key)];
        [invocation setTarget:self];
        
        switch ([type characterAtIndex:0]) {
            case '@':   // object
                if ([[type componentsSeparatedByString:@"\""] count] > 1) {
                    className = [[type componentsSeparatedByString:@"\""] objectAtIndex:1];
                    Class class = NSClassFromString(className);
                    
#pragma mark - UIImage类型的属性不归档  add by yhy
                    if ([className isEqualToString:@"UIImage"]) {
                        //如果属性是UIImage类型的，不进行归档
                        break;
                    }
                    if ([className isEqualToString:@"UILabel"]) {
                        //如果属性是UIImage类型的，不进行反归档   warning
                        break;
                    }
                    if ([className isEqualToString:@"UIImageView"]) {
                        //如果属性是UIImage类型的，不进行反归档   warning
                        break;
                    }
                    if ([className isEqualToString:@"NSLayoutConstraint"]) {
                        //如果属性是UIImage类型的，不进行反归档   warning
                        break;
                    }
                    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    value = [self performSelector:NSSelectorFromString(key)];
#pragma clang diagnostic pop
					
                    // only decode if the property conforms to NSCoding
                    if([class conformsToProtocol:@protocol(NSCoding)]){
                        [coder encodeObject:value forKey:key];
                    }
                }
                break;
            case 'B':   // bool
                [invocation invoke];
                [invocation getReturnValue:&boolValue];
                [coder encodeObject:[NSNumber numberWithBool:boolValue] forKey:key];
                break;
            case 'f':   // float
                [invocation invoke];
                [invocation getReturnValue:&floatValue];
                [coder encodeObject:[NSNumber numberWithFloat:floatValue] forKey:key];
                break;
            case 'd':   // double
                [invocation invoke];
                [invocation getReturnValue:&doubleValue];
                [coder encodeObject:[NSNumber numberWithDouble:doubleValue] forKey:key];
                break;
            case 'i':   // int
                [invocation invoke];
                [invocation getReturnValue:&intValue];
                [coder encodeObject:[NSNumber numberWithInteger:intValue] forKey:key];
                break;
            case 'L':   // unsigned long
                [invocation invoke];
                [invocation getReturnValue:&ulValue];
                [coder encodeObject:[NSNumber numberWithUnsignedLong:ulValue] forKey:key];
                break;
            case 'Q':   // unsigned long long
                [invocation invoke];
                [invocation getReturnValue:&ullValue];
                [coder encodeObject:[NSNumber numberWithUnsignedLongLong:ullValue] forKey:key];
                break;
            case 'l':   // long
                [invocation invoke];
                [invocation getReturnValue:&longValue];
                [coder encodeObject:[NSNumber numberWithLong:longValue] forKey:key];
                break;
            case 's':   // short
                [invocation invoke];
                [invocation getReturnValue:&shortValue];
                [coder encodeObject:[NSNumber numberWithShort:shortValue] forKey:key];
                break;
            case 'I':   // unsigned
                [invocation invoke];
                [invocation getReturnValue:&unsignedValue];
                [coder encodeObject:[NSNumber numberWithUnsignedInt:unsignedValue] forKey:key];
                break;
            default:
                break;
        }
    }
}

- (void)autoDecode:(NSCoder *)coder {
    NSDictionary *properties = [self properties];
    for (NSString *key in properties) {
        NSString *type = [properties objectForKey:key];
        id value;
        NSNumber *number;
        NSInteger i;
        CGFloat f;
        BOOL b;
        double d;
        unsigned long ul;
        unsigned long long ull;
		long longValue;
		unsigned unsignedValue;
		short shortValue;
        
        NSString *className;
        
        switch ([type characterAtIndex:0]) {
            case '@':   // object
                if ([[type componentsSeparatedByString:@"\""] count] > 1) {
                    className = [[type componentsSeparatedByString:@"\""] objectAtIndex:1];
                    Class class = NSClassFromString(className);
                    
#pragma mark UIImage类型的属性不归档  add by yhy
                    if ([className isEqualToString:@"UIImage"]) {
                        //如果属性是UIImage类型的，不进行反归档   warning
                        break;
                    }
                    if ([className isEqualToString:@"UILabel"]) {
                        //如果属性是UIImage类型的，不进行反归档   warning
                        break;
                    }
                    if ([className isEqualToString:@"UIImageView"]) {
                        //如果属性是UIImage类型的，不进行反归档   warning
                        break;
                    }
                    if ([className isEqualToString:@"NSLayoutConstraint"]) {
                        //如果属性是UIImage类型的，不进行反归档   warning
                        break;
                    }
                    // only decode if the property conforms to NSCoding
                    if ([class conformsToProtocol:@protocol(NSCoding )]){
                        value = [coder decodeObjectForKey:key];
                        [self setValue:value forKey:key];
                    }
                }
                break;
            case 'B':   // bool
                number = [coder decodeObjectForKey:key];
                b = [number boolValue];
                [self setValue:@(b) forKey:key];
                break;
            case 'f':   // float
                number = [coder decodeObjectForKey:key];
                f = [number floatValue];
                [self setValue:@(f) forKey:key];
                break;
            case 'd':   // double
                number = [coder decodeObjectForKey:key];
                d = [number doubleValue];
                [self setValue:@(d) forKey:key];
                break;
            case 'i':   // int
                number = [coder decodeObjectForKey:key];
                i = [number intValue];
                [self setValue:@(i) forKey:key];
                break;
            case 'L':   // unsigned long
                number = [coder decodeObjectForKey:key];
                ul = [number unsignedLongValue];
                [self setValue:@(ul) forKey:key];
                break;
            case 'Q':   // unsigned long long
                number = [coder decodeObjectForKey:key];
                ull = [number unsignedLongLongValue];
                [self setValue:@(ull) forKey:key];
                break;
			case 'l':   // long
                number = [coder decodeObjectForKey:key];
                longValue = [number longValue];
                [self setValue:@(longValue) forKey:key];
                break;
            case 'I':   // unsigned
                number = [coder decodeObjectForKey:key];
                unsignedValue = [number unsignedIntValue];
                [self setValue:@(unsignedValue) forKey:key];
                break;
            case 's':   // short
                number = [coder decodeObjectForKey:key];
                shortValue = [number shortValue];
                [self setValue:@(shortValue) forKey:key];
                break;
            default:
                break;
        }
    }
}

@end

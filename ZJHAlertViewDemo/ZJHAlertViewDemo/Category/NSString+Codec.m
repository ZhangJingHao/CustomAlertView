//
//  NSString+Codec.m
//  AppMarket
//
//  Created by Mars Ding on 15/8/3.
//  Copyright (c) 2015年 2345 Co., Ltd. All rights reserved.
//

#import "NSString+Codec.h"

@implementation NSString (Localizable)

- (NSString *)localizableString {
    NSString *settingLanguge = [[NSLocale preferredLanguages] firstObject];
    
    NSString *directoryName = [NSString stringWithString:settingLanguge];
    directoryName = [directoryName stringByAppendingString:@".lproj"];
    NSString *tableName = [directoryName stringByAppendingPathComponent:@"Localizable"];
    
    return NSLocalizedStringFromTable(self, tableName, nil);
}

- (UIImage *)localizableImage {
    NSString *settingLanguge = [[NSLocale preferredLanguages] firstObject];
    
    NSString *directoryName = [NSString stringWithString:settingLanguge];
    directoryName = [directoryName stringByAppendingString:@".lproj"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:self
                                                         ofType:nil
                                                    inDirectory:directoryName];
    
    return [UIImage imageWithContentsOfFile:filePath];;
}

@end


@implementation NSString (FetchSize)

- (CGSize)getSizeWithFontSize:(UIFont *)fontSize
                     maxWidth:(CGFloat)maxWidth {
    return [self getSizeWithFontSize:fontSize
                                size:CGSizeMake(maxWidth, MAXFLOAT)];
}

- (CGSize)getSizeWithFontSize:(UIFont *)fontSize
                    maxHeight:(CGFloat)maxHeight {
    return [self getSizeWithFontSize:fontSize
                                size:CGSizeMake(MAXFLOAT, maxHeight)];
}

- (CGSize)getSizeWithFontSize:(UIFont *)fontSize
                         size:(CGSize)size {
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName: fontSize}
                              context:nil].size;
}

@end


@implementation NSString (URLCodedFormat)

- (NSString *)URLEncodedString {
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                    (CFStringRef)self,
                                                                                    NULL,
                                                                                    CFSTR("!*'();:@&=+$,/?%#[] "),
                                                                                    kCFStringEncodingUTF8);
    return result;
}

- (NSString*)URLDecodedString {
    NSString *result = (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    CFSTR(""),
                                                                                                    kCFStringEncodingUTF8);
    return result;
}

- (NSString *)wk_encodeURIComponent {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString *)wk_decodeURIComponent {
    return [self stringByRemovingPercentEncoding];
}

@end

@implementation NSString (WKBase64)

- (NSData *)wk_base64DecodedData {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

- (NSString *)wk_encodeStringToBase64URLFormat {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data wk_base64EncodeStr];
}

@end

@implementation NSData (WKBase64)

- (NSString *)wk_base64EncodeStr {
    NSData *data = [self base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

@end

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (WKMD5)

- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end


@implementation NSString (FileManager)

- (unsigned long long)fileSize {
    static dispatch_once_t token;
    static NSFileManager *fileManager;
    
    dispatch_once(&token, ^{
        fileManager = [NSFileManager new];
    });
    
    return [[fileManager attributesOfItemAtPath:self error:nil] fileSize];
}

@end


@implementation NSString (CompareVersion)

- (NSComparisonResult)compareShortVersion:(NSString *)newVersion {
    NSArray *nowArr = [self componentsSeparatedByString:@"."];
    NSArray *newArr = [newVersion componentsSeparatedByString:@"."];
    
    NSComparisonResult result = NSOrderedSame;
    NSUInteger i = nowArr.count < newArr.count ? nowArr.count : newArr.count;
    for (int j = 0; j < i; j++) {
        NSString *nowStr = [nowArr objectAtIndex:j];
        NSString *newStr = [newArr objectAtIndex:j];
        
        if ([nowStr integerValue] < [newStr integerValue]) {
            result = NSOrderedAscending;
            break;
        }
        
        if ([nowStr integerValue] > [newStr integerValue]) {
            result = NSOrderedDescending;
            break;
        }
    }
    
    if (NSOrderedSame == result) {
        if (nowArr.count < newArr.count) {
            NSInteger tmp = 0;
            for (NSUInteger k = nowArr.count; k < newArr.count; k++) {
                tmp += [[newArr objectAtIndex:k] integerValue];
            }
            
            if (tmp > 0) {
                result = NSOrderedAscending;
            }
        }
    }
    
    return result;
}

+ (NSComparisonResult)wk_cmpVersions:(NSString *)versionA with:(NSString *)versionB {
    if (![versionA isKindOfClass:[NSString class]]
        ||![versionB isKindOfClass:[NSString class]])
    {
        return NSOrderedSame;
    }
    
    NSError *error = nil;
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"(\\.0+)+$" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSString *modifiedA =
    [regex stringByReplacingMatchesInString:versionA
                                    options:0
                                      range:NSMakeRange(0, versionA.length)
                               withTemplate:@""];
    NSString *modifiedB =
    [regex stringByReplacingMatchesInString:versionB
                                    options:0
                                      range:NSMakeRange(0, versionB.length)
                               withTemplate:@""];
    NSArray *arrAStrs = [modifiedA componentsSeparatedByString:@"."];
    NSArray *arrBStrs = [modifiedB componentsSeparatedByString:@"."];
    
    NSUInteger uiMinCount = MIN(arrAStrs.count, arrBStrs.count);
    for (NSUInteger i = 0; i < uiMinCount; i++) {
        NSInteger iRes = [arrAStrs[ i ] integerValue] - [arrBStrs[ i ] integerValue];
        if (iRes > 0) {
            return NSOrderedDescending;
        }
        else if (iRes < 0) {
            return NSOrderedAscending;
        }
    }
    
    NSInteger iRes = arrAStrs.count - arrBStrs.count;
    
    if (iRes > 0) {
        return NSOrderedDescending;
    }
    else if (iRes < 0) {
        return NSOrderedAscending;
    }
    else {
        return NSOrderedSame;
    }
    
}

@end

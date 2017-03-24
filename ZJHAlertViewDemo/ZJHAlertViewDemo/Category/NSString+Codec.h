//
//  NSString+Codec.h
//  AppMarket
//
//  Created by Mars Ding on 15/8/3.
//  Copyright (c) 2015年 2345 Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Localizable)

- (NSString *)localizableString;
- (UIImage *)localizableImage;

@end


@interface NSString (FetchSize)

- (CGSize)getSizeWithFontSize:(UIFont *)fontSize
                     maxWidth:(CGFloat)maxWidth;

- (CGSize)getSizeWithFontSize:(UIFont *)fontSize
                    maxHeight:(CGFloat)maxHeight;

@end


@interface NSString (URLCodedFormat)

- (NSString *)URLEncodedString;
- (NSString*)URLDecodedString;

- (NSString *)wk_encodeURIComponent;
- (NSString *)wk_decodeURIComponent;

@end

@interface NSString (WKBase64)

- (NSData *)wk_base64DecodedData;

- (NSString *)wk_encodeStringToBase64URLFormat;

@end

@interface NSData (WKBase64)

- (NSString *)wk_base64EncodeStr;

@end

@interface NSString (WKMD5)

- (NSString *)MD5String;

@end

@interface NSString (FileManager)

- (unsigned long long)fileSize;

@end


@interface NSString (CompareVersion)

- (NSComparisonResult)compareShortVersion:(NSString *)newVersion;

+ (NSComparisonResult)wk_cmpVersions:(NSString *)versionA with:(NSString *)versionB;

@end

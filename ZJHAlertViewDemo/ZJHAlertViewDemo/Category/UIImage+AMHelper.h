//
//  UIImage+AMHelper.h
//  AppMarket
//
//  Created by Xummer on 16/5/19.
//  Copyright © 2016年 2345 Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AMHelper)

+ (UIImage *)getThumbnailImage:(UIImage *)image withMaxLen:(CGFloat)maxLen;

- (UIImage *)thumbnailWithMaxLen:(CGFloat)maxLen;

+ (UIImage *)imageWithBase64EncodedStr:(NSString *)base64Str;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

/**
 Rounds a new image with a given corner size.
 
 @param radius  The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to half
 the width or height.
 */
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

/**
 Rounds a new image with a given corner size.
 
 @param radius       The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to
 half the width or height.
 
 @param borderWidth  The inset border line width. Values larger than half the rectangle's
 width or height are clamped appropriately to half the width
 or height.
 
 @param borderColor  The border stroke color. nil means clear color.
 */
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;

/**
 Rounds a new image with a given corner size.
 
 @param radius       The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to
 half the width or height.
 
 @param corners      A bitmask value that identifies the corners that you want
 rounded. You can use this parameter to round only a subset
 of the corners of the rectangle.
 
 @param borderWidth  The inset border line width. Values larger than half the rectangle's
 width or height are clamped appropriately to half the width
 or height.
 
 @param borderColor  The border stroke color. nil means clear color.
 
 @param borderLineJoin The border line join.
 */
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin;

/**
 Returns a new rotated image (relative to the center).
 
 @param radians   Rotated radians in counterclockwise.⟲
 
 @param fitSize   YES: new image's size is extend to fit all content.
 NO: image's size will not change, content may be clipped.
 */
- (UIImage *)imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

@end

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color andRect:(CGRect)rect;
- (UIImage *)greyScaleImage;

@end

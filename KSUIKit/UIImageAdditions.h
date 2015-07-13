//
//  UIImageAdditions.h
//  CenturyWeeklyV2
//
//  Created by jerry.gao on 12/22/11.
//  Copyright (c) 2011 KSMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>



@interface UIImage(UIImageAdditions)

- (UIImage *)rescaleToSize:(CGSize)size;
- (UIImage *)cropToRect:(CGRect)cropRect;
-(UIImage*) imageWithParam:(CGFloat) inset lineWidth:(CGFloat)lineWidth lineColor:(UIColor*)lineColor;

- (CGSize)calculateNewSizeForCropBox:(CGSize)croppingBox;
- (UIImage *)cropCenterAndScaleToSize:(CGSize)cropSize;
- (UIImage *)imageByScalingToRate:(CGFloat)rate;
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;
+ (UIImage *)ImageWithColor:(UIColor *)color;
- (UIImage *)roundCorners:(CGSize) size;
- (UIImage *)imageByScalingCircle;
- (UIImage *) imageWithBackgroundColor:(UIColor *)bgColor
                           shadeAlpha1:(CGFloat)alpha1
                           shadeAlpha2:(CGFloat)alpha2
                           shadeAlpha3:(CGFloat)alpha3
                           shadowColor:(UIColor *)shadowColor
                          shadowOffset:(CGSize)shadowOffset
                            shadowBlur:(CGFloat)shadowBlur;
//+ (UIImage *)screenShotView:(UIView *)view;
+ (UIImage *)screenShotWithView:(UIView*)view inRect:(CGRect)aRect;
+ (UIImage*)imageFromView:(UIView *)theView;
@end

@interface UIImage (Alpha)
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize size:(CGSize)sz;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;

@end

@interface UIImage(KS)

+ (UIImage *)imageNamedNocache:(NSString *)name;
- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;
+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path;
@end


@interface UIImage(Color)
- (UIColor*) getPixelColorAtLocation:(CGPoint)point;
- (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef) inImage;
@end

@interface UIImage (Blur)
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;
@end

//毛玻璃效果
@interface UIImage(Effect)
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end

@interface UIImage(video)
+ (UIImage *)getImage:(NSString *)videoURL;
+ (UIImage*) thumbnailImageForVideo:(NSString *)videoURL atTime:(NSTimeInterval)time;
@end


@interface UIImage (RoundedCorner)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;
@end

@interface UIImage (Resize)
- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
@end


typedef void(^LBBlurredImageCompletionBlock)(NSError *error);

extern NSString *const kLBBlurredImageErrorDomain;

extern CGFloat   const kLBBlurredImageDefaultBlurRadius;

enum LBBlurredImageError {
    LBBlurredImageErrorFilterNotAvailable = 0,
};


@interface UIImageView (LBBlurredImage)

/**
 Set the blurred version of the provided image to the UIImageView
 
 @param UIImage the image to blur and set as UIImageView's image
 @param CGFLoat the radius of the blur used by the Gaussian filter
 *param LBBlurredImageCompletionBlock a completion block called after the image
 was blurred and set to the UIImageView (the block is dispatched on main thread)
 */
- (void)setImageToBlur: (UIImage *)image
            blurRadius: (CGFloat)blurRadius
       completionBlock: (LBBlurredImageCompletionBlock) completion;

- (void)setImageToBlur: (UIImage *)image
            blurRadius: (CGFloat)blurRadius;
@end


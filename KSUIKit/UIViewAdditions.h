//
//  Elements.h
//  JHcfHdiPad
//
//  Created by jerry.gao on 10-11-30.
//  Copyright 2010 Caing.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (KS)

/**
 * 取 frame.origin.x 的值（封装成更简单的方法）
 *
 * 赋值时 frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * 取 frame.origin.y 的值（封装成更简单的方法）
 *
 * 赋值时 frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 * WARNING: This depends on undocumented APIs and may be fragile.  For testing only.
 */
#ifdef DEBUG
- (void)simulateTapAtPoint:(CGPoint)location;
#endif

/**
 * Calculates the offset of this view from another view in screen coordinates.
 *
 * otherView should be a parent view of this view.
 */
- (CGPoint)offsetFromView:(UIView*)otherView;

/**
 * Calculates the frame of this view with parts that intersect with the keyboard subtracted.
 *
 * If the keyboard is not showing, this will simply return the normal frame.
 */
- (CGRect)frameWithKeyboardSubtracted:(CGFloat)plusHeight;

/**
 * Shows the view in a window at the bottom of the screen.
 *
 * This will send a notification pretending that a keyboard is about to appear so that
 * observers who adjust their layout for the keyboard will also adjust for this view.
 */
- (void)presentAsKeyboardInView:(UIView*)containingView;

/**
 * Hides a view that was showing in a window at the bottom of the screen (via presentAsKeyboard).
 *
 * This will send a notification pretending that a keyboard is about to disappear so that
 * observers who adjust their layout for the keyboard will also adjust for this view.
 */
- (void)dismissAsKeyboard:(BOOL)animated;

/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;

/**
 * The currentOrientation from owner viewcontroller
 */
- (BOOL)isPortrait;

-(BOOL) containsSubView:(UIView *)subView;

//-(BOOL) containsSubViewOfClassType:(Class)class;

/**
 *  渐变层
 *
 *  @param frame      frame
 *  @param startPoint 开始位置，原点位于左上角（0，0）,右下角（1，1）
 *  @param endPoint   结束位置
 *  @param colors     颜色组
 *  @param locations  渐变颜色分割位置（0，1），数值在0到1之间，表示从开始点到结束点的百分比
 *
 *  @return <#return value description#>
 */
+ (CAGradientLayer*)gradientLayerWithFrame:(CGRect)frame
                                startPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint
                                    colors:(NSArray*)colors
                                 locations:(NSArray*)locations;

@end




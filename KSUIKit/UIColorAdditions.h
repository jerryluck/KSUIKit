//
//  UIColorAdditions.h
//  KSLibrary
//
//  Created by jerry gao on 12-11-21.
//  Copyright (c) 2012年 jerry gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KS)

//[UIColor colorWithHex:0xFF1000]
+ (UIColor *) colorWithHex:(int)hex ;

// Color Scheme Generation Enum
typedef NS_ENUM(NSInteger, ColorScheme) {
    ColorSchemeAnalagous,
    ColorSchemeMonochromatic,
    ColorSchemeTriad,
    ColorSchemeComplementary
};

+ (void)getColorComponents:(UIColor*)color red:(CGFloat*)red green:(CGFloat*)green blue:(CGFloat*)blue alpha:(CGFloat*)alpha;


//具体颜色示例https://github.com/bennyguitar/Colours



#pragma mark - Color from Hex/RGBA/HSBA


/**
 Creates a Color from an array of 4 NSNumbers (r,g,b,a)
 @param rgbaArray   4 NSNumbers for rgba between 0 - 1
 @return    Color
 */
+ (instancetype)colorFromRGBAArray:(NSArray *)rgbaArray;

/**
 Creates a Color from a dictionary of 4 NSNumbers
 Keys: @"r",@"g",@"b",@"a"
 @param rgbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    Color
 */
+ (instancetype)colorFromRGBADictionary:(NSDictionary *)rgbaDict;

/**
 Creates a Color from an array of 4 NSNumbers (h,s,b,a)
 @param hsbaArray   4 NSNumbers for rgba between 0 - 1
 @return    Color
 */
+ (instancetype)colorFromHSBAArray:(NSArray *)hsbaArray;

/**
 Creates a Color from a dictionary of 4 NSNumbers
 Keys: @"h",@"s",@"b",@"a"
 @param hsbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    Color
 */
+ (instancetype)colorFromHSBADictionary:(NSDictionary *)hsbaDict;


#pragma mark - Hex/RGBA/HSBA from Color
/**
 Creates a Hex representation from a Color
 @return    NSString
 */
- (NSString *)hexString;

/**
 Creates an array of 4 NSNumbers representing the float values of r, g, b, a in that order.
 @return    NSArray
 */
- (NSArray *)rgbaArray;

/**
 Creates an array of 4 NSNumbers representing the float values of h, s, b, a in that order.
 @return    NSArray
 */
- (NSArray *)hsbaArray;

/**
 Creates a dictionary of 4 NSNumbers representing float values with keys: "r", "g", "b", "a"
 @return    NSDictionary
 */
- (NSDictionary *)rgbaDictionary;

/**
 Creates a dictionary of 4 NSNumbers representing float values with keys: "h", "s", "b", "a"
 @return    NSDictionary
 */
- (NSDictionary *)hsbaDictionary;


#pragma mark - 4 Color Scheme from Color
/**
 Creates an NSArray of 4 Colors that complement the Color.
 @param type ColorSchemeAnalagous, ColorSchemeMonochromatic, ColorSchemeTriad, ColorSchemeComplementary
 @return    NSArray
 */
- (NSArray *)colorSchemeOfType:(ColorScheme)type;


#pragma mark - Contrasting Color from Color
/**
 Creates either [Color whiteColor] or [Color blackColor] depending on if the color this method is run on is dark or light.
 @return    Color
 */
- (instancetype)blackOrWhiteContrastingColor;


#pragma mark - Complementary Color
/**
 Creates a complementary color - a color directly opposite it on the color wheel.
 @return    Color
 */
- (instancetype)complementaryColor;


#pragma mark - Colors
// System Colors
+ (instancetype)infoBlueColor;
+ (instancetype)successColor;
+ (instancetype)warningColor;
+ (instancetype)dangerColor;

// Whites
+ (instancetype)antiqueWhiteColor;
+ (instancetype)oldLaceColor;
+ (instancetype)ivoryColor;
+ (instancetype)seashellColor;
+ (instancetype)ghostWhiteColor;
+ (instancetype)snowColor;
+ (instancetype)linenColor;

// Grays
+ (instancetype)black25PercentColor;
+ (instancetype)black50PercentColor;
+ (instancetype)black75PercentColor;
+ (instancetype)warmGrayColor;
+ (instancetype)coolGrayColor;
+ (instancetype)charcoalColor;

// Blues
+ (instancetype)tealColor;
+ (instancetype)steelBlueColor;
+ (instancetype)robinEggColor;
+ (instancetype)pastelBlueColor;
+ (instancetype)turquoiseColor;
+ (instancetype)skyBlueColor;
+ (instancetype)indigoColor;
+ (instancetype)denimColor;
+ (instancetype)blueberryColor;
+ (instancetype)cornflowerColor;
+ (instancetype)babyBlueColor;
+ (instancetype)midnightBlueColor;
+ (instancetype)fadedBlueColor;
+ (instancetype)icebergColor;
+ (instancetype)waveColor;

// Greens
+ (instancetype)emeraldColor;
+ (instancetype)grassColor;
+ (instancetype)pastelGreenColor;
+ (instancetype)seafoamColor;
+ (instancetype)paleGreenColor;
+ (instancetype)cactusGreenColor;
+ (instancetype)chartreuseColor;
+ (instancetype)hollyGreenColor;
+ (instancetype)oliveColor;
+ (instancetype)oliveDrabColor;
+ (instancetype)moneyGreenColor;
+ (instancetype)honeydewColor;
+ (instancetype)limeColor;
+ (instancetype)cardTableColor;

// Reds
+ (instancetype)salmonColor;
+ (instancetype)brickRedColor;
+ (instancetype)easterPinkColor;
+ (instancetype)grapefruitColor;
+ (instancetype)pinkColor;
+ (instancetype)indianRedColor;
+ (instancetype)strawberryColor;
+ (instancetype)coralColor;
+ (instancetype)maroonColor;
+ (instancetype)watermelonColor;
+ (instancetype)tomatoColor;
+ (instancetype)pinkLipstickColor;
+ (instancetype)paleRoseColor;
+ (instancetype)crimsonColor;

// Purples
+ (instancetype)eggplantColor;
+ (instancetype)pastelPurpleColor;
+ (instancetype)palePurpleColor;
+ (instancetype)coolPurpleColor;
+ (instancetype)violetColor;
+ (instancetype)plumColor;
+ (instancetype)lavenderColor;
+ (instancetype)raspberryColor;
+ (instancetype)fuschiaColor;
+ (instancetype)grapeColor;
+ (instancetype)periwinkleColor;
+ (instancetype)orchidColor;

// Yellows
+ (instancetype)goldenrodColor;
+ (instancetype)yellowGreenColor;
+ (instancetype)bananaColor;
+ (instancetype)mustardColor;
+ (instancetype)buttermilkColor;
+ (instancetype)goldColor;
+ (instancetype)creamColor;
+ (instancetype)lightCreamColor;
+ (instancetype)wheatColor;
+ (instancetype)beigeColor;

// Oranges
+ (instancetype)peachColor;
+ (instancetype)burntOrangeColor;
+ (instancetype)pastelOrangeColor;
+ (instancetype)cantaloupeColor;
+ (instancetype)carrotColor;
+ (instancetype)mandarinColor;

// Browns
+ (instancetype)chiliPowderColor;
+ (instancetype)burntSiennaColor;
+ (instancetype)chocolateColor;
+ (instancetype)coffeeColor;
+ (instancetype)cinnamonColor;
+ (instancetype)almondColor;
+ (instancetype)eggshellColor;
+ (instancetype)sandColor;
+ (instancetype)mudColor;
+ (instancetype)siennaColor;
+ (instancetype)dustColor;

@end

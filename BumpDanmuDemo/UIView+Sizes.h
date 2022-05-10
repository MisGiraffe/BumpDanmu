//
//  UIView+Sizes.h
//  DanmuDemo
//
//  Created by fangtingting on 2022/4/20.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIView (Sizes)

/** Get the left point of a view. */
@property (nonatomic) CGFloat left;

/** Get the top point of a view. */
@property (nonatomic) CGFloat top;

/** Get the right point of a view. */
@property (nonatomic) CGFloat right;

/** Get the bottom point of a view. */
@property (nonatomic) CGFloat bottom;

///---------------------------------------------------------------------------------------
/// @name Dimensions
///---------------------------------------------------------------------------------------

/** Get the width of a view. */
@property (nonatomic) CGFloat width;

/** Get the height of a view. */
@property (nonatomic) CGFloat height;

///---------------------------------------------------------------------------------------
/// @name Quick Access
///---------------------------------------------------------------------------------------

/** Get the origin of a view. */
@property (nonatomic) CGPoint origin;

/** Get the size of a view. */
@property (nonatomic) CGSize size;

@end

NS_ASSUME_NONNULL_END

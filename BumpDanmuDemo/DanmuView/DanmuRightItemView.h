//
//  DanmuRightItemView.h
//  BumpDanmuDemo
//
//  Created by fangtingting on 2022/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DanmuRightItemView : UIView

@property (assign, nonatomic) NSInteger itemIndex;
@property (assign, nonatomic) NSInteger levelNum;

//- (void)setAvatarUrl:(NSString *)imageUrl withContent:(NSString *)content;

- (void)setAvatarWithImage:(UIImage *)image withContent:(NSString *)content;
- (void)setAvatarWithImageString:(NSString *)imageStr withContent:(NSString *)content;
- (void)setAvatarWithContent:(NSString *)content;

- (void)startBump;

@end

NS_ASSUME_NONNULL_END

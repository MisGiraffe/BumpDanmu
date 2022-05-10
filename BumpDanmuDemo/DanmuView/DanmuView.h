//
//  DanmuView.h
//  BumpDanmuDemo
//
//  Created by fangtingting on 2022/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DanmuView : UIView
@property (strong, nonatomic)NSMutableArray *dataArray;

@property (strong, nonatomic)NSMutableArray *dataLeftArray;

// 轨道速度
@property (nonatomic, assign) NSInteger oneRailSpeed;
@property (nonatomic, assign) NSInteger twoRailSpeed;
@property (nonatomic, assign) NSInteger threeRailSpeed;
@property (nonatomic, assign) NSInteger FourRailSpeed;

@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, assign) NSInteger curLeftIndex;
- (void)start;
- (void)stop;


@end

NS_ASSUME_NONNULL_END

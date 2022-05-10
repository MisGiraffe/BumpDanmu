//
//  DanmuView.m
//  DanmuDemo
//
//  Created by fangtingting on 2022/4/20.
//

#import "DanmuView.h"
#import "DanmuRightItemView.h"
#import "UIView+Sizes.h"
#import "DanmuLeftItemView.h"
#import <SVGAPlayer/SVGA.h>

#define ITEMTAG 154

#define ITEMleftTAG 170

@interface DanmuView ()<SVGAPlayerDelegate>

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *giftView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableDictionary *leftDic;
@property (nonatomic, strong) NSMutableDictionary *rightDic;
@property (nonatomic, assign) int danmuShowTime;

@end

@implementation DanmuView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setClipsToBounds:YES];
        
        _oneRailSpeed = 85;
        _twoRailSpeed = 85;
        _threeRailSpeed = 85;
        _FourRailSpeed = 85;
        
        _curIndex = 0;
        _curLeftIndex = 0;
        _leftDic = [[NSMutableDictionary alloc] init];
        _rightDic = [[NSMutableDictionary alloc] init];
        _danmuShowTime = 0;
        
    }
    return self;
}

- (void)start {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(showDanmu) userInfo:nil repeats:YES];
    }
    
}

- (void)stop {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}


- (void)bumpDanmuWithRail {
    [self bumpDanmuWithRailway:0];
    [self bumpDanmuWithRailway:1];
    [self bumpDanmuWithRailway:2];
    [self bumpDanmuWithRailway:3];
}


//不同轨道弹幕碰撞逻辑
- (void)bumpDanmuWithRailway:(NSInteger)index {
    id rightData = (NSMutableArray *)[self.rightDic objectForKey:[NSString stringWithFormat:@"RightWith%ld",(long)index]];
    id leftData = (NSMutableArray *)[self.leftDic objectForKey:[NSString stringWithFormat:@"LeftWith%ld",(long)index]];
    
    if ([rightData isKindOfClass:[NSMutableArray class]] && [leftData isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *rightArray = [NSMutableArray array];
        NSMutableArray *leftArray = [NSMutableArray array];
        [rightArray addObjectsFromArray:rightData];
        [leftArray addObjectsFromArray:leftData];
        if (rightArray.count > 0 && leftArray.count > 0) {
            DanmuLeftItemView *leftItem = leftArray[0];
            DanmuRightItemView *rightItem = rightArray[0];
            
            CGRect leftViewCurrentRect = [[leftItem.layer presentationLayer]frame];
            
            CGRect rightViewCurrentRect = [[rightItem.layer presentationLayer]frame];
            
            if (rightViewCurrentRect.origin.x <= (leftViewCurrentRect.origin.x+leftViewCurrentRect.size.width-12)) {
                CGRect frame = rightViewCurrentRect;
                if (rightArray.count > 0 && leftArray.count > 0) {
                    if (leftItem.levelNum > rightItem.levelNum) {
                        [leftItem startBump];
                        [rightArray removeObjectAtIndex:0];
                        [self.rightDic setObject:rightArray forKey:[NSString stringWithFormat:@"RightWith%ld",(long)index]];
                        [rightItem removeFromSuperview];
                    }
                    else if (leftItem.levelNum < rightItem.levelNum) {
                        [rightItem startBump];
                        [leftArray removeObjectAtIndex:0];
                        [self.leftDic setObject:leftArray forKey:[NSString stringWithFormat:@"LeftWith%ld",(long)index]];
                        [leftItem removeFromSuperview];
                    }
                    else {
                        [self startBump:frame.origin.x bumpY:frame.origin.y];
                        [rightArray removeObjectAtIndex:0];
                        [self.rightDic setObject:rightArray forKey:[NSString stringWithFormat:@"RightWith%ld",(long)index]];
                        [rightItem removeFromSuperview];
                        
                        [leftArray removeObjectAtIndex:0];
                        [self.leftDic setObject:leftArray forKey:[NSString stringWithFormat:@"LeftWith%ld",(long)index]];
                        [leftItem removeFromSuperview];
                    }
                    
                }
                
            }
        }
        
    }
}

//碰撞动效
- (void)startBump:(CGFloat)bumpX bumpY:(CGFloat)bumpY {
    
    SVGAPlayer *svGAPlayer = [[SVGAPlayer alloc] initWithFrame:CGRectMake(bumpX, bumpY, 30, 30)];
    svGAPlayer.delegate = self;
    svGAPlayer.contentMode = UIViewContentModeScaleAspectFill;
    svGAPlayer.loops = 1;
    svGAPlayer.clearsAfterStop = YES;
    [self addSubview:svGAPlayer];
    
    SVGAParser *parser = [[SVGAParser alloc] init];
    
    [parser parseWithNamed:@"bump" inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        svGAPlayer.videoItem = videoItem;
        [svGAPlayer startAnimation];
    } failureBlock:nil];
}

//不同轨道的速度
- (NSInteger)railSpeedWithIndex:(NSInteger)indexPath {
    if (indexPath == 0) {
        return _oneRailSpeed;
    }
    else if (indexPath == 1) {
        return _twoRailSpeed;
    }
    else if (indexPath == 2) {
        return _threeRailSpeed;
    }
    else {
        return _FourRailSpeed;
    }
}

// 是否可以展示右侧弹幕
- (BOOL)isShowRightDanmu:(NSInteger)indexPath {
    id leftData = (NSMutableArray *)[self.leftDic objectForKey:[NSString stringWithFormat:@"LeftWith%ld",(long)indexPath]];
    
    if ([leftData isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *leftArray = [NSMutableArray array];
        [leftArray addObjectsFromArray:leftData];
        if (leftArray.count > 0) {
            DanmuLeftItemView *leftItem = leftArray[0];
            CGRect leftViewCurrentRect = [[leftItem.layer presentationLayer]frame];
            if (leftViewCurrentRect.origin.x+leftViewCurrentRect.size.width+100>=[[UIScreen mainScreen] bounds].size.width) {
                return NO;
            }
        }
    }
    
    id rightData = (NSMutableArray *)[self.rightDic objectForKey:[NSString stringWithFormat:@"RightWith%ld",(long)indexPath]];
    
    if ([rightData isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *rightArray = [NSMutableArray array];
        [rightArray addObjectsFromArray:rightData];
        if (rightArray.count > 0) {
            DanmuLeftItemView *rightItem = rightArray[rightArray.count-1];
            CGRect rightViewCurrentRect = [[rightItem.layer presentationLayer]frame];
            if (rightViewCurrentRect.origin.x+ rightViewCurrentRect.size.width>=[[UIScreen mainScreen] bounds].size.width) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)showDanmu {
    [self bumpDanmuWithRail];
    if (_danmuShowTime == 0) {
        for (int i=0 ;i<((self.frame.size.height)/30);i++) {
            [self postLeftView:i];
            [self postView:i];
        }
    }
    _danmuShowTime++;
    if (_danmuShowTime == 10) {
        _danmuShowTime = 0;
    }
}

//右侧弹幕发送视图
- (void)postView:(NSInteger)indexPath {
    // 右侧缓存池有数据
    if (_dataArray && _dataArray.count > 0) {
        //是否可以展示右侧弹幕
        BOOL isShowRightDanmu = [self isShowRightDanmu:indexPath];
        if (!isShowRightDanmu) {
            return;
        }
        NSInteger top = indexPath * 30;
        
        //        UIView *view = [self viewWithTag:indexPath + ITEMTAG];
        //        if (view && [view isKindOfClass:[DanmuRightItemView class]]) {
        //            return;
        //        }
        
        NSDictionary *dict = nil;
        if (_dataArray.count > _curIndex) {
            dict = _dataArray[_curIndex];
            _curIndex++;
        }
        else {
            return;
        }
        
        //        for (DanmuRightItemView *view in self.subviews) {
        //            if ([view isKindOfClass:[DanmuRightItemView class]] && view.itemIndex == _curIndex-1) {
        //                return;
        //            }
        //        }
        
        DanmuRightItemView *item = [[DanmuRightItemView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, top, 10, 30)];
        NSString *content = [dict objectForKey:@"content"];
        _curIndex--;
        [_dataArray removeObjectAtIndex:_curIndex];
        int level = random()%100;
        NSString *showContent = [NSString stringWithFormat:@"%d级%@",level,content];
        [item setAvatarWithContent:showContent];
        
        item.levelNum = level;
        item.itemIndex = indexPath;
        item.tag = indexPath + ITEMTAG;
        [self addSubview:item];
        
        NSMutableArray *rightArray = [NSMutableArray array];
        id rightData = (NSMutableArray *)[self.rightDic objectForKey:[NSString stringWithFormat:@"RightWith%ld",(long)item.itemIndex]];
        if ([rightData isKindOfClass:[NSMutableArray class]]) {
            [rightArray addObjectsFromArray:rightData];
        }
        [rightArray addObject:item];
        [self.rightDic setObject:rightArray forKey:[NSString stringWithFormat:@"RightWith%ld",(long)item.itemIndex]];
        
        CGFloat speed = [self railSpeedWithIndex:indexPath];
        //        speed += random()%20;
        CGFloat time = (item.width+[[UIScreen mainScreen] bounds].size.width) / speed;
        
        //弹幕移动动画
        [UIView animateWithDuration:time delay:0.f options:UIViewAnimationOptionCurveLinear  animations:^{
            item.left = -item.width;
        } completion:^(BOOL finished) {
            NSMutableArray *rightRemoveArray = [NSMutableArray array];
            id rightRemoveData = (NSMutableArray *)[self.rightDic objectForKey:[NSString stringWithFormat:@"RightWith%ld",(long)item.itemIndex]];
            if ([rightRemoveData isKindOfClass:[NSMutableArray class]]) {
                [rightRemoveArray addObjectsFromArray:rightRemoveData];
                if (rightRemoveArray.count > 0) {
                    [rightRemoveArray removeObject:item];
                    [self.rightDic setObject:rightRemoveArray forKey:[NSString stringWithFormat:@"RightWith%ld",(long)item.itemIndex]];
                }
            }
            [item removeFromSuperview];
        }];
        
    }
}


// 是否可以展示左侧弹幕
- (BOOL)isShowLeftDanmu:(NSInteger)indexPath {
    id leftData = (NSMutableArray *)[self.leftDic objectForKey:[NSString stringWithFormat:@"LeftWith%ld",(long)indexPath]];
    
    if ([leftData isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *leftArray = [NSMutableArray array];
        [leftArray addObjectsFromArray:leftData];
        if (leftArray.count > 0) {
            DanmuLeftItemView *leftItem = leftArray[leftArray.count-1];
            CGRect leftViewCurrentRect = [[leftItem.layer presentationLayer]frame];
            if (leftViewCurrentRect.origin.x<=0) {
                return NO;
            }
        }
    }
    
    id rightData = (NSMutableArray *)[self.rightDic objectForKey:[NSString stringWithFormat:@"RightWith%ld",(long)indexPath]];
    
    if ([rightData isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray *rightArray = [NSMutableArray array];
        [rightArray addObjectsFromArray:rightData];
        if (rightArray.count > 0) {
            DanmuLeftItemView *rightItem = rightArray[0];
            CGRect rightViewCurrentRect = [[rightItem.layer presentationLayer]frame];
            if (rightViewCurrentRect.origin.x-100<=0) {
                return NO;
            }
        }
    }
    return YES;
}

//左侧弹幕发送视图
- (void)postLeftView:(NSInteger)indexPath {
    if (_dataLeftArray && _dataLeftArray.count > 0) {
//        int indexPath = random()%(int)((self.frame.size.height)/30);
        NSInteger top = indexPath * 30;
        
        //        UIView *view = [self viewWithTag:indexPath + ITEMleftTAG];
        //        if (view && [view isKindOfClass:[DanmuLeftItemView class]]) {
        //            return;
        //        }
        
        //是否可以展示左侧弹幕
        BOOL isShowLeftDanmu = [self isShowLeftDanmu:indexPath];
        if (!isShowLeftDanmu) {
            return;
        }
        
        NSDictionary *dict = nil;
        if (_dataLeftArray.count > _curLeftIndex) {
            dict = _dataLeftArray[_curLeftIndex];
            _curLeftIndex++;
        }
        else {
            return;
        }
        
        //        for (DanmuLeftItemView *view in self.subviews) {
        //            if ([view isKindOfClass:[DanmuLeftItemView class]] && view.itemIndex == _curLeftIndex-1) {
        //                return;
        //            }
        //        }
        
        DanmuLeftItemView *item = [[DanmuLeftItemView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, top, 10, 30)];
        
        NSString *content = [dict objectForKey:@"content"];
        _curLeftIndex--;
        [_dataLeftArray removeObjectAtIndex:_curLeftIndex];
        int level = random()%100;
        NSString *showContent = [NSString stringWithFormat:@"%@级%d",content,level];
        [item setAvatarWithContent:showContent];
        
        CGRect tempFrame = item.frame;
        item.frame = CGRectMake(-tempFrame.size.width, top, tempFrame.size.width, 30);
        
        item.levelNum = level;
        item.itemIndex = indexPath;
        item.tag = indexPath + ITEMleftTAG;
        [self addSubview:item];
        
        NSMutableArray *leftArray = [NSMutableArray array];
        id leftData = (NSMutableArray *)[self.leftDic objectForKey:[NSString stringWithFormat:@"LeftWith%ld",(long)item.itemIndex]];
        
        if ([leftData isKindOfClass:[NSMutableArray class]]) {
            [leftArray addObjectsFromArray:leftData];
        }
        [leftArray addObject:item];
        [self.leftDic setObject:leftArray forKey:[NSString stringWithFormat:@"LeftWith%ld",(long)item.itemIndex]];
        //        NSLog(@"fttttLeftArray %ld %lu ",(long)item.itemIndex,(unsigned long)leftArray.count);
        
        CGFloat speed = [self railSpeedWithIndex:indexPath];
        //        speed += random()%20;
        CGFloat time = (item.width+[[UIScreen mainScreen] bounds].size.width) / speed;
        
        [UIView animateWithDuration:time delay:0.f options:UIViewAnimationOptionCurveLinear  animations:^{
            item.right = +([[UIScreen mainScreen] bounds].size.width+item.width);
        } completion:^(BOOL finished) {
            NSMutableArray *LeftRemoveArray = [NSMutableArray array];
            id leftRemoveData = (NSMutableArray *)[self.leftDic objectForKey:[NSString stringWithFormat:@"LeftWith%ld",(long)item.itemIndex]];
            if ([leftRemoveData isKindOfClass:[NSMutableArray class]]) {
                [LeftRemoveArray addObjectsFromArray:leftRemoveData];
                if (LeftRemoveArray.count > 0) {
                    [LeftRemoveArray removeObject:item];
                    [self.leftDic setObject:LeftRemoveArray forKey:[NSString stringWithFormat:@"LeftWith%ld",(long)item.itemIndex]];
                }
            }
            [item removeFromSuperview];
        }];
        
    }
}


@end

//
//  DanmuLeftItemView.m
//  DanmuDemo
//
//  Created by fangtingting on 2022/4/20.
//

#import "DanmuLeftItemView.h"
#import "UIView+Sizes.h"
#import "UIColor+Utils.h"
#import <SVGAPlayer/SVGA.h>

@interface DanmuLeftItemView ()<SVGAPlayerDelegate>

@property (nonatomic, strong) UIImageView *blueHeadView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *blueTailView;
@property (nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) SVGAPlayer *svGAPlayer;

@end

@implementation DanmuLeftItemView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorFromHexRGB:@"#4967FF"];
        [self addSubview:_bgView];
        _blueTailView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 40, 26)];
        [_blueTailView setImage:[UIImage imageNamed:@"blue_tail"]];
        [self addSubview:_blueTailView];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 1, 30)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel setFont:[UIFont systemFontOfSize:16]];
        [_contentLabel setTextColor:[UIColor whiteColor]];
        [_contentLabel setNumberOfLines:1];
        [self addSubview:_contentLabel];
        
//        NSTimer *timerRect = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(currentRect:) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void)startBump {
    _svGAPlayer.hidden = NO;
    SVGAParser *parser = [[SVGAParser alloc] init];

    [parser parseWithNamed:@"bump" inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        self.svGAPlayer.videoItem = videoItem;
        [self.svGAPlayer startAnimation];
    } failureBlock:nil];
}

//-(void)currentRect:(NSTimer*)timer {
//
//    CGRect imageViewCurrentRect = [[self.layer presentationLayer]frame];
//
//    NSLog(@"index:%ld x: %lf, y:%lf",(long)self.itemIndex,imageViewCurrentRect.origin.x,imageViewCurrentRect.origin.y);
//
//}

//- (void)setAvatarUrl:(NSString *)imageUrl withContent:(NSString *)content {
//    [_avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:DEFAULAVATAR];
//    [_contentLabel setText:content];
//    [_contentLabel sizeToFit];
//    self.width = _contentLabel.width+43;
//}


- (void)setAvatarWithContent:(NSString *)content {
    [_contentLabel setText:content];
    [_contentLabel sizeToFit];
    self.width = _contentLabel.width+43+40;
    
    _bgView.frame = CGRectMake(_blueTailView.right, 2, _contentLabel.width+10+10, 26);
    _blueHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(_contentLabel.right+10, 0, 20, 30)];
    [_blueHeadView setImage:[UIImage imageNamed:@"blue_head"]];
    [self addSubview:_blueHeadView];
    
    _svGAPlayer = [[SVGAPlayer alloc]initWithFrame:CGRectMake(_blueHeadView.right-15, 0, 30, 30)];
    _svGAPlayer.delegate = self;
    _svGAPlayer.contentMode = UIViewContentModeScaleAspectFill;
    _svGAPlayer.loops = 1;
    _svGAPlayer.hidden = YES;
    _svGAPlayer.clearsAfterStop = YES;
    [self addSubview:_svGAPlayer];
}

- (void)setAvatarWithImage:(UIImage *)image withContent:(NSString *)content {
    if (image != nil) {
        [_blueTailView setImage:image];
    }
    [_contentLabel setText:content];
    [_contentLabel sizeToFit];
    self.width = _contentLabel.width+43+40;
    
    _bgView.frame = CGRectMake(_blueTailView.right, 2, _contentLabel.width+10+10, 26);
    _blueHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(_contentLabel.right+10, 0, 20, 30)];
    [_blueHeadView setImage:[UIImage imageNamed:@"blue_head"]];
    [self addSubview:_blueHeadView];
}

- (void)setAvatarWithImageString:(NSString *)imageStr withContent:(NSString *)content {
    [self setAvatarWithImage:[UIImage imageNamed:imageStr] withContent:content];
}

@end

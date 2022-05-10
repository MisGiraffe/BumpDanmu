//
//  DanmuRightItemView.m
//  DanmuDemo
//
//  Created by fangtingting on 2022/4/20.
//

#import "DanmuRightItemView.h"
#import "UIView+Sizes.h"
#import "UIColor+Utils.h"
#import <SVGAPlayer/SVGA.h>

@interface DanmuRightItemView ()<SVGAPlayerDelegate>

@property (nonatomic, strong) UIImageView *redHeadView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *redTailView;
@property (nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) SVGAPlayer *svGAPlayer;

@end

@implementation DanmuRightItemView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _svGAPlayer = [[SVGAPlayer alloc]initWithFrame:CGRectMake(-15, 0, 30, 30)];
        _svGAPlayer.delegate = self;
        _svGAPlayer.contentMode = UIViewContentModeScaleAspectFill;
        _svGAPlayer.loops = 1;
        _svGAPlayer.hidden = YES;
        _svGAPlayer.clearsAfterStop = YES;
        [self addSubview:_svGAPlayer];
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorFromHexRGB:@"#CD463D"];
        [self addSubview:_bgView];
        _redHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
        [_redHeadView setImage:[UIImage imageNamed:@"red_head"]];
        [self addSubview:_redHeadView];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 1, 30)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel setFont:[UIFont systemFontOfSize:16]];
        [_contentLabel setTextColor:[UIColor whiteColor]];
        [_contentLabel setNumberOfLines:1];
        [self addSubview:_contentLabel];
        
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
    
    _bgView.frame = CGRectMake(_redHeadView.right, 2, _contentLabel.width+10+10, 26);
    _redTailView = [[UIImageView alloc] initWithFrame:CGRectMake(_contentLabel.right, 2, 40, 26)];
    [_redTailView setImage:[UIImage imageNamed:@"red_tail"]];
    [self addSubview:_redTailView];
}

- (void)setAvatarWithImage:(UIImage *)image withContent:(NSString *)content {
    if (image != nil) {
        [_redHeadView setImage:image];
    }
    [_contentLabel setText:content];
    [_contentLabel sizeToFit];
    self.width = _contentLabel.width+43+40;
    
    _bgView.frame = CGRectMake(_redHeadView.right, 2, _contentLabel.width+10+10, 26);
    _redTailView = [[UIImageView alloc] initWithFrame:CGRectMake(_contentLabel.right, 2, 40, 26)];
    [_redTailView setImage:[UIImage imageNamed:@"red_tail"]];
    [self addSubview:_redTailView];
}

- (void)setAvatarWithImageString:(NSString *)imageStr withContent:(NSString *)content {
    [self setAvatarWithImage:[UIImage imageNamed:imageStr] withContent:content];
}


@end

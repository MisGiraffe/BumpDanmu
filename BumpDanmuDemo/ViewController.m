//
//  ViewController.m
//  BumpDanmuDemo
//
//  Created by fangtingting on 2022/4/21.
//

#import "ViewController.h"
#import "DanmuView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *addLeftDanmuBtn;
@property (nonatomic, strong) UIButton *addRightDanmuBtn;
@property (nonatomic, strong) DanmuView *barrageView;
@property (nonatomic, strong) NSMutableArray *leftData;
@property (nonatomic, strong) NSMutableArray *rightData;
@property (nonatomic, assign) NSInteger leftNum;
@property (nonatomic, assign) NSInteger rightNum;
// 轨道速度
@property (nonatomic, assign) NSInteger oneRailSpeed;
@property (nonatomic, assign) NSInteger twoRailSpeed;
@property (nonatomic, assign) NSInteger threeRailSpeed;
@property (nonatomic, assign) NSInteger fourRailSpeed;

@property (nonatomic, strong) UIButton *oneRailSpeedBtn;
@property (nonatomic, strong) UIButton *twoRailSpeedBtn;
@property (nonatomic, strong) UIButton *threeRailSpeedBtn;
@property (nonatomic, strong) UIButton *fourRailSpeedBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.addLeftDanmuBtn];
    [self.view addSubview:self.addRightDanmuBtn];
    [self.view addSubview:self.oneRailSpeedBtn];
    [self.view addSubview:self.twoRailSpeedBtn];
    [self.view addSubview:self.threeRailSpeedBtn];
    [self.view addSubview:self.fourRailSpeedBtn];
    
    self.oneRailSpeed = 5;
    self.twoRailSpeed = 10;
    self.threeRailSpeed = 15;
    self.fourRailSpeed = 20;
    
    self.leftNum = 0;
    self.rightNum = 0;
    
    self.barrageView = [[DanmuView alloc] initWithFrame:CGRectMake(0, 90, [[UIScreen mainScreen] bounds].size.width, 120)];
    [self.barrageView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.barrageView];


//    [barrageView setDataArray:@[@{@"avatar":[UIImage imageNamed:@"red_head"], @"content":@"djsflkjoiwene"},
//                                @{@"avatar":[UIImage imageNamed:@"red_head"], @"content":@"1212341"},
//                                @{@"avatar":@"red_head", @"content":@"大家好啊啊啊啊啊啊啊啊啊啊啊啊啊"},
//                                @{@"avatar":@"red_head", @"content":@"打开就发生束带结发哈市的发货时间卡的很费劲卡号是可怜的疯狂拉黑算了可大家发贺卡就睡了会打开附件阿士大夫"},
//                                @{@"avatar":@"red_head", @"content":@"2342sdfsjhd束带结发哈斯"}]];

//    self.rightData = [[NSMutableArray alloc] initWithArray:@[@{@"content":@"djsflkjoiwene"},
//                                                             @{@"content":@"Right1212341"},
//                                                             @{@"content":@"Right大家好啊啊啊啊啊啊"},
//                                                             @{@"content":@"Right打开就发生束带结发哈市的发"},
//                                                             @{@"content":@"Right2342sdfsjhd束带结发哈斯"}]];
    
    self.rightData = [[NSMutableArray alloc] initWithArray:@[@{@"content":@"right加油1"},
                                                             @{@"content":@"Right加油2"},
                                                             @{@"content":@"Right加油3"},
                                                             @{@"content":@"Right加油4"},
                                                             @{@"content":@"Right加油5"}]];

    [self.barrageView setDataArray:self.rightData];
    
//    self.leftData = [[NSMutableArray alloc] initWithArray:@[@{@"content":@"123455Left"},
//                                                            @{@"content":@"Left1212341Left"},
//                                                            @{@"content":@"Left哈哈哈哈哈哈Left"},
//                                                            @{@"content":@"Left你好好念好你好奶毫安熬好Left"},
//                                                            @{@"content":@"Left嘿嘿嘿嘿额哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈Left"}]];
    
    self.leftData = [[NSMutableArray alloc] initWithArray:@[@{@"content":@"123455Left"},
                                                            @{@"content":@"2加油Left"},
                                                            @{@"content":@"3加油Left"},
                                                            @{@"content":@"4加油Left"},
                                                            @{@"content":@"5加油Left"}]];
    [self.barrageView setDataLeftArray:self.leftData];
    [self.barrageView start];
}

- (void)addLeftDanmu {
//    NSLog(@"ftttt, %ld",(long)self.barrageView.curLeftIndex);
    self.leftNum +=1;
    NSString *strText = [NSString stringWithFormat:@"新增弹幕第%ld条",(long)self.leftNum];
    NSDictionary *dic = @{@"content":strText};
    [self.leftData insertObject:dic atIndex:self.barrageView.curLeftIndex];
    [self.barrageView setDataLeftArray:self.leftData];
}

- (void)addRightDanmu {
    self.rightNum +=1;
    NSString *strText = [NSString stringWithFormat:@"新增弹幕第%ld条",(long)self.rightNum];
    NSDictionary *dic = @{@"content":strText};
    [self.rightData insertObject:dic atIndex:self.barrageView.curIndex];
    [self.barrageView setDataArray:self.rightData];
}

- (void)addOneSpeed {
    self.barrageView.oneRailSpeed+=self.oneRailSpeed;
}

- (void)addTwoSpeed {
    self.barrageView.twoRailSpeed+=self.twoRailSpeed;
}

- (void)addThreeSpeed {
    self.barrageView.threeRailSpeed+=self.threeRailSpeed;
}

- (void)addFourSpeed {
    self.barrageView.FourRailSpeed+=self.fourRailSpeed;
}

- (UIButton *)addLeftDanmuBtn {
    if (!_addLeftDanmuBtn) {
        _addLeftDanmuBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, 150, 50)];
        _addLeftDanmuBtn.backgroundColor = [UIColor redColor];
        [_addLeftDanmuBtn setTitle:@"添加左边弹幕" forState:UIControlStateNormal];
        _addLeftDanmuBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_addLeftDanmuBtn addTarget:self action:@selector(addLeftDanmu) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addLeftDanmuBtn;
}

- (UIButton *)addRightDanmuBtn {
    if (!_addRightDanmuBtn) {
        _addRightDanmuBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 300, 150, 50)];
        _addRightDanmuBtn.backgroundColor = [UIColor redColor];
        [_addRightDanmuBtn setTitle:@"添加右边弹幕" forState:UIControlStateNormal];
        _addRightDanmuBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_addRightDanmuBtn addTarget:self action:@selector(addRightDanmu) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addRightDanmuBtn;
}

- (UIButton *)oneRailSpeedBtn {
    if (!_oneRailSpeedBtn) {
        _oneRailSpeedBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 70, 50)];
        _oneRailSpeedBtn.backgroundColor = [UIColor blueColor];
        [_oneRailSpeedBtn setTitle:@"一轨道+5" forState:UIControlStateNormal];
        _oneRailSpeedBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_oneRailSpeedBtn addTarget:self action:@selector(addOneSpeed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oneRailSpeedBtn;
}

- (UIButton *)twoRailSpeedBtn {
    if (!_twoRailSpeedBtn) {
        _twoRailSpeedBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, 400, 70, 50)];
        _twoRailSpeedBtn.backgroundColor = [UIColor blueColor];
        [_twoRailSpeedBtn setTitle:@"二轨道+10" forState:UIControlStateNormal];
        _twoRailSpeedBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_twoRailSpeedBtn addTarget:self action:@selector(addTwoSpeed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoRailSpeedBtn;
}

- (UIButton *)threeRailSpeedBtn {
    if (!_threeRailSpeedBtn) {
        _threeRailSpeedBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 400, 70, 50)];
        _threeRailSpeedBtn.backgroundColor = [UIColor blueColor];
        [_threeRailSpeedBtn setTitle:@"三轨道+15" forState:UIControlStateNormal];
        _threeRailSpeedBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_threeRailSpeedBtn addTarget:self action:@selector(addThreeSpeed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _threeRailSpeedBtn;
}

- (UIButton *)fourRailSpeedBtn {
    if (!_fourRailSpeedBtn) {
        _fourRailSpeedBtn = [[UIButton alloc] initWithFrame:CGRectMake(320, 400, 70, 50)];
        _fourRailSpeedBtn.backgroundColor = [UIColor blueColor];
        [_fourRailSpeedBtn setTitle:@"四轨道+20" forState:UIControlStateNormal];
        _fourRailSpeedBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_fourRailSpeedBtn addTarget:self action:@selector(addFourSpeed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fourRailSpeedBtn;
}

@end

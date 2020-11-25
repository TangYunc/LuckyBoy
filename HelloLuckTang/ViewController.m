//
//  ViewController.m
//  HelloLuckTang
//
//  Created by 中发 on 2018/3/22.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "ViewController.h"
#import "RacViewController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL isLuckTang;
@property (nonatomic, strong) UISwitch *switchFunc;
@property (nonatomic, strong) UILabel *tangLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.isLuckTang = YES;
    //初始化UI
    [self setUpSubviews];
}

//初始化UI
- (void)setUpSubviews{
    
    // 1~35:5    1~12:2
    // 1～33:6   1~16:1
    
    CGFloat labelW = 300 * KWidth_ScaleW;
    CGFloat labelH = 40 * KWidth_ScaleH;
    NSArray *labelNames = @[@"luckyTang",@"luckyDan"];
    NSArray *lackyNums = @[@"1 5 10 18 21 28 -- 16",@"1 5 7 18 21 28 -- 16"];
    CGFloat labelFromTop = kScreenHeight - labelH - 50 * KWidth_ScaleH - labelH;
    for (NSInteger i = 0; i < lackyNums.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - labelW) * 0.5, labelFromTop + i * labelH, labelW , labelH)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%@---->%@", labelNames[i], lackyNums[i]];
        label.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:label];
    }
    
    NSArray *luckBtnNames = @[@"大乐透",@"双色球"];
    CGFloat btnW = 75 * KWidth_ScaleW;
    CGFloat btnH = btnW * 0.6;
    CGFloat btnFromLeftGap = (kScreenWidth - btnW) * 0.5 - 40 *KWidth_ScaleW;
    CGFloat btnFromTopGap = kScreenHeight * 0.25 + 10 *KWidth_ScaleH;
    for (NSInteger i = 0; i < luckBtnNames.count; i++) {
        UIButton *luckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        luckBtn.frame = CGRectMake(btnFromLeftGap, btnFromTopGap +i * (btnH + 150 * KWidth_ScaleH) , btnW, btnH);
        luckBtn.tag = 888 + i;
        [luckBtn setBackgroundColor:[UIColor redColor]];
        [luckBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [luckBtn setTitle:luckBtnNames[i] forState:UIControlStateNormal];
        [luckBtn addTarget:self action:@selector(makeAFortune:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:luckBtn];
    }
    
    UIButton *tempLuckBtn = [self.view viewWithTag:889];
    
    self.switchFunc.frame = CGRectMake(btnFromLeftGap, tempLuckBtn.top + 50 * KWidth_ScaleH , btnW, btnH);
    [self.view addSubview:self.switchFunc];
    
    self.tangLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.switchFunc.right + 10 * KWidth_ScaleW, self.switchFunc.top, 80, 30)];
    self.tangLabel.backgroundColor = [UIColor magentaColor];
    self.tangLabel.text = [NSString stringWithFormat:@"唐糖：%@", @(self.isLuckTang)];
    [self.view addSubview:self.tangLabel];
    
}

-(UISwitch *)switchFunc{
    if(!_switchFunc){
        _switchFunc = [[UISwitch alloc]init];
        [_switchFunc setBackgroundColor:[UIColor lightGrayColor]];
        [_switchFunc setTintColor:[UIColor grayColor]];
        [_switchFunc setOnTintColor:[UIColor blueColor]];
        [_switchFunc setThumbTintColor:[UIColor whiteColor]];
        _switchFunc.layer.cornerRadius = 15.5f;
        _switchFunc.layer.masksToBounds = YES;
        [_switchFunc setOn:self.isLuckTang];
        [_switchFunc addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchFunc;
}


- (void)getFortuneNumber:(NSInteger)fortuneNum fromNumber:(NSInteger)fromNum toNumber:(NSInteger)toNum withY:(NSInteger)y{
    
    NSArray *arr11 = [NSArray array];
    NSMutableArray *arr12 = [NSMutableArray array];
    for (NSInteger i = 0; i < fortuneNum; i ++) {
        
        NSInteger a =  self.isLuckTang ? [self getRandomFortuneNumber:fromNum to:toNum] : [self getRandomNumber:fromNum to:toNum];
        BOOL isBool =  [arr12 containsObject:[NSNumber numberWithInteger:a]];
        if (isBool) {
            [arr12 addObject:[NSNumber numberWithInteger:a + 1]];
        }else{
            
            [arr12 addObject:[NSNumber numberWithInteger:a]];
            arr11 = [arr12 copy];
        }
    }
    NSLog(@"%@",arr11);
    
    for (int m = 0; m < arr12.count; m ++) {
        for (int n = m +1; n < arr12.count; n ++) {
            if (arr12[m] > arr12[n]) {
                [arr12 exchangeObjectAtIndex:m withObjectAtIndex:n];
            }
            arr11 = [arr12 copy];
        }
       UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(30 + (10 +40) * m, y, 40, 35)];
        label11.textAlignment = NSTextAlignmentCenter;
        label11.text = [NSString stringWithFormat:@"%@", arr11[m]];
        label11.backgroundColor = [UIColor magentaColor];
        [self.view addSubview:label11];
    }
    NSLog(@"--%@",arr11);
}

- (NSInteger)getRandomFortuneNumber:(NSInteger)fromNum to:(NSInteger)toNum{
    
    return (NSInteger)((arc4random() % (toNum - fromNum)) + fromNum);
}


-(NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to{
    return (NSInteger)((arc4random() % (to - from + 1)) + from);
}


#pragma mark -- 按钮事件
- (void)makeAFortune:(UIButton *)button{
    
    if (button.tag == 888) {
        [self getFortuneNumber:5 fromNumber:1 toNumber:35 withY:CGRectGetMaxY(button.frame) -button.height - 20 *3 - 35 ];
        [self getFortuneNumber:2 fromNumber:1 toNumber:12 withY:CGRectGetMaxY(button.frame) -button.height - 20 * 2];
    }else{
        [self getFortuneNumber:6 fromNumber:1 toNumber:22 withY:CGRectGetMaxY(button.frame)-button.height - 20 *3 - 35];
        [self getFortuneNumber:1 fromNumber:1 toNumber:16 withY:CGRectGetMaxY(button.frame) -button.height - 20 * 2];
    }
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    self.isLuckTang = isButtonOn;
    self.tangLabel.text = [NSString stringWithFormat:@"唐糖：%@", @(self.isLuckTang)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    RacViewController *racVC = [[RacViewController alloc] init];
    [self presentViewController:racVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

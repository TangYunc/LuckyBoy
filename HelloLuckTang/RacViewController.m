//
//  RacViewController.m
//  HelloLuckTang
//
//  Created by 中发 on 2018/3/27.
//  Copyright © 2018年 中发. All rights reserved.
//

#import "RacViewController.h"
#import "Person.h"

@interface RacViewController ()

@property (nonatomic, strong) Person *p;
@end

@implementation RacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 80, 30)];
    otherLabel.backgroundColor = [UIColor orangeColor];
    otherLabel.text = @"走了啦！";
    [self.view addSubview:otherLabel];
    
    
    
    Person *p = [[Person alloc] init];
//    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    [p rac_observeKeyPath:@"name" options:NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//        NSLog(@"%@--------%@",value, change);
//    }];
    
    [[p rac_valuesForKeyPath:@"name" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"----------------%@",x);
    }];
    _p = p;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"%@---%@",object,change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    _p.name = @"哈哈哈";
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

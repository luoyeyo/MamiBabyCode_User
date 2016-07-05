//
//  AboutViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/30.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "AboutViewController.h"
#import "UserDefaults.h"
#import "HTMLViewController.h"

@interface AboutViewController ()
@property (strong, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavgationBar];
    self.navTitle.text = @"关于我们";
    self.versionLabel.text = [NSString stringWithFormat:@"V %@",[UserDefaults getCurrentVersion]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)lookProtocol:(id)sender {
    HTMLViewController *html = [[HTMLViewController alloc] init];
    html.urlString = kGetProtocol;
    html.title = @"妈咪baby服务协议";
    [self pushViewController:html];
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

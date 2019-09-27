//
//  CLoginViewController.m
//  cat
//
//  Created by 王成龙 on 2019/9/16.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "CLoginViewController.h"
#import "SafeCollection.h"
#import "NSString+HASH.h"
#import "SafeInspactionClasss.h"

@interface CLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *passTf;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation CLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loginClicked:(id)sender {
  
    if (![SafeCollection isNullString: self.nameTf.text] && ![SafeCollection isNullString:self.passTf.text]) {
        CCLog(@"%@",self.passTf.text);
        
        //  密码 + 动态盐
        NSString * password = [self.passTf.text stringByAppendingString:@"salt"].md5String;
        
        CCLog(@"md5:%@",password);

        NSString * HMACPass = [password hmacMD5StringWithKey:@"128B2FA8BD433C6C068C8D803DFF79792A519A55171B1B650C23661D15897263"];
        
        //拼接一个时间戳
        CCLog(@"hmac:%@",HMACPass);
        
       
        CCLog(@"当前时间 ：%@", [SafeInspactionClasss getCurrentDate]);
     
        CCLog(@"当前时间戳：%@",[SafeInspactionClasss getCurrentTimestamp]);
        
//      时间转时间戳
        CCLog(@"时间转时间戳：%@",[SafeInspactionClasss getTimestampWithDate:@"2019-09-16 13:33:33"]);
//      时间戳转时间
        CCLog(@"时间戳转时间：%@",[SafeInspactionClasss getDateStringWithTimestamp:[SafeInspactionClasss getCurrentTimestamp]]);

        
    }
    
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

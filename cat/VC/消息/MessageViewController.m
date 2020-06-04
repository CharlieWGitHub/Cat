//
//  MessageViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/8.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "MessageViewController.h"
#import <AddressBook/AddressBookDefines.h>
#import <AddressBook/ABRecord.h>
#import <Contacts/Contacts.h>
#import "ChineseString.h"
#import "SafeCollection.h"

@interface MessageViewController ()
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableDictionary * dataSource;
@property (nonatomic,strong) NSMutableDictionary * dataS;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    [self addressBookOrdering:[self getContactList]];
//    [self getPerEmu];
}
#pragma mark 获取通讯录
-(void)getPerEmu{
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
      if (status == CNAuthorizationStatusNotDetermined) {
          CNContactStore *store = [[CNContactStore alloc] init];
          [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
              if (error) {
                  //无权限
                  [self showAlertViewAboutNotAuthorAccessContact];
              } else {
                  //有权限
                  [self openContact];
              }
          }];
      } else if(status == CNAuthorizationStatusRestricted) {
          //无权限
          [self showAlertViewAboutNotAuthorAccessContact];
      } else if (status == CNAuthorizationStatusDenied) {
          //无权限
          [self showAlertViewAboutNotAuthorAccessContact];
      } else if (status == CNAuthorizationStatusAuthorized) {
          //有权限
          [self openContact];
      }
}

- (void)showAlertViewAboutNotAuthorAccessContact{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请授权通讯录权限" message:@"请在iPhone的\"设置-隐私-通讯录\"选项中,允许花解解访问你的通讯录" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)openContact{
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        NSString * firstName = contact.familyName;
        NSString * lastName = contact.givenName;
        //电话
        NSArray * phoneNums = contact.phoneNumbers;
        CNLabeledValue *labelValue = phoneNums.firstObject;
        NSString *phoneValue = [labelValue.value stringValue];
        NSLog(@"姓名：%@%@ 电话：%@", firstName, lastName, phoneValue);
        [arr addObject:@{@"name":[firstName stringByAppendingFormat:@"%@", lastName],@"phone":phoneValue}];
//        [arr addObject:[firstName stringByAppendingFormat:@"%@",lastName]];
    }];
    
    NSLog(@"%@",arr);
     
//    NSLog(@"%@",[ChineseString LetterSortArray:arr]);
    
}

#pragma mark - 通讯录排序
- (void)addressBookOrdering:(NSArray *)array{
    [self.dataArray removeAllObjects];
    [self.dataSource removeAllObjects];
    
    //赋初值 A~Z #
        for (int i = 65; i < 91; i ++) {
            char c = (char)i;
            NSMutableArray *array = [NSMutableArray array];
            NSString *key = [NSString stringWithFormat:@"%c",c];
            [self.dataSource setObject:array forKey:key];
        }
        [self.dataSource setObject:[NSMutableArray array] forKey:@"#"];
        
        //遍历联系人信息
        for (CNContact *cnContact in array) {
            //备注名
            NSString *name = [NSString stringWithFormat:@"%@%@",cnContact.familyName,cnContact.givenName];
            //判断是否有备注名
            if (name.length == 0) {
                CNLabeledValue *lableValue = cnContact.phoneNumbers[0];
                name = lableValue.label;
            }
            if (name.length == 0) {
                NSArray *arrayWithPhone = cnContact.phoneNumbers;
                CNLabeledValue *labelValue = arrayWithPhone[0];
                CNPhoneNumber *phoneNumber = labelValue.value;
                name = phoneNumber.stringValue;
            }
            //获取备注名首字母
            NSString *key = [self firstCharactorWithString:name];
            NSMutableArray *ar = self.dataSource[key];
            //保存备注名
            NSMutableDictionary *dic = [@{@"name":name} mutableCopy];
            NSMutableArray *phones = [NSMutableArray array];
            NSArray *arrayWithPhone = cnContact.phoneNumbers;
            if (arrayWithPhone.count>0) {
                for (CNLabeledValue *labelValue in arrayWithPhone) {
                    CNPhoneNumber *phoneNumber = labelValue.value;
                    //                if (![SafeCollection isNullString:phoneNumber.stringValue]) {
                    [phones addObject:phoneNumber.stringValue];
                    //                }
                }
                //保存电话
                [dic setObject:phones.lastObject forKey:@"phones"];
//               数组 [name:,phone:];
                [ar addObject:dic];
                NSMutableDictionary * dicS = [NSMutableDictionary dictionary];
                //保存联系人信息
                [dicS setObject:ar forKey:@"items"];
                [dicS setObject:key forKey:@"title"];
               
//                [self.dataSource setObject:ar forKey:key];
                
                [self.dataArray addObject:dicS];
            }

            //NSData *data = cnContact.thumbnailImageData;
//            UIImage *image = [UIImage imageWithData:data];
            //保存头像
//            if (image == nil) {
//                [dic setObject:@"" forKey:@"header"];
//            } else{
//                [dic setObject:image forKey:@"header"];
//            }
        }
//        //删除多余的分类
//        for (NSString *key in self.dataSource.allKeys) {
//            NSArray *array = self.dataSource[key];
//            if (array.count == 0) {
//                [self.dataSource removeObjectForKey:key];
//            }
//        }
    NSLog(@"--=-==]%@",self.dataArray);
    NSArray *originalArr = [NSArray arrayWithArray:self.dataArray];
    NSSet *set = [NSSet setWithArray:originalArr];
    NSLog(@"===%@",[set allObjects]);

//    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
//      for (unsigned i = 0; i < [originalArr count]; i++){
//          if ([categoryArray containsObject:[originalArr objectAtIndex:i]] == NO){
//              [categoryArray addObject:[originalArr objectAtIndex:i]];
//          }
//      }
//    NSLog(@"ccc===%@",categoryArray);

}
/** 处理手机号 */
- (NSString *)dealWithPhone:(NSString *)phone{
    NSString *phoneNum = [NSString stringWithFormat:@"%@",phone];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"," withString:@""];
    return phoneNum;
}
#pragma mark - 获取通讯录列表
-(NSMutableArray*)getContactList{
    NSMutableArray *array = [NSMutableArray array];
    //获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    //判断授权状态,如果不是已经授权,则直接返回
    if (status != CNAuthorizationStatusAuthorized) {
        return nil;
    }
    //创建通信录对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    // 4.1.拿到所有打算获取的属性对应的key
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactImageDataKey,CNContactThumbnailImageDataKey,CNContactImageDataAvailableKey];
    // 4.2.创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    // 5.遍历所有的联系人
    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        [array addObject:contact];
    }
     ];
    return array;
}

//获取某个字符串或者汉字的首字母.
- (NSString *)firstCharactorWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    if (pinYin.length == 0) {
        return @"#";
    }
    unichar c = [pinYin characterAtIndex:0];
    if (c <'A'|| c >'Z'){
        return @"#";
    }
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([[pinYin substringToIndex:1] rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        // 是数字
        return @"#";
    }
    if ([[pinYin substringToIndex:1] isEqual:@"_"]) {
        return @"#";
    }
    return [pinYin substringToIndex:1];
}

- (NSMutableDictionary *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableDictionary dictionary];
    }
    return _dataSource;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (NSMutableDictionary *)dataS{
    if (!_dataS) {
        _dataS = [NSMutableDictionary dictionary];
    }
    return _dataS;
}
@end

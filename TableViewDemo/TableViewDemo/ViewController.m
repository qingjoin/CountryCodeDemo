//
//  ViewController.m
//  TableViewDemo
//
//  Created by qingyun on 10/24/13.
//  Copyright (c) 2013 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "Yunpinyin.h"
#define INDEXSEARCH @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, 320, 300)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
    _countryListStr =  @"阿尔巴尼亚:355#阿尔及利亚:213#阿富汗:93#阿根廷:54#阿联酋:971#阿曼:968#埃及:20#埃塞俄比亚:251#安哥拉:244#澳大利亚:61#澳门:853#巴基斯坦:92#巴林:973#巴拿马:507#巴西:55#比利时:32#德国:49#俄罗斯:7#法国:33#菲律宾:63#韩国:82#荷兰:31#加拿大:1#加纳:233#柬埔寨:855#卡塔尔:974#科威特:965#老挝:856#黎巴嫩:961#罗马尼亚:40#马来西亚:60#美国:1#蒙古:976#秘鲁:51#缅甸:95#莫桑比克:258#墨西哥:52#南非:27#尼泊尔:977#尼日利亚:234#日本:81#沙特阿拉伯:966#苏丹:249#台湾:886#泰国:66#坦桑尼亚:255#土耳其:90#委内瑞拉:58#文莱:673#乌克\345\205\260:380#西班牙:34#希腊:30#香港:852#新加坡:65#新西兰:64#叙利亚:963#伊拉克:964#伊朗:98#意大利:39#印度:91#印度尼西亚:62#英国:44#约旦:962#越南:84#智利:56#中国:86";
    
    _countryAry =[[NSArray alloc] initWithArray:[_countryListStr componentsSeparatedByString:@"#"]];
    int i = 0;
    int len = [_countryAry count];
    if (!indexArray) {
        indexArray = [[NSMutableArray alloc] init];
    }
    
	for (int i = 0; i < 26; i++)
    {
        [indexArray addObject:[NSMutableArray array]];
    }
    for (i = 0; i < len; i++) {
        
        NSString *countStr = [_countryAry objectAtIndex:i];
        if (!countStr || [countStr length] < 1) {
            continue;
        }
        NSLog(@"sss:%@",countStr);
        
        char c = pinyinFirstLetter([countStr characterAtIndex:0]);
        NSString *keyStr = [NSString stringWithFormat:@"%c",toupper(c)];
        NSUInteger firstLetter = [YUNALPHA rangeOfString:keyStr].location;
        if (firstLetter != NSNotFound) {
            [[indexArray objectAtIndex:firstLetter] addObject:countStr];
        }
    }
    NSLog(@"_selctRow:%@",[[indexArray objectAtIndex:0]objectAtIndex:0]);
    int a =0;
    for(a = 0 ;a< [[indexArray objectAtIndex:0]count];a ++)
    {
        NSLog(@"country:%@",[[indexArray objectAtIndex:0]objectAtIndex:a]);
    }

	// Do any additional setup after loading the view, typically from a nib.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"nu1");
    return 26;
}

//左边ABCD排序
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     NSLog(@"nu2:%d",section);
    if ([[indexArray objectAtIndex:section] count] == 0) {
        return nil;
    }
    return [NSString stringWithFormat:@"%c",[INDEXSEARCH characterAtIndex:section]];
}

//右边ABCD排序
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indices = [[NSMutableArray alloc] init];
    int i = 0;
    for (i = 0; i < 26; i++)
    {
        [indices addObject:[INDEXSEARCH substringWithRange:NSMakeRange(i, 1)]];
    }
    return indices;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSLog(@"nu4");
     return [[indexArray objectAtIndex:section] count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"nu5");
    return 30;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
     NSLog(@"nu6");
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 25)];
    
    [cell addSubview:lab];
    
    int row = [indexPath row];
    int section = [indexPath section];
    
    NSString *str = [[indexArray objectAtIndex:section] objectAtIndex:row];
    char buf[128] ;
    int code;
    
    sscanf([str UTF8String],"%[^:]:%d",buf,&code);
    if (_selectedCountryCode == code) {
        _selectRow = row;
        _selectSection = section;
    
//        CGRect rect =  [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:_selectSection]];
//        [self.tableView scrollRectToVisible:rect animated:YES];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }else
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    NSString *country =[[NSString alloc] initWithCString:buf encoding:NSUTF8StringEncoding];
    lab.text =[NSString stringWithFormat:@"%@[+%d]",country,code];
  
    return cell;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"nu7");
    NSLog(@"c");
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

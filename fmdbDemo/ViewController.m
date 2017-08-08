//
//  ViewController.m
//  fmdbDemo
//
//  Created by chaojie on 2017/7/14.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "ViewController.h"
#import <FMDB/FMDB.h>
#import "YYPerson.h"
#import "NextViewController.h"
#import "Tool.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *_tableView;
    UISearchBar *_search;
    NSArray *_names;
}

@property(nonatomic,strong)NSArray *persons;

@end

@implementation ViewController

-(NSArray *)persons{
    
    if (_persons ==nil) {

        _persons = [Tool query];
    }
    return _persons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    _tableView.tag = 100;
    [self.view addSubview:_tableView];
    
    _search = [[UISearchBar alloc] init];
    _search.frame = CGRectMake(0, 0, 300, 44);
    _search.delegate = self;
    self.navigationItem.titleView = _search;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = rightBar;

    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"delect" style:UIBarButtonItemStylePlain target:self action:@selector(delected:)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    NSLog(@"%@",NSHomeDirectory());
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
       return self.persons.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    YYPerson *pp = self.persons[indexPath.row];
    cell.textLabel.text = pp.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"年龄 %d",pp.age];
    
    
    return cell;
}
-(void)add:(UIBarButtonItem *)sender{
    
    _names = @[@"小李飞刀",@"降龙十八掌",@"九阳神功",@"九阴真经",@"葵花点穴手",@"金刚罩",@"铁布衫",@"西门吹雪",@"中神通",@"南帝北丐",@"洪七公",@"天外飞仙"];
    for (int i =0; i<_names.count; i++) {
        
        YYPerson *pp = [[YYPerson alloc] init];
        pp.name = [NSString stringWithFormat:@"%@-%d",_names[arc4random_uniform(_names.count)],arc4random_uniform(100)];
        pp.age = [NSString stringWithFormat:@"%u",arc4random_uniform(i) + 20];
        
        [Tool save:pp];

    }
}
-(void)delected:(UIBarButtonItem *)sender{
    
  
//    YYPerson *pp = [[YYPerson alloc] init];
//    pp.name = [NSString stringWithFormat:@"%@-%d",_names[arc4random_uniform(_names.count),arc4random_uniform(100)]];
//    pp.age = [NSString stringWithFormat:@"%u",arc4random()%20];
//    
//    [Tool delect:pp];
    
    
    NextViewController *nextVC = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

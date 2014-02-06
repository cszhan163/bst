//
//  jqPopSelectList.m
//  jqConnectTest
//
//  Created by haifeng on 13-1-22.
//  Copyright (c) 2013年 haifeng. All rights reserved.
//

#import "jqPopSelectList.h"

@interface jqPopSelectList ()

@end

@implementation jqPopSelectList
@synthesize listArr;
@synthesize popSelectListDelegate;
@synthesize point;
@synthesize lineHeight;
@synthesize type;
@synthesize lastStr;
@synthesize width;

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

//初始化方法
- (id)initWithDataSrc:(NSArray*)info numOfLine:(NSInteger)num
{
    self=[self init];
    if (self) {
        lineHeight = 30;
        width = 195;
        
        if (num > [info count]) {
            lineNum = [info count];
        } else {
            lineNum = num;
        }
        listArr = [[NSArray alloc] initWithArray:info];
        
        point = CGPointMake(135, 62);
    }
    return self;
}

-(void)setTableView
{
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(point.x, point.y, width, lineHeight*lineNum>330?330:lineHeight*lineNum)];
    tableview.bounces = NO;
    //tableview.showsVerticalScrollIndicator = NO;
    tableview.dataSource = self;
    tableview.delegate = self;
    
    [self.view addSubview:tableview];
    
    if (type == ListTypeWithBank) {
        UIImageView *top = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top.png"]];
        top.frame = CGRectMake(point.x, point.y, tableview.frame.size.width, 5);
        [self.view addSubview:top];
        [top release];
        
        UIImageView *left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left.png"]];
        left.frame = CGRectMake(point.x, point.y+5, 3, tableview.frame.size.height-10);
        [self.view addSubview:left];
        [left release];
        
        UIImageView *right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right.png"]];
        right.frame = CGRectMake(point.x+tableview.frame.size.width-3, point.y+5, 3, tableview.frame.size.height-10);
        [self.view addSubview:right];
        [right release];
        
        UIImageView *bottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom.png"]];
        bottom.frame = CGRectMake(point.x, point.y-5+tableview.frame.size.height, tableview.frame.size.width, 5);
        [self.view addSubview:bottom];
        [bottom release];
    } else {
        tableview.backgroundColor = [UIColor colorWithRed:191/255.0 green:11/255.0 blue:0/255.0 alpha:1];
    }
}

- (void)viewDidLoad
{
    self.view = [[UIControl alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-20);
    self.view.backgroundColor = [UIColor clearColor];
    [(UIControl *)self.view addTarget:self action:@selector(backgroundTap) forControlEvents:UIControlEventTouchDown];
    
    [self setTableView];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)backgroundTap
{
    if (popSelectListDelegate &&[popSelectListDelegate respondsToSelector:@selector(cancelSelectValue:)]) {
        [popSelectListDelegate performSelector:@selector(cancelSelectValue:) withObject:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return lineHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    static NSString *totalIdentify = @"PopSelectList";
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:totalIdentify] autorelease];
    cell.textLabel.text = [listArr objectAtIndex:row];
    
    if (type == ListTypeWithBank) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        if (row == 0) {
            cell.textLabel.textColor = [UIColor colorWithRed:133/255.0 green:70/255.0 blue:17/255.0 alpha:1];
        } else {
            if ([[listArr objectAtIndex:row] isEqualToString:[listArr objectAtIndex:0]]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    } else {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        if ([[listArr objectAtIndex:row] isEqualToString:lastStr]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if (type == ListTypeWithBank) {
        if (row!=0) {
            if (popSelectListDelegate &&[popSelectListDelegate respondsToSelector:@selector(popSelect:didSelectValue:forIndex:)]) {
                [popSelectListDelegate popSelect:self didSelectValue:[listArr objectAtIndex:row] forIndex:row];
            }
        }
    } else {
        if (popSelectListDelegate &&[popSelectListDelegate respondsToSelector:@selector(popSelect:didSelectValue:forIndex:)]) {
            [popSelectListDelegate popSelect:self didSelectValue:[listArr objectAtIndex:row] forIndex:row];
        }

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    if (listArr!=nil) {
        [listArr release];
        listArr = nil;
    }
    if (tableview!=nil) {
        [tableview release];
        tableview = nil;
    }
    [super dealloc];
}

@end

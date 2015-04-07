//
//  UserViewController.h
//  Wenjin
//
//  Created by 秦昱博 on 15/3/31.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHeaderView.h"

@interface UserViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UserHeaderViewDelegate>

@property (strong, nonatomic) NSString *userId;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

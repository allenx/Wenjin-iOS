//
//  data.h
//  Wenjin
//
//  Created by Qin Yubo on 13-10-13.
//  Copyright (c) 2013年 Qin Yubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface data : NSObject

// for posting questions
@property (retain, nonatomic) NSString *postQuestionDetail;
@property (retain, nonatomic) NSArray *postQuestionTopics;

@property (retain, nonatomic) NSString *myUID;

+ (data *)shareInstance;

@end

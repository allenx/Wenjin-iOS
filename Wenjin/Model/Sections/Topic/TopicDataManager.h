//
//  TopicDataManager.h
//  Wenjin
//
//  Created by 秦昱博 on 15/4/10.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicDataManager : NSObject

// topic type: today, hot, focus
+ (void)getTopicListWithType:(NSString *)topicType andPage:(NSInteger)page success:(void(^)(NSUInteger totalRows, NSArray *rowsData))success failure:(void(^)(NSString *errStr))failure;

@end
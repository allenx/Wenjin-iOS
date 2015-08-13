//
//  wjStringProcessor.m
//  Wenjin
//
//  Created by 秦昱博 on 15/3/31.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

#import "wjStringProcessor.h"

@implementation wjStringProcessor

+ (NSString *)processAnswerDetailString:(NSString *)detailString {
    detailString = [self filterHTMLWithString:detailString];
    detailString = [detailString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    detailString = [detailString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSString *imgStr;
    NSString *imgHeaderStr = @"<img src='http://";
    NSScanner *imgScanner = [NSScanner scannerWithString:detailString];
    [imgScanner scanUpToString:imgHeaderStr intoString:NULL];
    [imgScanner scanUpToString:@"/>" intoString:&imgStr];
    NSString *originalImgStr = [NSString stringWithFormat:@"%@%@",imgStr, @"/>"];
    detailString = [detailString stringByReplacingOccurrencesOfString:originalImgStr withString:@"[图片]"];

    return detailString;
}

+ (NSString *)getSummaryFromString:(NSString *)string lengthLimit:(NSInteger)limit {
    string = [self processAnswerDetailString:string];
    if (string.length > limit) {
        string = [string substringToIndex:limit];
        string = [NSString stringWithFormat:@"%@...", string];
    }
    return string;
}

+ (NSString *)filterHTMLWithString:(NSString *)s {
    s = [s stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"<ul>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"<li>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    s = [s stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    s = [s stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    s = [s stringByReplacingOccurrencesOfString:@"[quote]" withString:@"[引用]"];
    s = [s stringByReplacingOccurrencesOfString:@"[/quote]" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"<pre>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"</pre>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"<blockquote>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"</blockquote>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    return s;
}

+ (NSString *)replaceHTMLLabelsFromContent:(NSString *)contentStr {
    // 改一下换行，说不定还要改。。
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSScanner *imgScanner = [NSScanner scannerWithString:contentStr];
    while (![imgScanner isAtEnd]) {
        
        NSString *imgPath;
        NSString *imgStyle;
        
        NSString *imgHeaderStr = @"<img src='http://";
        [imgScanner scanUpToString:imgHeaderStr intoString:NULL];
        [imgScanner scanUpToString:@"http://" intoString:NULL];
        [imgScanner scanUpToString:@"'" intoString:&imgPath];
        imgPath = [imgPath stringByReplacingOccurrencesOfString:imgHeaderStr withString:@""];
        
        NSString *imgStyleHeaderStr = @"'";
        [imgScanner scanUpToString:imgStyleHeaderStr intoString:NULL];
        [imgScanner scanUpToString:@"/>" intoString:&imgStyle];
        
        NSString *originalImgStr = [NSString stringWithFormat:@"%@%@%@%@",@"<img src='",imgPath,imgStyle,@"/>"];
        NSString *responsiveImgStr = [NSString stringWithFormat:@"<img class=\"img-responsive\" alt=\"Responsive image\" src=\"%@\" width=100%%/>",imgPath];
        
        contentStr = [contentStr stringByReplacingOccurrencesOfString:originalImgStr withString:responsiveImgStr];
    }
    return contentStr;
}

+ (NSString *)convertToBootstrapHTMLWithContent:(NSString *)contentStr {
    contentStr = [self replaceHTMLLabelsFromContent:contentStr];
    
    NSString *cssPath = [[NSBundle mainBundle]pathForResource:@"bootstrap" ofType:@"css"];
    NSString *jsPath = [[NSBundle mainBundle]pathForResource:@"bootstrap.min" ofType:@"js"];
    NSString *load = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
                      "<html> \n"
                      "<head> \n"
                      "<meta charset=\"utf-8\"> \n"
                      "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> \n"
                      "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> \n"
                      "<link href=\"%@\" rel=\"stylesheet\"> \n"
                      "</head> \n"
                      "<body> \n"
                      "<div class=\"container\"> \n"
                      "<div class=\"row\"> \n"
                      "<div class=\"col-sm-12\" style=\"margin-left:8px; margin-right:8px; font-size:16px; line-height:1.5; font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;\"> \n"
                      "%@ \n"
                      "</div></div></div> \n"
                      "<script src=\"%@\"></script> \n"
                      "</body> \n"
                      "</html>" , cssPath, contentStr, jsPath];
    
    return load;
}

+ (NSString *)convertToBootstrapHTMLWithExtraBlankLinesWithContent:(NSString *)contentStr {

    contentStr = [self replaceHTMLLabelsFromContent:contentStr];
    
    NSString *cssPath = [[NSBundle mainBundle]pathForResource:@"bootstrap" ofType:@"css"];
    NSString *jsPath = [[NSBundle mainBundle]pathForResource:@"bootstrap.min" ofType:@"js"];
    NSString *load = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
                      "<html> \n"
                      "<head> \n"
                      "<meta charset=\"utf-8\"> \n"
                      "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> \n"
                      "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> \n"
                      "<link href=\"%@\" rel=\"stylesheet\"> \n"
                      "</head> \n"
                      "<body> \n"
                      "<div class=\"container\"> \n"
                      "<div class=\"row\"> \n"
                      "<div class=\"col-sm-12\" style=\"margin-left:8px; margin-right:8px; font-size:16px; line-height:1.5;\"> <br><br> \n" // 这个 br 用来换行到 userInfoView 以下
                      "%@ \n"
                      "</div></div><br><br></div> \n" // 这个 br 用于不被 toolbar 遮挡
                      "<script src=\"%@\"></script> \n"
                      "</body> \n"
                      "</html>" , cssPath, contentStr, jsPath];
    
    return load;
}

+ (NSString *)convertToBootstrapHTMLWithTimeWithContent:(NSString *)contentStr andTimeStamp:(NSInteger)timeStamp {
    contentStr = [self replaceHTMLLabelsFromContent:contentStr];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSString *cssPath = [[NSBundle mainBundle]pathForResource:@"bootstrap" ofType:@"css"];
    NSString *jsPath = [[NSBundle mainBundle]pathForResource:@"bootstrap.min" ofType:@"js"];
    NSString *load = [NSString stringWithFormat:@"<!DOCTYPE html> \n"
                      "<html> \n"
                      "<head> \n"
                      "<meta charset=\"utf-8\"> \n"
                      "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> \n"
                      "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> \n"
                      "<link href=\"%@\" rel=\"stylesheet\"> \n"
                      "</head> \n"
                      "<body> \n"
                      "<div class=\"container\"> \n"
                      "<div class=\"row\"> \n"
                      "<div class=\"col-sm-12\" style=\"margin-left:8px; margin-right:8px; font-size:16px; line-height:1.5; font-family: sans-serif;\"> <br><br> \n" // 这个 br 用来换行到 userInfoView 以下
                      "%@ \n"
                      "</div><br>"
                      "<div class=\"row\"><div class=\"col-sm-12\" style=\"margin-left:8px; margin-right:8px; font-size:16px; line-height:1.5; text-align: right; font-family: sans-serif; color: #999999;\">%@</div></div>"
                      "<br><br></div></div> \n" // 这个 br 用于不被 toolbar 遮挡
                      "<script src=\"%@\"></script> \n"
                      "</body> \n"
                      "</html>" , cssPath, contentStr, dateString, jsPath];
    
    return load;
}

@end

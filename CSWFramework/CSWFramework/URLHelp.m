//
//  URLHelp.m
//  CSWFramework
//
//  Created by 007 on 16/7/11.
//  Copyright © 2016年 陈少文. All rights reserved.
//

#import "URLHelp.h"

@implementation URLHelp

+ (instancetype)shareURLHelp {
    static URLHelp *shaerURLHelp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shaerURLHelp = [[URLHelp alloc] init];
        shaerURLHelp.url = @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billCategory&format=json&from=ios&kflag=1&version=5.5.1&from=ios&channel=appstore";
        shaerURLHelp.url_songData = @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type=%@&format=json&offset=0&size=100&from=ios&fields=title,song_id,author,resource_type,havehigh,is_new,has_mv_mobile,album_title,ting_uid,album_id,charge,all_rate&version=5.5.1&from=ios&channel=appstore";
        shaerURLHelp.song_url = @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=1448284306&songid=%@%@";
        shaerURLHelp.song_url_x = @"&nw=2&l2p=2897.5&lpb=193088&ext=MP3&format=json&from=ios&usup=1&lebo=0&aac=0&ucf=4&vid=&res=2&e=NOY9TnalK3sTHsDcDyNRBHqApG4ORk4vmKD8QrlAJ8Q%3D&version=5.5.1&from=ios&channel=appstore";
    });
    return shaerURLHelp;
}

@end

//
//  AppDelegate.m
//  MacUDPClient
//
//  Created by Akihiro Okubo on 2014/06/22.
//  Copyright (c) 2014年 Akihiro Okubo. All rights reserved.
//

#import "AppDelegate.h"
#import <sys/types.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    int sock;
    struct sockaddr_in addr;
    int yes = 1;
    
    sock = socket(AF_INET, SOCK_DGRAM, 0);
    
    addr.sin_family = AF_INET;
    addr.sin_port = htons(30050);
    //addr.sin_addr.s_addr = inet_addr("10.0.1.3"); // 成功 setsockopt()不要。
    //addr.sin_addr.s_addr = INADDR_ANY; // 失敗　setsockopt()でも失敗
    addr.sin_addr.s_addr = INADDR_BROADCAST; // 成功　setsockopt()でも失敗
    
    // ブロードキャストを送信
    setsockopt(sock, SOL_SOCKET, SO_BROADCAST, (char *)&yes, sizeof(yes));
    
    size_t sendRet = 0;
    sendRet = sendto(sock, "HELLO", 5, 0, (struct sockaddr *)&addr, sizeof(addr));
    NSLog(@"send return=%zu", sendRet);
    
    close(sock);
}

@end

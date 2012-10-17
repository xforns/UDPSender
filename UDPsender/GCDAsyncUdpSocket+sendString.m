//
//  GCDAsyncUdpSocket+sendString.m
//  Lista de la compra
//
//  Created by Jordi Vila on 25/08/12.
//
//

#import "GCDAsyncUdpSocket+sendString.h"

@implementation GCDAsyncUdpSocket (sendString)


+ (GCDAsyncUdpSocket *)initSocket
{
    GCDAsyncUdpSocket *udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *host = [prefs valueForKey:@"host"];
    int port = [[prefs valueForKey:@"port"] integerValue];
    [udpSocket connectToHost:host onPort:port error:nil];
    
    return udpSocket;

}

+ (void)sendString:(NSString *)str toSocket:udpSocket
{
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int tag = [[prefs valueForKey:@"tag"] integerValue];
    [udpSocket sendData:data withTimeout:-1 tag:tag];
}

@end


//
//  GCDAsyncUdpSocket+sendString.h
//  Lista de la compra
//
//  Created by Jordi Vila on 25/08/12.
//
//

#import "GCDAsyncUdpSocket.h"

@interface GCDAsyncUdpSocket (sendString)

+ (GCDAsyncUdpSocket *)initSocket;
+ (void)sendString:(NSString *)str toSocket:udpSocket;

@end

//
//  BLparser.h
//  BLsimpleparser
//
//  Created by BLapple on 13-4-23.
//  Copyright (c) 2013年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLparserProtocol.h"








typedef NS_ENUM(NSInteger, BLParsertype) {
    BLdefaultparser=0,
    BLNSXMLParser=1,
    BLhtmlParser=2,
    
};

@interface BLparser : NSObject
{

}

@property(weak,nonatomic) id <BLparserdelegate> delegate;

//init
- (instancetype)initWithData:(NSData *)data parsertype:(BLParsertype)parsertype;
- (instancetype)initWithdata:(NSData*)data encoding:(NSStringEncoding)encoding parsertype:(BLParsertype)parsertype;

-(BOOL)parse;
-(BOOL)isparsing;
-(void)stopparse;






@end

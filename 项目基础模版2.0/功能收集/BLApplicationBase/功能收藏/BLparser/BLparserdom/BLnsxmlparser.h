//
//  BLnsxmlparser.h
//  BLsimpleparser
//
//  Created by BLapple on 13-4-23.
//  Copyright (c) 2013年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLparerbase.h"
@interface BLnsxmlparser : BLparerbase<NSXMLParserDelegate>
{
    NSXMLParser* parser;
    
}
@property(retain,nonatomic)NSXMLParser* parser;


@end

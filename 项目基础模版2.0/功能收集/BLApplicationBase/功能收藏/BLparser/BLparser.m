//
//  BLparser.m
//  BLsimpleparser
//
//  Created by BLapple on 13-4-23.
//  Copyright (c) 2013年 BLapple. All rights reserved.
//

#import "BLparser.h"
#import "BLparerbase.h"
#import "BLnsxmlparser.h"
//#import "BLhtmlparser.h"
@interface BLparser ()
{
    BLparerbase* parser;
}
-(BLparerbase*)parser;

-(void)setParser:(BLparerbase*)parser;

@end

@implementation BLparser
@synthesize delegate;




- (instancetype)initWithData:(NSData *)data parsertype:(BLParsertype)parsertype
{
    if(self = [super init])
    {
        switch (parsertype) {
            case BLdefaultparser:
                self.parser = [[BLnsxmlparser alloc]initWithData:data ] ;
                break;
            case BLNSXMLParser:
                self.parser = [[BLnsxmlparser alloc]initWithData:data  ] ;
                break;
            case BLhtmlParser:
                self.parser = [[BLnsxmlparser alloc]initWithData:data] ;
                break;
            default:
                self.parser = [[BLnsxmlparser alloc]initWithData:data  ] ;
                break;
        }
        parser.Handler=self;
    }
    return self;
}

-(instancetype)initWithdata:(NSData*)data encoding:(NSStringEncoding)encoding parsertype:(BLParsertype)parsertype
{
    if(self = [super init])
    {
        switch (parsertype) {
            case BLdefaultparser:
                self.parser = [[BLnsxmlparser alloc]initwithdata:data encoding:encoding] ;
                break;
            case BLNSXMLParser:
                self.parser = [[BLnsxmlparser alloc]initwithdata:data encoding:encoding];
                break;
            case BLhtmlParser:
                self.parser = [[BLnsxmlparser alloc]initwithdata:data encoding:encoding];
                break;
            default:
                self.parser = [[BLnsxmlparser alloc]initWithData:data  ] ;
                break;
        }
        parser.Handler=self;
    }
    return self;
}

-(void)setDelegate:(id<BLparserdelegate>)_delegate
{
    delegate=_delegate;
    [parser setDelegate:delegate];
    
}

-(BLparerbase*)parser
{
    return parser;
}

-(void)setParser:(BLparerbase*)_parser
{
     parser=_parser;
}


#pragma mark-func

-(BOOL)parse
{
    return      [self.parser parse];
}
-(BOOL)isparsing
{
    return      [self.parser isparsing];
}


-(void)stopparse
{
    
    [self.parser stopparse];
}









@end

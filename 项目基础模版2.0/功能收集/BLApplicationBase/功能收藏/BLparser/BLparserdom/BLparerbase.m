//
//  BLparerbase.m
//  BLsimpleparser
//
//  Created by BLapple on 13-4-23.
//  Copyright (c) 2013年 BLapple. All rights reserved.
//

#import "BLparerbase.h"

void startfunc(BLparerbase *myself)
{
    [myself.delegate BLparserDidStartDocument:myself.Handler];
}

void endfunc(BLparerbase *myself)
{
    [myself.delegate BLparserDidEndDocument:myself.Handler];
}

void elefunc(BLparerbase *myself,NSString* ele,NSDictionary* dic)
{
    [myself.delegate BLparser:myself.Handler didStartElement:ele attributes:dic];
}

void eleendfunc(BLparerbase *myself,NSString* ele)
{
    [myself.delegate BLparser:myself.Handler didEndElement:ele];
}

void strfunc(BLparerbase *myself,NSString* str)
{
    [myself.delegate BLparser:myself.Handler foundCharacters:str];
}

void commentfunc(BLparerbase *myself,NSString* comment)
{
    [myself.delegate BLparser:myself.Handler foundComment:comment];
}

void cdatafunc(BLparerbase *myself,NSData* cdata)
{
    [myself.delegate BLparser:myself.Handler foundCDATA:cdata];
}

void processfunc(BLparerbase *myself,NSString* target,NSString* prodata)
{
    [myself.delegate BLparser:myself.Handler foundProcessingInstructionWithTarget:target data:prodata];
}

void errorfunc(BLparerbase *myself,NSError* err)
{
    [myself.delegate BLparser:myself.Handler parseErrorOccurred:err];
}

@implementation BLparerbase
@synthesize Handler;
@synthesize data;
@synthesize isparsing;
@synthesize encoding;



-(id<BLparserdelegate>)delegate
{
    return delegate;
}

-(void)setDelegate:(id<BLparserdelegate>)_delegate
{
    delegate=_delegate;
    handler_func.startfunc=NULL;
    handler_func.endfunc=NULL;
    handler_func.elefunc=NULL;
    handler_func.eleendfunc=NULL;
    handler_func.strfunc=NULL;
    handler_func.commentfunc=NULL;
    handler_func.cdatafunc=NULL;
    handler_func.processfunc=NULL;
    handler_func.errorfunc=NULL;
    if(!delegate)
    {
        return;
    }
    if([delegate respondsToSelector:@selector(BLparserDidStartDocument:)])
    {
        handler_func.startfunc=startfunc;
    }
    if([delegate respondsToSelector:@selector(BLparserDidEndDocument:)])
    {
        handler_func.endfunc=endfunc;
    }
    if([delegate respondsToSelector:@selector(BLparser:didStartElement:attributes:)])
    {
        handler_func.elefunc=elefunc;
    }
    if([delegate respondsToSelector:@selector(BLparser:didEndElement:)])
    {
        handler_func.eleendfunc=eleendfunc;
    }
    if([delegate respondsToSelector:@selector(BLparser:foundCharacters:)])
    {
        handler_func.strfunc=strfunc;
    }
    if([delegate respondsToSelector:@selector(BLparser:foundComment:)])
    {
        handler_func.commentfunc=commentfunc;
    }
    if([delegate respondsToSelector:@selector(BLparser:foundCDATA:)])
    {
        handler_func.cdatafunc=cdatafunc;
    }
    if([delegate respondsToSelector:@selector(BLparser:foundProcessingInstructionWithTarget:data:)])
    {
        handler_func.processfunc=processfunc;
    }
    if([delegate respondsToSelector:@selector(BLparser:parseErrorOccurred:)])
    {
        handler_func.errorfunc=errorfunc;
    }
}

-(BOOL)parse
{
    return NO;
}


-(void)stopparse
{

}

- (id)initWithData:(NSData *)data
{
    return nil;
}
-(id)initwithdata:(NSData*)data encoding:(NSStringEncoding)encoding
{

    return nil;
}

- (NSError *)parserError
{
    return nil;
}






- (NSString *)publicID
{
    return nil;
}
- (NSString *)systemID
{
    return nil;
}
- (NSInteger)lineNumber
{
    return 0;
}
- (NSInteger)columnNumber
{
    return 0;
}
@end

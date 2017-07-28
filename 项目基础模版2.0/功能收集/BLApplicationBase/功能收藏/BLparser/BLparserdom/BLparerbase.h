//
//  BLparerbase.h
//  BLsimpleparser
//
//  Created by BLapple on 13-4-23.
//  Copyright (c) 2013年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLparserProtocol.h"
@class BLparerbase;
typedef void (*DidStartDocument) (BLparerbase* base);
typedef void (*DidEndDocument) (BLparerbase* base);
typedef void (*DidStartElement) (BLparerbase *myself,NSString* ele,NSDictionary* dic);
typedef void (*DidEndElement) (BLparerbase *myself,NSString* ele);
typedef void (*FoundCharacters) (BLparerbase *myself,NSString* str);
typedef void (*FoundComment) (BLparerbase *myself,NSString* comment);
typedef void (*FoundCDATA) (BLparerbase *myself,NSData* cdata);
typedef void (*FoundProcessing) (BLparerbase *myself,NSString* target,NSString* data);
typedef void (*ParseError) (BLparerbase *myself,NSError* err);

typedef struct _BLparseHandler BLparseHandler ;


struct _BLparseHandler{
    DidStartDocument startfunc;
    DidEndDocument   endfunc;
    DidStartElement  elefunc;
    DidEndElement    eleendfunc;
    FoundCharacters  strfunc;
    FoundComment     commentfunc;
    FoundCDATA       cdatafunc;
    FoundProcessing  processfunc;
    ParseError       errorfunc;
};



@interface BLparerbase : NSObject
{
    BOOL isparsing;
    id<BLparserdelegate>delegate;
    
    BLparseHandler handler_func;
    NSData* data;
    NSStringEncoding encoding;
}
@property(assign,nonatomic)id Handler;
@property(retain,nonatomic)NSData* data;
@property(assign,nonatomic)BOOL isparsing;
@property(readwrite)NSStringEncoding encoding;



-(id)initWithData:(NSData *)data;
-(id)initwithdata:(NSData*)data encoding:(NSStringEncoding)encoding;

-(id<BLparserdelegate>)delegate;
-(void)setDelegate:(id<BLparserdelegate>)delegate;


-(BOOL)parse;
-(void)stopparse;
- (NSError *)parserError;





- (NSString *)publicID;
- (NSString *)systemID;
- (NSInteger)lineNumber;
- (NSInteger)columnNumber;
@end

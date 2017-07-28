//
//  BLnsxmlparser.m
//  BLsimpleparser
//
//  Created by BLapple on 13-4-23.
//  Copyright (c) 2013年 BLapple. All rights reserved.
//

#import "BLnsxmlparser.h"
@interface BLnsxmlparser()

-(id)initData:(NSData *)data;

@end



@implementation BLnsxmlparser
@synthesize parser;



#pragma mark-init
-(id)initData:(NSData *)_data
{
    if(!_data)
    {
        return nil;
    }
    if(self=[super init])
    {
        self.parser = [[NSXMLParser alloc]initWithData:_data ] ;
        parser.delegate=self;
        [parser setShouldProcessNamespaces:NO];
        [parser setShouldReportNamespacePrefixes:NO];
        [parser setShouldResolveExternalEntities:NO];
        isparsing=NO;
    }
    return self;

}

- (id)initWithData:(NSData *)_data
{
    self.encoding=NSUTF8StringEncoding;
    return [self initData:_data];
}

-(id)initwithdata:(NSData*)_data encoding:(NSStringEncoding)_encoding
{
    self.encoding=_encoding;
    return [self initData:_data];
}

#pragma mark-funck
-(BOOL)parse
{

    BOOL p=[parser parse];
    isparsing=p;
    
    return p;
    
}


-(void)stopparse
{
    [parser abortParsing];
}




#pragma mark-nsxmlparser
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    isparsing=YES;
    if(handler_func.startfunc!=NULL)
    {
    DidStartDocument func=handler_func.startfunc;
        func(self);
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    isparsing=NO;
    if(handler_func.startfunc!=NULL)
    {
        DidEndDocument func=handler_func.endfunc;
        func(self);
    }
}

//- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID
//{
//    
//}

//- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName
//{
//    
//}


//- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue
//{
//    
//}


//- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model
//{
//    
//}

//- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value
//{
//    
//}


//- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID
//{
//    
//}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if(handler_func.elefunc!=NULL)
    {
        DidStartElement func=handler_func.elefunc;
        func(self,elementName,attributeDict);
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if(handler_func.eleendfunc!=NULL)
    {
        DidEndElement func=handler_func.eleendfunc;
        func(self,elementName);
    }
}

//- (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI
//{
//
//}

//- (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix
//{
// 
//    
//}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(handler_func.strfunc!=NULL)
    {
        FoundCharacters func=handler_func.strfunc;
        func(self,string);
    }
}

//- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString
//{
// 
//}

- (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)_data
{
    if(handler_func.processfunc!=NULL)
    {
        FoundProcessing func=handler_func.processfunc;
        func(self,target,_data);
    }
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment
{
    if(handler_func.commentfunc!=NULL)
    {
        FoundComment func=handler_func.commentfunc;
        func(self,comment);
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    if(handler_func.cdatafunc!=NULL)
    {
        FoundCDATA func=handler_func.cdatafunc;
        func(self,CDATABlock);
    }
    
}

//- (NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)name systemID:(NSString *)systemID
//{
//    
//    
//}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if(handler_func.errorfunc!=NULL)
    {
        ParseError func=handler_func.errorfunc;
        func(self,parseError);
    }
}

//- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
//{
//  
//    
//}

- (NSError *)parserError
{
    return [parser parserError];
}
#pragma mark- systeminfo
- (NSString *)publicID
{

    return [parser publicID];
}
- (NSString *)systemID
{
    return [parser systemID];
}
- (NSInteger)lineNumber
{
    return  [parser lineNumber];
}
- (NSInteger)columnNumber
{
    return [parser columnNumber];
}


@end

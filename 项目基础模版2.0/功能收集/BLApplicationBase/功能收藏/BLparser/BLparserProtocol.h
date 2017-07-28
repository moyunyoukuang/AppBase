



@class BLparser;
@protocol BLparserdelegate <NSObject>
@optional

- (void)BLparserDidStartDocument:(BLparser *)parser;


- (void)BLparserDidEndDocument:(BLparser *)parser;


- (void)BLparser:(BLparser *)parser didStartElement:(NSString *)elementName attributes:(NSDictionary *)attributeDict;


- (void)BLparser:(BLparser *)parser didEndElement:(NSString *)elementName;


- (void)BLparser:(BLparser *)parser foundCharacters:(NSString *)string;


- (void)BLparser:(BLparser *)parser foundComment:(NSString *)comment;

- (void)BLparser:(BLparser *)parser foundCDATA:(NSData *)CDATABlock;


- (void)BLparser:(BLparser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)data;


- (void)BLparser:(BLparser *)parser parseErrorOccurred:(NSError *)parseError;

@end


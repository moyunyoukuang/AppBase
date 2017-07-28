//
//  BLparserfordata.h
//  superreader
//
//  Created by BLapple on 13-10-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLparser.h"
@interface BLparserfordata : NSObject<BLparserdelegate>
{
    NSMutableArray* Rows;
    BOOL  openitems;
    NSMutableArray* foritems;
}
@property(retain,nonatomic) NSMutableArray* Rows;
@property(retain,nonatomic)NSMutableArray* foritems;

-(NSArray*)BLparsedata:(NSData*)data   foritems:(NSMutableArray*)items;
@end

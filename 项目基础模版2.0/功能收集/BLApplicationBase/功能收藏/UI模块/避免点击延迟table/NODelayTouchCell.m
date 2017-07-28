//
//  NODelayTouchCell.m
//  DaJiShi
//
//  Created by camore on 17/3/13.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "NODelayTouchCell.h"

@implementation NODelayTouchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {

        
        
        for (id obj in self.subviews)
        {
            if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
                
            {
                UIScrollView *scroll = (UIScrollView *) obj;
                
                scroll.delaysContentTouches =NO;
                break;
                
            }
        }
    }
    return self;
    
}

@end

//
//  NODelayTouchTable.m
//  DaJiShi
//
//  Created by camore on 17/3/13.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "NODelayTouchTable.h"

@implementation NODelayTouchTable

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.tableFooterView = [[BLView alloc] init];
        self.separatorColor  = [UIColor clearColor];
        self.separatorStyle  = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        
        for (id view in self.subviews)
        {
            // looking for a UITableViewWrapperView
            if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"])
            {
                if([view isKindOfClass:[UIScrollView class]])
                {
                    // turn OFF delaysContentTouches in the hidden subview
                    UIScrollView *scroll = (UIScrollView *) view;
                    scroll.delaysContentTouches = NO;
                }
                break;
            }
        }
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}
@end

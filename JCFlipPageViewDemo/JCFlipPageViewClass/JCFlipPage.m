//
//  JCFlipPage.m
//  JCFlipPageView
//
//  Created by ThreegeneDev on 14-8-8.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "JCFlipPage.h"

@implementation JCFlipPage
@synthesize reuseIdentifier = _reuseIdentifier;

- (void)dealloc
{
}

- (void)prepareForReuse
{
    
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _reuseIdentifier = reuseIdentifier;
        
        _tempContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 300.0f, 400.0f)];
        _tempContentLabel.numberOfLines = 0;
        _tempContentLabel.text = @"Page";
        [self addSubview:_tempContentLabel];
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

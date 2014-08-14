//
//  JCFlipPageView.m
//  JCFlipPageView
//
//  Created by Jimple on 14-8-7.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "JCFlipPageView.h"
#import "JCFlipViewAnimationHelper.h"
#import "JCFlipPage.h"

static NSUInteger kReusableArraySize = 5;


@interface JCFlipPageView ()
<
    JCFlipViewAnimationHelperDataSource,
    JCFlipViewAnimationHelperDelegate
>

@property (nonatomic, strong) JCFlipViewAnimationHelper *flipAnimationHelper;

@property (nonatomic, assign) NSUInteger numberOfPages;
@property (nonatomic, strong) JCFlipPage *currPage;
@property (nonatomic, assign) NSUInteger currIndex;

@property (nonatomic, strong) NSMutableDictionary *reusablePagesDic;

@end

@implementation JCFlipPageView
@synthesize dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initalizeView];
        
    }
    return self;
}

- (void)dealloc
{
    if (_currPage)
    {
        [_currPage removeFromSuperview];
    }else{}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)reloadData
{
    [self cleanupPages];
    
    _numberOfPages = [self pagesCount];
    if (_numberOfPages > 0)
    {
        [self flipToPageAtIndex:0 animation:NO];
    }else{}
}

- (void)flipToPageAtIndex:(NSUInteger)pageNumber animation:(BOOL)animation
{
    if ((pageNumber < _numberOfPages) && (pageNumber != _currIndex))
    {
        if (animation)
        {
            [_flipAnimationHelper flipToDirection:((_currIndex > pageNumber) ? kEFlipDirectionToPrePage : kEFlipDirectionToNextPage) duration:0.3f];
        }
        else
        {
            if (_currPage)
            {
                [_currPage removeFromSuperview];
                _currPage = nil;
            }else{}
            _currPage = [self.dataSource flipPageView:self pageAtIndex:pageNumber];
            [[self reusableViewsWithReuseIdentifier:_currPage.reuseIdentifier] removeObject:_currPage];
            [self addSubview:_currPage];
            _currIndex = pageNumber;
        }
    }
    else
    {
        // do nothing
    }
}

- (JCFlipPage *)dequeueReusablePageWithReuseIdentifier:(NSString *)reuseIdentifier
{
    JCFlipPage *page = [[self reusableViewsWithReuseIdentifier:reuseIdentifier] anyObject];
    if (page)
    {
        [[self reusableViewsWithReuseIdentifier:reuseIdentifier] removeObject:page];
    }else{}
    
    return page;
}

#pragma mark - JCFlipViewAnimationHelperDataSource
- (UIView *)flipViewAnimationHelperGetPreView:(JCFlipViewAnimationHelper *)helper
{
    UIView *preView;
    if (_currIndex > 0)
    {
        preView = [self.dataSource flipPageView:self pageAtIndex:_currIndex-1];
    }else{}
    
    return preView;
}

- (UIView *)flipViewAnimationHelperGetCurrentView:(JCFlipViewAnimationHelper *)helper
{
    return _currPage;
}

- (UIView *)flipViewAnimationHelperGetNextView:(JCFlipViewAnimationHelper *)helper
{
    UIView *nextView;
    if (_currIndex < (_numberOfPages - 1))
    {
        nextView = [self.dataSource flipPageView:self pageAtIndex:_currIndex+1];
    }else{}
    
    return nextView;
}

#pragma mark - JCFlipViewAnimationHelperDelegate
- (void)flipViewAnimationHelperBeginAnimation:(JCFlipViewAnimationHelper *)helper
{
    _currPage.hidden = YES;
}

- (void)flipViewAnimationHelperEndAnimation:(JCFlipViewAnimationHelper *)helper
{
    _currPage.hidden = NO;
}

- (void)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper flipCompletedToDirection:(EFlipDirection)direction
{
    NSUInteger newIndex = _currIndex;
    switch (direction)
    {
        case kEFlipDirectionToPrePage:
        {
            newIndex = _currIndex - 1;
        }
            break;
        case kEFlipDirectionToNextPage:
        {
            newIndex = _currIndex + 1;
        }
            break;
        default:
            break;
    }
    
    if (newIndex != _currIndex)
    {
        _currIndex = newIndex;
        if (_currPage)
        {
            [self recoveryPage:_currPage];
        }else{}
        _currPage = [self.dataSource flipPageView:self pageAtIndex:newIndex];
        [self addSubview:_currPage];
    }else{}
}

#pragma mark -
- (void)initalizeView
{
    _flipAnimationHelper = [[JCFlipViewAnimationHelper alloc] initWithHostView:self];
    _flipAnimationHelper.dataSource = self;
    _flipAnimationHelper.delegate = self;
    _currIndex = -1;
    _numberOfPages = 0;
}

- (void)cleanupPages
{
    _numberOfPages = 0;
    if (_currPage)
    {
        [self recoveryPage:_currPage];
    }else{}
}

- (NSUInteger)pagesCount
{
    NSInteger count = 0;
    
    count = [self.dataSource numberOfPagesInFlipPageView:self];
    
    return count;
}

- (NSMutableSet *)reusableViewsWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (!_reusablePagesDic)
    {
        _reusablePagesDic = [[NSMutableDictionary alloc] init];
    }else{}
    NSString *reuseID = reuseIdentifier ? reuseIdentifier : kJCFlipPageDefaultReusableIdentifier;

    NSMutableSet *reusablePages = [_reusablePagesDic objectForKey:reuseID];
    if (!reusablePages)
    {
        reusablePages = [[NSMutableSet alloc] init];
        [_reusablePagesDic setObject:reusablePages forKey:reuseID];
    }
    return reusablePages;
}

- (void)recoveryPage:(JCFlipPage *)page
{
    if (page)
    {
        if ([self reusableViewsWithReuseIdentifier:_currPage.reuseIdentifier].count < kReusableArraySize)
        {
            [[self reusableViewsWithReuseIdentifier:_currPage.reuseIdentifier] addObject:page];
        }else{}
        [page removeFromSuperview];
        page = nil;
    }else{}
}
























@end

//
//  JCFlipViewAnimationHelper.h
//  JCFlipPageView
//
//  Created by Jimple on 14-8-8.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EFlipDirection)
{
    kEFlipDirectionToPrePage               = 0,
    kEFlipDirectionToNextPage
};

@protocol JCFlipViewAnimationHelperDataSource;
@protocol JCFlipViewAnimationHelperDelegate;
@interface JCFlipViewAnimationHelper : NSObject

@property (nonatomic, weak) id<JCFlipViewAnimationHelperDataSource> dataSource;
@property (nonatomic, weak) id<JCFlipViewAnimationHelperDelegate> delegate;

- (instancetype)initWithHostView:(UIView *)hostView;

@end

@protocol JCFlipViewAnimationHelperDataSource <NSObject>

- (UIView *)flipViewAnimationHelperGetPreView:(JCFlipViewAnimationHelper *)helper;
- (UIView *)flipViewAnimationHelperGetCurrentView:(JCFlipViewAnimationHelper *)helper;
- (UIView *)flipViewAnimationHelperGetNextView:(JCFlipViewAnimationHelper *)helper;

@end

@protocol JCFlipViewAnimationHelperDelegate <NSObject>

- (void)flipViewAnimationHelperBeginAnimation:(JCFlipViewAnimationHelper *)helper;
- (void)flipViewAnimationHelperEndAnimation:(JCFlipViewAnimationHelper *)helper;

- (void)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper flipCompletedToDirection:(EFlipDirection)direction;

@end

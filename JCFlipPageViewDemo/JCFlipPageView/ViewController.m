//
//  ViewController.m
//  JCFlipPageView
//
//  Created by ThreegeneDev on 14-8-7.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "ViewController.h"
#import "JCFlipPageView.h"
#import "JCFlipPage.h"

@interface ViewController ()
<JCFlipPageViewDataSource>

@property (nonatomic, strong) JCFlipPageView *flipPage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _flipPage = [[JCFlipPageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_flipPage];
    
    _flipPage.dataSource = self;
    [_flipPage reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mar - JCFlipPageViewDataSource
- (NSUInteger)numberOfPagesInFlipPageView:(JCFlipPageView *)flipPageView
{
    return 20;
}
- (JCFlipPage *)flipPageView:(JCFlipPageView *)flipPageView pageAtIndex:(NSUInteger)index
{
    static NSString *kPageID = @"numberPageID";
    JCFlipPage *page = [flipPageView dequeueReusablePageWithReuseIdentifier:kPageID];
    if (!page)
    {
        page = [[JCFlipPage alloc] initWithFrame:flipPageView.bounds reuseIdentifier:kPageID];
    }else{}
    
    page.tempContentLabel.text = @"";
    for (int j = 0; j < 500; j++)
    {
        page.tempContentLabel.text = [NSString stringWithFormat:@"%@ %d", page.tempContentLabel.text, index];
    }
    
    return page;
}






























@end

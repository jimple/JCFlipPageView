JCFlipPageView
==============

一个类似存折那样翻页的视图。

原来想直接修改 AFKPageFlipper（https://github.com/mtabini/AFKPageFlipper） 实现这个效果，可是觉得里面不太符合要求，所以重写此视图。
感谢AFKPageFlipper提供了代码参考。

说明：

 - JCFlipPageView
  主视图（类似UITableView）

 - JCFlipPage
  加入到主视图里用来显示的页面。（类似UITableViewCell）

 - JCFlipViewAnimationHelper
  实现卡片翻页动画效果。
  具体原理为开始翻页动作时，在JCFlipPageView上加一个layer作为容器，同时获取当前页和下一页的截图。
  以由上往下翻为例：
    1、容器layer上半部分放下一页的上半部分，容器layer下半部分放当前页的下半部分。
    2、然后再放一个只有半页大小的layer，用来显示翻页的动画。
    3、翻页layer里放两个子layer，分别是上面下一页的下半部分，下面放当前页的上半部分。

未完成功能：
 - 直接翻到某页时的动画效果未实现。
 - 直接翻到多页以后，比如从第一页翻到第十页，多页面翻动的效果未实现。


 

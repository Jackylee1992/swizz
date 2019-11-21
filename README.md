# swizz
Swizz a class's method implementation.
Print a class's public and private property list and method list.


## Method List

```objc
@interface NSObject (swizz)

/**
 swizzle method
 */
+ (void)exchangeMethod:(SEL)oriSEL;

/**
 print property and ivar list
 */
+ (void)printIvarList;

/**
 print method list
 */
+ (void)printMethodList;

@end

```

## Usage

For example check UIStatusBarManager out which was introduced in iOS13.

```objc
#import "ViewController.h"
#import "NSObject+swizz.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [UIStatusBarManager printIvarList];
    [UIStatusBarManager printMethodList];
}

@end

/// console log
ivar: _statusBarHidden class: B
ivar: _inStatusBarFadeAnimation class: B
ivar: _statusBarStyle class: q
ivar: _windowScene class: @"UIWindowScene"
ivar: _localStatusBars class: @"NSMutableSet"
ivar: _statusBarPartStyles class: @"NSDictionary
ivar: _statusBarAlpha class: d
ivar: _debugMenuHandler class: @?
方法: .cxx_destruct () return: v 
方法: windowScene () return: @ 
方法: statusBarFrame () return: {CGRect={CGPoint=
方法: _setScene: (参数1 @ ) return: v 
方法: initWithScene: (参数1 @ ) return: @ 
方法: _scene () return: @ 
方法: _settingsDiffActionsForScene: (参数1 @ ) ret
方法: setWindowScene: (参数1 @ ) return: v 
方法: isStatusBarHidden () return: B 
方法: statusBarStyle () return: q 
方法: statusBarHeight () return: d 
方法: setDebugMenuHandler: (参数1 @? ) return: v 
方法: handleTapAction: (参数1 @ ) return: v 
方法: _updateAlpha () return: B 
方法: statusBarHidden () return: B 
方法: statusBarPartStyles () return: @ 
方法: statusBarAlpha () return: d 
方法: defaultStatusBarHeightInOrientation: (参数1 
方法: updateStatusBarAppearance () return: v 
方法: updateLocalStatusBars () return: v 
方法: setupForSingleLocalStatusBar () return: v 
方法: statusBarFrameForStatusBarHeight: (参数1 d )
方法: updateStatusBarAppearanceWithAnimationParam
方法: _updateStatusBarAppearanceWithClientSetting
方法: _updateVisibilityForWindow:targetOrientatio
方法: _updateStyleForWindow:animationParameters: 
方法: _visibilityChangedWithOriginalOrientation:t
方法: activateLocalStatusBar: (参数1 @ ) return: v
方法: _updateLocalStatusBar: (参数1 @ ) return: v 
方法: _handleScrollToTopAtXPosition: (参数1 d ) re
方法: _adjustedLocationForXPosition: (参数1 d ) re
方法: updateStatusBarAppearanceWithClientSettings
方法: deactivateLocalStatusBar: (参数1 @ ) return:
方法: createLocalStatusBar () return: @ 
方法: localStatusBars () return: @ 
方法: setLocalStatusBars: (参数1 @ ) return: v 
方法: isInStatusBarFadeAnimation () return: B 
方法: debugMenuHandler () return: @? 

```

## 如何检测在 iOS13 上状态栏的点击事件 How to detect a status bar click event in iOS13?
在 iOS13 上状态栏的点击事件由 UIStatusBarManager 单独管理，通过打印 UIStatusBarManager 的私有方法，找到点击事件的处理方法 handleTapAction:，通过 hook 该方法发送自定义通知，即可通过监听改通知来实现自定义的状态栏点击处理。代码如下：
```objc

#ifdef __IPHONE_13_0

#import "UIStatusBarManager+IKHandleTapAction.h"
#import <RSSwizzle/RSSwizzle.h>

@implementation UIStatusBarManager (IKHandleTapAction)

+ (void)load {
    if (@available(iOS 13.0, *)) {
        SEL sel = NSSelectorFromString(@"handleTapAction:");
        if ([UIStatusBarManager instancesRespondToSelector:sel]) {
            RSSwizzleInstanceMethod(UIStatusBarManager,
                                    NSSelectorFromString(@"handleTapAction:"),
                                    RSSWReturnType(void),
                                    RSSWArguments(id object),
                                    RSSWReplacement({
                RSSWCallOriginal(object);
                if (@available(iOS 13.0, *)) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:IKStatusBarWidnowTapActionNotification object:nil];
                }
            }), RSSwizzleModeAlways, NULL);
        }
    }
}

@end

#endif

```



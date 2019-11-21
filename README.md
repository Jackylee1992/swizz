# swizz
Swizz a class's method implementation.
Print a class's public and private property list and method list.


## Method List

```objc
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

```

## Usage
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
```





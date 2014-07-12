MGFashionMenuView
===============

MGFashionMenuView is a view with an awesome animation when it is shown/hidden. It is useful to present a menu, a notification or an action button.

## Info

This code must be used under ARC. 
If your code doesn't use ARC you can [mark this source with the compiler flag](http://www.codeography.com/2011/10/10/making-arc-and-non-arc-play-nice.html) `-fobjc-arc` 

## Example Usage

In the package is included the project to test the object.
This is an easy example to init and use the control:

``` objective-c
    //Init the control
    MGFashionMenuView *menuView = [[MGFashionMenuView alloc] initWithMenuView:myViewToPresent andAnimationType:MGAnimationTypeWave];
    [self.view addSubview:menuView];
    
    //Show/hide menu
    [menuView show];
    [menuView hide];
```

Useful properties:

``` objective-c
    //Access to property to know if the control is shown or not
    [menuView isShown];
    
    //Access to property to know if the control is performing the animation or not
    [menuView isAnimating];
```

## Contact

Matteo Gobbi

- http://www.matteogobbi.it
- http://github.com/matteogobbi
- http://twitter.com/matteo_gobbi
- https://angel.co/matteo-gobbi
- http://www.linkedin.com/profile/view?id=24211474

## License

MGFashionMenuView is available under the MIT license.

A simple frosty loader, similar to the one used in the <a href="https://github.com/typhoon-framework/Typhoon-Swift-Example">Typhoon Sample Application</a>.

![Weather Report](http://www.typhoonframework.org/images/portfolio/PocketForecast3.gif)

#Setup

```Objective-C

//Required : The logo image to display
[ICLoader setImageName:anImageName]; 
// . . the image@2x should be about 85px across, and half as high

//Optional
[ICLoader setFontname:aFontName];
```

#Usage

```Objective-C
[ICLoader present];

//do some things

[ICLoader dismiss];
```

ICLoader is presented in the root view controller's view. 

#Installation

Installation is via <a href="http://www.cocoapods.org/?q=ICLoader">CocoaPods</a>.

```ruby
pod 'ICLoader'
```



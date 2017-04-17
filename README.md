Pocket Forecast (Swift)
==========================

An example application built with <a href ="http://typhoonframework.org/">Typhoon</a>.

* Looking for an Objective-C sample application? We <a href="https://github.com/appsquickly/Typhoon-example">have one here</a>. 

### Features: 

* Returns weather reports from a remote cloud service
* Caches weather reports locally, for later off-line use. 
* Stores (creates, reads, updates deletes) the cities that the user is interested in receiving reports for. 
* Can use metric or imperial units. 
* Displays a different theme (background image, colors, etc) on each run. 


***NB: The free weather API that we were using no longer includes forecast information, so this won't be displayed in the app until we find an alternative. The concepts remain the same.***

### Running the sample:

* Clone this repository, open the Xcode project in your favorite IDE, and run it. It'll say you need an API key.
* Get an API key from https://developer.worldweatheronline.com/ 
* Using your API key, set the <a href="https://github.com/typhoon-framework/Typhoon-example/blob/master/PocketForecast/Assembly/Configuration.plist">application configuration</a>.
* Run the App in the simulator or on your device. Look up the weather in your town, and put a jacket on, if you need 
to (Ha!). Now, proceed to the exercises below. 

### Exercises

1. Study the <a href="https://github.com/typhoon-framework/Typhoon-Swift-Example/blob/master/PocketForecast/Assembly/CoreComponents.swift">core components</a>, 
<a href="https://github.com/typhoon-framework/Typhoon-Swift-Example/blob/master/PocketForecast/Assembly/ApplicationAssembly.swift">view controllers</a> and <a href="https://github.com/typhoon-framework/Typhoon-Swift-Example/blob/master/PocketForecast/Assembly/ThemeAssembly.swift">themes</a>. 
Notice how the framework allows you to group related components together. Notice how dependency injection allows for 
centralized configuration, at the same time as using aggressive memory management. (With default prototype-scope, components will go away 
whenever they're not being used). 
1. Study the <a href="https://github.com/typhoon-framework/Typhoon-Swift-Example/tree/master/PocketForecastTests/Integration">test cases</a>.
Imagine that you needed to use one service URL for integration tests and another for production. How would you do it?
1. Imagine that you decided to save the list of cities that the user wants to get reports for to iCloud, instead of 
locally on the device. Notice how you'd only need to change one line of code to supply your new implementation in 
place of the old one. And you'd be able to reuse the existing test cases. 
1. Imagine that you'd like to integrate with other weather data providers, and let the user choose at runtime. How would you do it? 
1. Try writing the same Application without dependency injection. What would the code look like? 



### The App 
![Weather Report](http://typhoonframework.org/images/portfolio/PocketForecast3.gif)
![Weather Report](http://typhoonframework.org/images/portfolio/pf-beach1.png)
![Weather Report](http://typhoonframework.org/images/portfolio/pf-lights1.png)

### I'm blown away!

Typhoon is a non-profit, community driven project. We only ask that if you've found it useful to star us on Github or send a tweet mentioning us (<a href="https://twitter.com/appsquickly">@appsquickly</a>). If you've written Typhoon related blog or tutorial, or published a new Typhoon powered app, we'd certainly be happy to hear about that too. 

Typhoon is sponsored and lead by <a href="http://appsquick.ly">AppsQuick.ly</a> with <a href="https://github.com/appsquickly/Typhoon/graphs/contributors">contributions from around the world</a>. 

***Thanks @hongcheng for the excellent <a href="https://github.com/honcheng/PaperFold-for-iOS">Paperfold</a> animation, and @michaeljbishop for the <a href="https://github.com/michaeljbishop/NGAParallaxMotion">parallax effect</a>. ***






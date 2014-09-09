Typhoon-example
==========================

An example application built with <a href ="http://www.typhoonframework.org">Typhoon</a>.

###Features: 

* Returns weather reports from a remote cloud service
* Caches weather reports locally, for later off-line use. 
* Stores (creates, reads, updates deletes) the cities that the user is interested in receiving reports for. 
* Can use metric or imperial units. 
* Displays a different theme (background image, colors, etc) on each run. 

###Running the sample:

* Clone this repository, open the Xcode project in your favorite IDE, and run it. It'll say you need an API key.
* Get an API key from http://developer.worldweatheronline.com. 
* Using your API key, set the <a href="https://github.com/typhoon-framework/Typhoon-example/blob/master/PocketForecast/Assembly/Configuration.properties">application configuration</a>.
* Run the App in the simulator or on your device. Look up the weather in your town, and put a jacket on, if you need 
to (Ha!). Now, proceed to the exercises below. 

### Exercises

1. Study the <a href="https://github.com/typhoon-framework/Typhoon-example/blob/master/PocketForecast/Assembly/Blocks/PFCoreComponents.m">core components</a>, 
<a href="https://github.com/typhoon-framework/Typhoon-example/blob/master/PocketForecast/Assembly/Blocks/PFAssembly.m">view controllers</a> and <a href="https://github.com/typhoon-framework/Typhoon-example/blob/master/PocketForecast/Assembly/Blocks/PFThemeProvider.m">theme provider</a>. 
Notice how the framework allows you to group related components together. Notice how dependency injection allows for 
centralized configuration, at the same time as using aggressive memory management. (With default prototype-scope, components will go away 
whenever they're not being used). 
1. Study the <a href="https://github.com/typhoon-framework/Typhoon-example/tree/master/PocketForecastTests/Integration">test cases</a>.
Imagine that you needed to use one service URL for integration tests and another for production. How would you do it?
1. Imagine that you decided to save the list of cities that the user wants to get reports for to iCloud, instead of 
locally on the device. Notice how you'd only need to change one line of code to supply your new implementation in 
place of the old one. And you'd be able to reuse the existing test cases. 
1. Imagine that you'd like to integrate with other weather data providers, and let the user choose at runtime. How would you do it? 
1. Try writing the same Application without dependency injection. What would the code look like? 



### The App 
![Weather Report](http://www.typhoonframework.org/images/portfolio/PocketForecast3.gif)
![Weather Report](http://www.typhoonframework.org/images/portfolio/pf-beach1.png)
![Weather Report](http://www.typhoonframework.org/images/portfolio/pf-lights1.png)

***Thanks @hongcheng for the excellent <a href="https://github.com/honcheng/PaperFold-for-iOS">Paperfold</a> animation, and @michaeljbishop for the <a href="https://github.com/michaeljbishop/NGAParallaxMotion">parallax effect</a>. ***

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/0e47e2f2028b2badfc88e13f95914938 "githalytics.com")](http://githalytics.com/jasperblues/Typhoon)





# WeatherInformation

**WeatherInformation** is a simple iPhone application which allows user to input city as per choice and App will display current temperature of that city. By default app will display temperature in Fahrenheit mode and user can chagne mode of temperature from settings screen.

WeatherInformation Application has been developed in Swift 5, following MVVM design pattern and Test-driven development approach.  Used **OpenWeatherMap** API to get current weather information. Below screenshots shows Application structure and testcase results. 

<img width="1139" alt="Screenshot 2022-04-13 at 10 01 14 AM" src="https://user-images.githubusercontent.com/103521381/163100595-dadf3b2c-805a-4186-99ee-4e036c95e13e.png">

 
## Supported version
- iOS 15 onwards  

## Requirements
 Xcode 13+ , iOS Simulator/ iPhone Device (iOS 15 onwards) 

## How to build

1) Clone the repository
$ git clone https://github.com/iosdevsatyadip/WeatherInformationIOS.git
2) Open Terminal and move to project location by cd command 
3) pod install (Install pod using this command) 
5) After successfully pod installation  open **WeatherInformation.xcworkspace** file and run on iPhone device / simulator (iOS 15 onwards)

## Key Swift Features

* Test-driven development 
* MVVM design pattern 
* Network call 
* Network Reachability
* Protocol-Oriented Programming 
* Dependency Injection
* Swiftlint
* Unit Tests
* UI Tests
* Storyboard 

## Pods 

* pod 'MBProgressHUD'
* pod 'ReachabilitySwift'
* pod 'SwiftLint'
  
## Screenshots

![Simulator Screen Shot - iPhone 12 Pro Max - 2022-04-12 at 21 31 49](https://user-images.githubusercontent.com/103521381/163005848-364afd92-466e-4dd4-a6d7-9b63652015eb.png)

Landing screen - Click on Setting to change unit and + to add city 

![Simulator Screen Shot - iPhone 12 Pro Max - 2022-04-12 at 21 33 06](https://user-images.githubusercontent.com/103521381/163006026-5591bf22-629a-444d-80a1-192e4af7f4b0.png)

User can able to change unit from this screen 

![Simulator Screen Shot - iPhone 12 Pro Max - 2022-04-12 at 21 32 08](https://user-images.githubusercontent.com/103521381/163006163-b2564f1e-880a-4179-8241-5ce88df2de6d.png)

Add city Screen 

![Simulator Screen Shot - iPhone 12 Pro Max - 2022-04-12 at 21 32 59](https://user-images.githubusercontent.com/103521381/163006252-12690849-4209-4e6b-9b31-f0a500cab1e0.png)

Displaying current temperature of saved city 

![Simulator Screen Shot - iPhone 12 Pro Max - 2022-04-12 at 21 33 31](https://user-images.githubusercontent.com/103521381/163006379-62fcbae8-1fcf-4dbf-9e39-8817409daed0.png)

Network connection error 


## Notes 
WeatherInformation application is tested in iPhone simulator (iOS 15.2) and not tested in real device. WeatherInformation application supports portrait mode only. 

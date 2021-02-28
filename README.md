# WeatherForecast
WeatherForecast is an application to retrieve weather information within 5-7 days.

## Screenshot
![](/screenshots/screenshot.png)

## Overview
### Architectural pattern: MVVM
```
| WeatherForecast/
|--- Configuration/
|--- ApiSerice/
|--- LocalDatabaseService/
|--- Decorator/
|--- Model/      
|--- Controllers/
|    |--- Weather
|    |    |--- ViewModel
|    |    |--- View
|--- Utils/
| WeatherForecastTests
| WeatherForecastUITests
```
### Design patterns: 
1. Decorator: handle scaling text for the disability.
2. Singleton: handle calling APIs, insert/get the weather information from the cache.

### Libraries: 
1. SwiftLint: to check automatically coding conventions.

## Installation
1. Download **[the ZIP](https://github.com/hoangthuytruc/WeatherForecast/releases/tag/v1.0)** for the lastest release.
2. Extract the content of the zip archive in your project directory.
3. Open the terminal, run commands:
```
  cd 'your project directory'
  pod install
```
*Note: If CocoaPods have not been installed, run command:*
```
  $ sudo gem install cocoapods
```
4. Open the file `WeatherForecast.xcworkspace` and **Run**

## Checklist
- [x] Be able to retrieve the weather information from `OpenWeatherMaps API`.
- [x] Allow user to search the information by city's name.
- [x] Handle the search item length must be 3 chracters or above.
- [x] Render the searched results as a list of weather items.
- [x] Support caching mechanism & lifecycle.
- [x] Handle failures.
- [x] Support the disability to scale large text.
- [ ] Support the disability to read out the text using VoiceOver controls.

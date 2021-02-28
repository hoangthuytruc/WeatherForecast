# WeatherForecast
WeatherForecast is an application to retrieve weather information within 5-7 days.

## Screenshot
![screenshot](/screenshots/screenshot.png)

## Overview
### The structure of project
```
| WeatherForecast/
|--- Configuration/
|--- ApiSerice/
|--- LocalDatabaseService/
|--- Decorator/
|    |--- TextSizeEditor/
|--- Model/
|    |--- QueryWeather/
|    |    |--- Weather/
|    |    |    |--- City/
|    |    |    |--- WeatherItem/
|    |    |--- QueryWeatherRequest
|    |    |--- QueryWeatherResponse
|--- Controllers/
|    |--- Weather
|    |    |--- ViewModel
|    |    |--- View
|--- Utils/
| WeatherForecastTests
| WeatherForecastUITests
```

### Architectural pattern: MVVM

- **Model:** contains the structures of application data. 
- **View:** contains the visual components of interfaces. They usually handles the logics of view such as clicked button, a view presentation and so on.
- **ViewModel:** handle all logics relating to bussiness logic. 

### Design patterns: 
1. Decorator: handle scaling text for the disability.
2. Singleton: handle calling APIs, insert/get the weather information from the cache.

### Libraries: 
1. SwiftLint: to check automatically the coding convention.

### Cache
The cache is only using a `Dictionary` to store the weather information for simplicity. 

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
- [x] UnitTests
- [ ] UITests

## Configuration
The `OpenWeatherMaps API` requires `APPID` to access its APIs. In case of the default `APPID` invalid, you can replace it with yours ([sign up and get a new one for free](https://openweathermap.org/api)), simply use:
```
  Configuration.appID = 'your APPID'
```

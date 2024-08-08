# Weather App
WeatherForecast is an application to retrieve the weather information of a specific city. The main features include:
- Retrive the weather information of a specific city.
- Add the favorite cities.

## Screenshots
<img src="/screenshots/screenshots-1.png" width=30% height=30%> <img src="/screenshots/screenshots-2.png" width=30% height=30%> <img src="/screenshots/screenshots-3.png" width=30% height=30%>

## Overview
### The structure of project
```
|-- WeatherForecast/
|-- Configuration/
|-- DependencyContainer/
|-- ApiService/
|-- Model/
|   |-- QueryWeather/
|   |-- LocalStorage/
|-- Controllers/
|   |-- Base/
|   |-- Weather/
|   |   |-- SearchResults/
|   |-- WeatherDetail/
|-- LocalStorage/
|   |-- RealmDatabaseService
|   |-- RealmMigration
|-- Utils/
| WeatherForecastTests
| WeatherForecastUITests
```

### Architectural pattern: MVVM

- **Model:** contains the structures of application data. 
- **View:** contains the visual components of interfaces. They usually handles the logics of view such as clicked button, a view presentation and so on.
- **ViewModel:** handle all business logics. 

### Design patterns: 
1. Dependency Injection (DI): to handle class constructor
2. Singleton: to manage DI's initialization.

### Libraries: 
1. SwiftLint: to check automatically the coding convention.
2. RealmSwift: to cache favorited cities.

## Installation
1. Download **[the ZIP](https://github.com/hoangthuytruc/WeatherForecast/releases/tag/v2.0)** for the lastest release.
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
- [x] Display the weather information for a selected city, fetched from `OpenWeatherMaps API`.
- [x] Allow uses to save their favorite citites using local database.
- [x] Create a main screen with a search bar and a list of saved favorite cities.
- [x] Create a detailed screen to display the weather information foe the selected city.
- [x] Use URLSession for network module.
- [x] Use Codable for parsing JSON.
- [x] Use Realm database and implement CRUD operations.
- [x] UnitTests
- [ ] UITests

## Configuration
The `OpenWeatherMaps API` requires `APPID` to access its APIs. In case of the default `APPID` invalid, you can replace it with yours ([sign up and get a new one for free](https://openweathermap.org/api)), simply use:
```
  Configuration.appID = 'your APPID'
```

# MarvelUniverse

## Demo

<img src="https://github.com/Joule87/Media/blob/master/MarvelUniverse/MarvelUniverseDemo.gif" width="250" height="580" />

## Technologies used
The app is written in Swift 5, with Xcode 12.2, UIKit as the ui framework, unit testing is done with the native tools provided by XCode

## How to run
This app uses Marvel API. So in order to use their services enter ( https://developer.marvel.com/docs ) create an account and get
the public and private key that they will provide to you and place these keys in MarvelKeychain.json file located in MarvelUniverse > Resources > MarvelKeychain.json

<img src="https://github.com/Joule87/Media/blob/master/MarvelUniverse/MarvelUniverseKeys.png" width="900" height="330" />

#### MarvelAPI Keys Location

<img src="https://github.com/Joule87/Media/blob/master/MarvelUniverse/APIMarvelKeys.png" width="700" height="600" />

Open MarvelUniverse.xcodeproj select target MarvelUniverse and select device/simulator, then run.
In order to run tests, on the left side open test navigator panel and run all the tests, on the reports tab the coverage can be seen.

Note: on Resources/Info.plist you can change SERVER_URL

## Chosen architecture
MVP: Model, View and Presenter

## Project structure 
* MarvelUniverse: contains the main app code
    * util: contains small helper classes, constants and extensions.
    * resources: contains the apps resources (images, strings)
    * network: contains the networking layer code
    * launch: App init managers
    * character
        * feature
            * Model: contains the app model objects
            * View: contains custom UIViews, storyboards, table cells, view controllers and navigation
            * Presenter: contains the presentation logic to handle user interactions, and tells the View layer what to present.
                * Repository: contains any logic regarding to local persistency or network service calls
* MarvelUniverseTests: contains the unit tests

Note: Project was structured based on screaming architecture approach.

## Error handling from dev perspective
Requests: when a request fails it might be for many reasons, NetworkError gather some general cases and provide a custom description for the user, NetworkManager will provide the necessary information using logs. Also no internet reachability is implemented, if the user doesn't have a connection, it will just show the generic network failure.

## Errors from user perspective
Requests: if character list request failed a placeholder will be shown with an error message and a retry button. When requesting a character, if an error occurs, an UIAlertController will appear showing a related error.

## Unit tests
The unit tests are mainly focused on the logic, and test everything from the Presenter up to the Network layer.

<img src="https://github.com/Joule87/Media/blob/master/MarvelUniverse/MarvelUniverseCoverage.png" width="1980" height="500" />

#### Localization
Localization was done using the Localization.strings method, not using the localized storyboards, the app supports english and spanish.

## Why no Pods?
I tried not using external libraries, not because I'm against using external libraries in particular, but I think it's best for showing my knowledge of the platform.


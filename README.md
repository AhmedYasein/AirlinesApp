# Airlines App

The Airlines App is a mobile application designed to display a list of airlines, allow users to mark airlines as favorites, view detailed information about each airline, and make phone calls or visit websites related to the airlines.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [UI Components](#ui-components)
- [Data Handling](#data-handling)
- [User Interaction](#user-interaction)
- [Error Handling](#error-handling)
- [Extensibility](#extensibility)
- [Code Reusability](#code-reusability)
- [Getting Started](#getting-started)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## Overview

The Airlines App is designed to provide users with comprehensive information about various airlines. It fetches data from a remote API and stores it locally using Realm for offline access and better performance.

## Features

- Display a list of airlines
- Mark airlines as favorites
- View detailed information about each airline
- Make phone calls or visit websites related to the airlines
- Integration with CallKit for managing phone calls

## Architecture

### MVP (Model-View-Presenter) Pattern

- **Model**: The `Airline` class represents the data model for an airline. It manages the airline's data and state, including its properties and how it is encoded/decoded for persistence and network requests.
- **View**: `AirlinesVC` and `AirlineDetailVC` handle the presentation of data and user interactions.
- **Presenter**: `AirlinesPresenter` and `AirlineDetailPresenter` manage the business logic, interact with the model, and update the view.

## UI Components

- **TableView**: Utilized for listing airlines, with custom cells (`AirlineCell`) to display airline information.
- **UISegmentedControl**: Used for filtering between "All Airlines" and "Favorites."
- **Activity Indicator**: Implemented for loading states during data fetch operations.

## Data Handling

- **Remote Data Fetching**: Airlines data is fetched from a remote API if the local database is empty.
- **Local Data Management**: Airlines data is stored in Realm. This helps in offline access and faster performance.

## User Interaction

- **Favorite Management**: Users can mark airlines as favorites. The favorite status is managed locally in Realm and updated dynamically.
- **CallKit Integration**: `CallManager` handles phone calls using CallKit to manage incoming calls and interactions.
- **Web Interaction**: Allows users to open airline websites directly from the app.

## Error Handling

- **Error Reporting**: Errors during data fetching are displayed in the console. The UI is updated based on the success or failure of data fetch operations.

## Extensibility

- **Notification Handling**: Used to update the airline data across different views (`Notification.Name.airlineDidUpdate`).

## Code Reusability

- **UIImageView Extension**: `loadImage` method uses SDWebImage for image loading and caching.
- **UIView Extension**: Provides methods to show and hide loading indicators.

## Getting Started

### Prerequisites

- Xcode 12.0 or later
- iOS 13.0 or later

### Installation

1. Clone the repository
    ```sh
    git clone https://github.com/AhmedYasein/AirlinesApp.git
    ```
2. Open the project in Xcode
3. Install dependencies using CocoaPods
    ```sh
    pod install
    ```
4. Open the `.xcworkspace` file in Xcode
5. Build and run the project on a simulator or physical device

## Dependencies

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Realm](https://github.com/realm/realm-cocoa)
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the project
2. Create your feature branch
    ```sh
    git checkout -b feature/AmazingFeature
    ```
3. Commit your changes
    ```sh
    git commit -m 'Add some AmazingFeature'
    ```
4. Push to the branch
    ```sh
    git push origin feature/AmazingFeature
    ```
5. Open a pull request

For detailed documentation, please see [Documentation.pdf](Airlines%20documentation.pdf).


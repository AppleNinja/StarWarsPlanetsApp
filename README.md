# StarWarsPlanetsApp
An iOS app that displays a list of planets from the Star Wars universe.

## Features
- **Planet List**: Displays a list of planet names from the first page of the Star Wars API.
- **Planet Details**: Tapping on a planet shows detailed information about it.
- **Offline Support**: Planets are persisted locally for offline viewing using Core Data.
- **Universal App**: Compatible with both iPhone and iPad devices.
- **Unit Tested**: The app includes unit tests to ensure reliability.
- **SwiftUI & Combine**: Utilizes modern SwiftUI for the UI and Combine for asynchronous operations.
- **No Third-Party Libraries**: Built entirely using standard Apple iOS frameworks.

## Getting Started
1. **Clone the Repository**:

    ```bash
    git clone https://github.com/AppleNinja/StarWarsPlanetsApp.git
    ```

2. **Open the Project**:
   - Navigate to the project directory.
   - Open `StarWarsPlanetsApp.xcodeproj` in Xcode.

3. **Build and Run**:
   - Select the desired simulator or your device.
   - Press `Command + R` or go to **Product > Run** to build and run the app.

## Architectural Pattern
Clean Architecture with MVVM (Model-View-ViewModel) pattern:

- **Presentation Layer**: SwiftUI Views and ViewModels.
- **Domain Layer**: Use cases and business logic.
- **Data Layer**: Repositories, data sources, and mappers.
- **Dependency Injection**: Manual dependency injection for better testability and modularity.

## Application Flow

- **Planet List Screen**:
  - Fetches and displays a list of planet names from the Star Wars API.
  - Each planet is listed in a List view.

- **Planet Detail Screen**:
  - Tapping on a planet navigates to the detail view.
  - Displays detailed information about the selected planet, such as:
    - Rotation Period
    - Orbital Period
    - Diameter
    - Climate
    - Gravity
    - Terrain
    - Surface Water
    - Population

### Offline Viewing
- Planets are saved locally using Core Data.
- If the device is offline, the app displays the cached planets.

## Frameworks and Technologies Used
- **SwiftUI**: For building the user interface declaratively.
- **Combine**: For handling asynchronous events and data streams.
- **Codable**: For parsing JSON data from the API.
- **Core Data**: For persisting data locally to support offline viewing.
- **URLSession**: For making network requests to the Star Wars API.

## Tests
- **Unit Tests**: Tests for ViewModels, Use Cases, Repositories, and Data Sources.
- **Test Coverage**: Focused on ensuring the core functionalities work as expected.

### How to Run Tests
1. **Open the Project in Xcode**:
   - Open `StarWarsPlanetsApp.xcodeproj`.

2. **Run Tests**:
   - Press Command + U or go to Product > Test.
   - Xcode will build the app and execute the test cases.

3. **View Test Results**:
   - Test results will appear in the Test Navigator.
   - You can view code coverage by selecting Coverage in the Report Navigator.

## Recommendations for Future Improvements
- **Pagination Support**: Load more planets by implementing pagination to fetch additional pages from the API.
- **Search Functionality**: Add the ability to search for planets by name.
- **Favorites**: Allow users to mark planets as favorites and view them in a separate list.
- **Error Handling Enhancements**: Provide more detailed error messages and retry options when network requests fail.
- **Accessibility Improvements**: Enhance support for VoiceOver and Dynamic Type to improve accessibility.
- **Unit Test Expansion**: Increase test coverage, especially for edge cases and error conditions.
- **UI Enhancements**: Improve the UI with custom styling and animations.
- **Localization**: Add support for multiple languages to reach a wider audience.
- **Continuous Integration**: Set up CI/CD pipelines to automate builds and tests.

## Tools Used
- **macOS**: 14.6.1 Sonoma
- **Xcode**: 15.4
- **iOS Deployment Target**: 15.0
- **Devices Tested**:
  - iPhone 16 Pro Max Simulator
  - iPad Pro (11-inch) Simulator

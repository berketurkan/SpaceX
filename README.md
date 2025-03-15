# SpaceX Fan

**SpaceX Fan** is an iOS application built with SwiftUI that brings the excitement of SpaceX right to your fingertips. Developed as part of a summer internship, this app provides SpaceX enthusiasts with comprehensive details on rockets, upcoming launches, and crew members, while offering personalized features such as favoriting rockets and secure authentication.

## Features

- **Multi-Tab Navigation:**
  - **SpaceX Rockets:**  
    - Displays a list of all SpaceX rockets.
    - Each rocket card shows a thumbnail (if available) and includes a favorite button.
    - Tapping a rocket opens its detailed page.
  - **Favorite Rockets:**  
    - Lists rockets marked as favorite by the user.
    - Requires secure authentication (Face ID/Touch ID or Firebase Email/Password) to access.
    - Provides an option to unfavorite rockets.
  - **Upcoming Launches:**  
    - Displays a list of upcoming SpaceX launches.
    - Tapping an item shows detailed launch information.
  - **Bonus - SpaceX Crew:**  
    - Lists SpaceX crew members with a search bar for filtering by name or surname.
    - Tapping on a crew member’s detail page will navigate to the associated rocket detail page.

- **Detail Pages:**
  - **Rocket Detail Page:**  
    - Shows detailed information about the selected rocket.
    - Includes a slidable gallery for rocket images.
    - Features a clickable favorite button with persisted state.
  - **Upcoming Launch Detail Page:**  
    - Provides comprehensive details about the upcoming launch.

- **State Persistence:**
  - The app preserves its state when moved to the background, ensuring that users return to the same screen and context.

- **Cloud Integration:**
  - Implements a cloud service (via Firebase or other providers) for storing dummy user data and favorite rockets.
  - Hosts Membership Agreement and Privacy Policy documents on Firebase Storage.
  - Utilizes Firebase Remote Config to remotely enable or disable Touch ID/Face ID authentication.

## Project Structure

- **Views:**  
  Contains all SwiftUI views for tabs, lists, and detail pages.

- **Models:**  
  Data models representing rockets, launches, and crew members.

- **ViewModels:**  
  Handles business logic and state management using `ObservableObject` and `EnvironmentObject`.

- **Services:**  
  API service integrations including communication with the SpaceX API and Firebase.

- **Resources:**  
  Assets, localizations, and other static resources.

- **Utilities:**  
  Helper functions, extensions, and configuration files.

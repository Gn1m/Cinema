# Cinema App
Cinema is a SwiftUI-based application that allows users to browse and book movie tickets. 
## Features

- **Movies Browsing**: Scroll through a horizontally displayed list of movies and view details for each one.
- **Seat Selection**: Select available seats for a given time slot and complete the ticket purchase process.
- **Orders and Account**: Review past orders and manage account settings.

## Project Structure

- **Views**: Contains the main views of the application.
  - `ContentView`: Main view where users can browse movies and navigate to other sections.
  - `SeatSelectionView`: Allows users to select seats and reserve tickets.
- **Components**: Reusable UI components for consistent and modular design.
  - `MovieCardView`: Displays an individual movie in a scrollable list.
  - `SeatView`: Represents individual seats in the grid layout.
- **ViewModels**: Holds the view models for managing the logic and data of the main views.
- **Models**: Data models representing the entities like `Movie`, `Seat`, and `TimeSlot`.

## Requirements

- Swift 5.3 or later
- iOS 14.0 or later
- Xcode 12.0 or later

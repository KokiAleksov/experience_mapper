# Experience Mapper

A Flutter mobile app that allows users to mark locations where they've had experiences, add notes, and save the current date. The app features Google Maps integration, real location services, and a clean, mobile-friendly UI with smooth animations.

## Features

- **Google Maps Integration**: Real Google Maps with current location display
- **Experience Mapping**: Add experiences at specific locations with notes and timestamps
- **Location Services**: Get current location with permission handling
- **Interactive Map Interface**: Tap-to-add markers on Google Maps
- **Experience Management**: View, edit, and delete existing experiences
- **In-Memory Storage**: Experiences are stored temporarily in memory (data lost when app closes)
- **Provider State Management**: Clean state management using the Provider pattern
- **Cupertino Modal**: iOS-style modal for adding/viewing experiences
- **Mobile-Friendly UI**: Responsive design with smooth animations
- **Experience List**: View all experiences in a scrollable list
- **Location Permissions**: Proper handling of location permissions

## Getting Started

### Prerequisites

- Flutter SDK (3.6.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android emulator or physical device
- Google Maps API Key (for map functionality)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd experience_mapper
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Google Maps API Key**
   - Get a Google Maps API key from [Google Cloud Console](https://console.cloud.google.com/)
   - For Android: Add the API key to `android/app/src/main/AndroidManifest.xml`
   - For iOS: Add the API key to `ios/Runner/AppDelegate.swift`

4. **Run the app**
   ```bash
   flutter run
   ```

## How to Use

1. **Grant Location Permission**: The app will request location permission on first launch
2. **View Map**: The map shows your current location and any existing experiences
3. **Add Experience**: Tap anywhere on the map to add a new experience at that location
4. **View Experience**: Tap on any experience marker to view details
5. **Edit Experience**: Use the edit button in the experience modal to modify notes
6. **Delete Experience**: Use the delete button in the experience modal to remove an experience
7. **Clear All**: Use the clear button in the app bar to remove all experiences

## Project Structure

```
lib/
├── main.dart                    # App entry point with Provider setup
├── models/
│   └── experience.dart         # Experience data model
├── providers/
│   └── experience_provider.dart # State management with Provider
├── screens/
│   ├── welcome_screen.dart      # Welcome/onboarding screen
│   └── home_screen.dart        # Main screen with Google Maps
└── widgets/
    └── experience_modal.dart   # Cupertino modal for experiences
```

## Key Components

### Experience Model (`lib/models/experience.dart`)
- Represents an experience with latitude, longitude, notes, and timestamps
- Includes JSON serialization methods
- Provides formatted date display methods

### Experience Provider (`lib/providers/experience_provider.dart`)
- Manages app state using Provider pattern
- Handles CRUD operations for experiences
- Uses in-memory storage (data lost when app closes)
- Includes distance calculation utilities

### Home Screen (`lib/screens/home_screen.dart`)
- Google Maps integration with current location
- Tap-to-add marker functionality
- Experience list with scrollable view
- Location permission handling
- Clean, modern UI design

### Welcome Screen (`lib/screens/welcome_screen.dart`)
- Onboarding screen for new users
- Introduction to app features

### Experience Modal (`lib/widgets/experience_modal.dart`)
- Cupertino-style modal for adding/viewing experiences
- Edit and delete functionality
- Form validation and error handling
- Smooth animations

## UI Features

- **Google Maps Interface**: Real Google Maps with current location display
- **Experience Markers**: Visual markers on map for each experience
- **Experience List**: Scrollable list showing all experiences
- **Cupertino Modal**: iOS-style modal for experience management
- **Smooth Animations**: Mobile-friendly transitions and animations
- **Responsive Design**: Works on different screen sizes
- **Modern Material Design**: Clean, contemporary UI
- **Location Services**: Current location detection and display

## Future Enhancements

The app is designed to be easily extensible. Here are some potential enhancements:

### Easy to Add:
- **Persistent Storage**: Replace in-memory storage with SharedPreferences or SQLite
- **Photo Attachments**: Add image support for experiences
- **Categories/Tags**: Add experience categorization
- **Search/Filter**: Add search and filtering capabilities
- **Offline Maps**: Add offline map support
- **Map Styles**: Add different map styles (satellite, terrain)

### Advanced Features:
- **Export/Import**: Export experiences to file or cloud
- **Offline Support**: Full offline functionality
- **Sharing**: Share experiences with others
- **Timeline View**: Chronological view of experiences
- **Statistics**: Experience analytics and insights

## Technical Details

### Dependencies
- `provider: ^6.1.2` - State management
- `google_maps_flutter: ^2.6.1` - Google Maps integration
- `geolocator: ^12.0.0` - Location services
- `cupertino_icons: ^1.0.8` - iOS-style icons

### Architecture
- **Provider Pattern**: Clean state management
- **Model-View-Provider**: Separation of concerns
- **Modular Design**: Easy to extend and maintain

### Storage
- Currently uses in-memory storage (data lost when app closes)
- Easily extensible to persistent storage
- JSON serialization ready

## Troubleshooting

### Common Issues:

1. **App won't start**: Ensure Flutter SDK is properly installed
2. **Maps not loading**: Ensure your Google Maps API key is correctly configured
3. **Location not working**: Check that location permissions are granted in device settings
4. **Build errors**: Run `flutter clean` and `flutter pub get`
5. **UI issues**: Check that all dependencies are properly installed

### Debug Tips:
- Use `flutter doctor` to check your Flutter installation
- Check the console for error messages
- Use Flutter DevTools for debugging


## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For support or questions:
1. Check the Flutter documentation
2. Review the console logs for specific error messages
3. Open an issue in the repository

---

**Experience Mapper** - Map your memories, one experience at a time!
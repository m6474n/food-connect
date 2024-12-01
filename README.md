![Logo](https://raw.githubusercontent.com/m6474n/food-connect/refs/heads/main/asset/banner.jpg)


# Food Connect

A revolutionary app designed to create a meaningful connection between restaurants, hotels, and compassionate individuals, all working together to combat food wastage and alleviate hunger in our communities.


## Screenshots

![App Screenshot](https://raw.githubusercontent.com/m6474n/food-connect/refs/heads/main/asset/screenshots.jpg)


## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Overview
**Food Connect** is a mobile app aimed at connecting restaurants, NGOs, and individuals to reduce food wastage and address hunger. The app allows restaurants to list excess food donations, and NGOs can claim them to distribute to people in need.

### User Roles:
- **Admin**:  
  - Manage all users (Add, remove, update).  
  - Manage donations and their status.  
- **Restaurant**:  
  - List new donations.  
  - Manage their profile.  
  - Chat with NGOs.  
  - Update their location.  
- **NGO**:  
  - Manage their profile.  
  - View and claim available donations from restaurants.  
  - Chat with restaurants.  
  - Track the real-time location of donations for pickup.  

## Features
- **Real-Time Location Tracking**: View restaurants and donations on an interactive map.
- **Donation Management**: Restaurants can list donations, while NGOs can claim them.
- **Chat System**: Restaurants and NGOs can communicate directly for donation coordination.
- **Profile Management**: Users can update their profile details (name, location, contact info).
- **Push Notifications**: Real-time notifications for new donations, updates, and messages.

## Tech Stack
- **Frontend**: Flutter
- **Backend**: Firebase (Firestore, Firebase Authentication, Firebase Cloud Messaging)
- **Real-Time Location**: Google Maps API
- **Push Notifications**: Firebase Cloud Messaging (FCM)
- **State Management**: Provider (or Riverpod)
- **Chat System**: Firebase Firestore or third-party libraries

## Installation

### Prerequisites
- **Flutter**: Ensure you have Flutter installed. If not, follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).
- **Firebase Project**: Create a Firebase project and configure Firebase Authentication, Firestore, and Firebase Cloud Messaging.
- **Google Maps API**: Enable Google Maps for your project and configure the API key.

### Steps
1. **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/food-connect.git
    cd food-connect
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Set up Firebase**:
    - Follow the instructions for [Firebase setup in Flutter](https://firebase.flutter.dev/docs/overview).
    - Ensure you have added the `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) to the appropriate directories.
    - Configure Firebase services (Authentication, Firestore, FCM, etc.) in the Firebase console.

4. **Set up Google Maps**:
    - Create a project in the [Google Cloud Console](https://console.cloud.google.com/).
    - Enable Google Maps SDK for Android and iOS.
    - Add the Google Maps API key to the Flutter project:
      - For Android: `android/app/src/main/AndroidManifest.xml`
      - For iOS: `ios/Runner/Info.plist`

5. **Run the app**:
    ```bash
    flutter run
    ```

## Usage

Once the app is running:

### Admin:
- Login as Admin using Firebase Authentication.
- Access the admin panel to manage users and donations.

### Restaurant:
- Sign in with Firebase Authentication.
- List new donations and update restaurant details.
- Use the map to view and manage donations, and chat with NGOs.

### NGO:
- Sign in with Firebase Authentication.
- Browse available donations, track the real-time location of donations, and chat with restaurants.

## Contributing
We welcome contributions to Food Connect! If you would like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature-name`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add feature'`).
5. Push to your branch (`git push origin feature/your-feature-name`).
6. Create a pull request.

### Guidelines:
- Follow the code style and conventions used in the project.
- Write clear, concise commit messages.
- Ensure that all tests pass and that new features are covered by tests.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
If you have any questions or suggestions, feel free to reach out!

- **Email**: m.mohsin2055@gmail.com
- **GitHub**: [@m6474n](https://github.com/m6474n)


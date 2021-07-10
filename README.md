# <img src="https://github.com/tharinduprabath/CenticBids-Mobile/blob/development/assets/images/pngs/app_icon.png?raw=true" alt="drawing" width="200" height="200"/>
![GitHub](https://img.shields.io/github/license/tharinduprabath/CenticBids-Mobile) ![Lines of code](https://img.shields.io/tokei/lines/github/tharinduprabath/CenticBids-Mobile) ![GitHub top language](https://img.shields.io/github/languages/top/tharinduprabath/CenticBids-Mobile) ![GitHub release (latest by date)](https://img.shields.io/github/v/release/tharinduprabath/CenticBids-Mobile)
# CenticBids
CenticBids is an online bidding platform which allow users to bid for online auctions.

## Platform
CenticBids consists with,
* CenticBids AuctionHouse
    * Admin portal where auction owners can add new items into the auction
* CenticBids (Web)
    * Web portal where customer can view and bid for ongoing auction items
* CenticBids (Mobile)
    * Mobile app which allows users to view and bid for ongoing auctions

## CenticBids (Mobile)

### Project Design
All the design documents are in the following drive folder. [Google Drive](https://drive.google.com/drive/folders/1HAC1Y0zE6pCFtF8drV-yIrPuR54RFrK-?usp=sharing)

### Project Plan
You can find the project plan from [here](https://trello.com/b/ftsL2YAv) - A simple trello board

### Tech Stack
1. [Flutter](https://flutter.dev/) - Develop the mobile application
2. [Firebase](https://firebase.google.com/) - Database and Authentication

### Modules
1. Authentication
    * Login
        * Email/Password sign-in
        * Reset Password
    * Registration
        * Email/Password sign-up
        * Email Verification
    * Account Management
        * Change Password
        * Sign-out
2. Auction
    * Ongoing Auctions
        * Place Bid
    * My Bids
3. Support
    * About
    * Privacy Policy

### Flutter Project
Use Flutter version 2.2 (Stable channel) with sound null safety

* **Project Architecture** - [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) (Data, Domain, Presentation layer separation)

* **State Management** - [Stacked](https://pub.dev/packages/stacked), [Provider](https://pub.dev/packages/provider)
* **Dependency Injection** - [GetIt](https://pub.dev/packages/get_it)
* **Exception Handling** - Use unions from [Dartz](https://pub.dev/packages/dartz)
* **Equality Comparison** - [Equatable](https://pub.dev/packages/equatable)
* **Unit Testing** - [Mockito](https://pub.dev/packages/mockito) 

### Folder Structure

#### Flutter module
```
lib/
|- app/
    |- core/
        |- design_system/
        |- widgets/
        |- app_colors.dart
        |- app_constants.dart
        |- app_enums.dart
        |- app_firebase_helper.dart
        |- app_images.dart
        |- app_strings.dart
    |- features/
        |- auction/
        |- auth/
        |- support/
    |- services/
    |- utils/
    |- centic_bids_app.dart
|- app_configurations/
    |- app_di_container.dart
    |- app_theme_data.dart
|- main.dart
```

#### Features
```
features/
|- auction/
    |- data/
    |- domain/
    |- presentation/
|- auth/
    |- data/
    |- domain/
    |- presentation/
|- support/
    |- data/
    |- domain/
    |- presentation/
```

#### Services
```
services/
|- app_info/
    |- app_info_service.dart
    |- app_info_service_impl.dart
|- dialog_service/
    |- dialog_service.dart
|- navigation_service/
    |- navigation_service.dart
    |- routes.dart
    |- routes_handler.dart
|- network_service/
    |- network_service.dart
    |- network_service_impl.dart
```


## Getting Started

### To build and run this project:

**Step 1:**

Get Flutter [here](https://flutter.dev) if you don't already have it

**Step 2:**

Download or clone this repo by using the link below:

```
https://github.com/tharinduprabath/CenticBids-Mobile.git
```

**Step 3:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 4:**

To build and run the project execute the following command:

```
flutter run
```

### To test this project:

This project uses `mockito` for generate mock classes. Execute the following command to generate files:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

### Note
Project is configured only for android. Not configured or tested for iOS. To run the android application minimum requirement is Android 5.1 (API level 22).

## License
[MIT](https://github.com/tharinduprabath/CenticBids-Mobile/blob/master/LICENSE.txt)
# Wallet App

**Description**: A Flutter project that manages financial transactions such as transfers, withdrawals, and viewing transaction history. It integrates with SharedPreferences to store user data, balance, transaction history, and more.

## Features

- **User Management**: Store and retrieve user data using SharedPreferences.
- **Balance Management**: View the current balance and perform transactions.
- **Transaction History**: View past transactions such as transfers and withdrawals.
- **Transfer Money**: Transfer money between users, deduct from balance, and save transaction history.
- **Withdraw Money**: Withdraw funds with balance checks and store the transaction.
- **Phone Credit**: Manage phone credit balance (for future features or mobile-related operations).
- **Local Storage**: Use SharedPreferences for local data storage.

## Technologies Used

- **Flutter**: Framework for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart**: Programming language used to develop the application.
- **SharedPreferences**: For local storage of user data, transaction history, and balance.
- **Font Awesome**: Icon library for adding icons.
- **Animated Text Kit**: For creating animated text effects.

## Screenshots

(Optional: Add screenshots of your app here for preview.)

## Getting Started

### Prerequisites

Make sure you have the following installed:

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK (usually installed with Flutter)
- A code editor (VSCode, Android Studio, etc.)
- An emulator or physical device to run the app

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/your_project_name.git
    ```

2. Navigate to the project directory:

    ```bash
    cd your_project_name
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

### Running on an Emulator/Device

To run the app on an emulator or a physical device:

- Use the command `flutter devices` to check for connected devices.
- Run the app with `flutter run` or use your IDE's run feature.

## Usage

Once the app is running, you can interact with the following:

1. **Dashboard Page**: View your balance, phone credit, and transaction history.
2. **Transfer Page**: Enter the recipient's phone number and the amount to transfer.
3. **Withdraw Page**: Enter the withdrawal amount and check the balance.
4. **Transactions Page**: View all transaction records such as transfers and withdrawals.

## File Structure


# Wallet App

**Description**:  
The Wallet App is a Flutter-based mobile application designed to facilitate financial transactions. It allows users to manage their finances by performing activities such as money transfers, withdrawals, and viewing transaction history. The app integrates with **SharedPreferences** to securely store user data, transaction history, and account balances for a seamless user experience.

## Key Features

- **User Management**: Securely store and retrieve user data using SharedPreferences.
- **Balance Management**: View and manage your current balance, with the ability to make transactions.
- **Transaction History**: Keep track of all past transactions, including transfers and withdrawals.
- **Money Transfer**: Transfer funds to other users, deducting the amount from the available balance and saving transaction records.
- **Withdrawal**: Withdraw funds from the wallet with automatic balance checks to ensure sufficient funds.
- **Phone Credit**: A feature to manage phone credit balance (planned for future enhancements or mobile-related operations).
- **Local Storage**: All user data, balances, and transaction history are stored locally using SharedPreferences for quick access.

## Technologies Used

- **Flutter**: A powerful UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart**: The programming language used to develop this application.
- **SharedPreferences**: A lightweight storage solution for persisting user data, transaction history, and balance.
- **Font Awesome**: A popular icon library used for displaying intuitive icons in the app.
- **Animated Text Kit**: A library used for creating engaging and animated text effects, enhancing the user interface.

## Screenshots

(Optional: Add screenshots of your app to provide a visual preview of its interface.)

## Getting Started

To get started with the Wallet App, ensure that you have the necessary software installed on your machine. Follow the instructions below for installation and setup.

### Prerequisites

Before you begin, make sure the following tools are installed:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Typically comes bundled with Flutter.
- **Code Editor**: A code editor like **VSCode** or **Android Studio**.
- **Emulator or Physical Device**: For testing and running the app.

### Installation Steps

1. **Clone the repository**:

    ```bash
    git clone https://github.com/yourusername/your_project_name.git
    ```

2. **Navigate to the project directory**:

    ```bash
    cd your_project_name
    ```

3. **Install dependencies**:

    Run the following command to fetch all the required dependencies:

    ```bash
    flutter pub get
    ```

4. **Run the app**:

    Launch the application using the following command:

    ```bash
    flutter run
    ```

### Running the App on an Emulator/Device

To run the app on an emulator or a physical device:

- Use `flutter devices` to list the available devices.
- Run the app on your chosen device with `flutter run`, or use your IDE's run/debug functionality.

## App Usage

Once the app is up and running, you will have access to the following features:

1. **Dashboard Page**:  
   This page displays your available balance, phone credit (if applicable), and a summary of recent transactions.
   
2. **Transfer Page**:  
   Allows you to initiate money transfers to other users by entering their phone number and the amount to transfer. The app will deduct the transferred amount from your balance and update the transaction history.

3. **Withdraw Page**:  
   Enables users to withdraw funds from their wallet. The app checks the available balance and processes the withdrawal accordingly.

4. **Transactions Page**:  
   View a detailed list of all past transactions, including transfers, withdrawals, and other wallet-related activities.

## File Structure

The project follows the directory structure outlined below for better organization and maintainability:


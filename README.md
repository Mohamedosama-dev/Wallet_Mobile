![Screenshot 2024-12-14 at 21-40-13 wallet cartoon image - بحث Google](https://github.com/user-attachments/assets/2a8f2897-1a18-4481-8e24-080204cd36b0)
# Wallet App

**Description**:  
The Wallet App is a Flutter-based mobile application designed to facilitate financial transactions. It allows users to manage their finances by performing activities such as money transfers, withdrawals, and viewing transaction history. The app integrates with **SharedPreferences** to securely store user data, transaction history, and account balances for a seamless user experience.

## Key Features

- **User Management**: Securely store and retrieve user data using SharedPreferences.
- **Balance Management**: View and manage your current balance, with the ability to make transactions.
- **Transaction History**: Keep track of all past transactions, including transfers and withdrawals.
- **Money Transfer**: Transfer funds to other users, deducting the amount from the available balance and saving transaction records.
- **Withdrawal**: Withdraw funds from the wallet with automatic balance checks to ensure sufficient funds.
- **Deposit**: Deposit funds from the wallet with automatic balance checks to ensure sufficient funds.
- **Phone Credit**: A feature to manage phone credit balance (planned for future enhancements or mobile-related operations).
- **Local Storage**: All user data, balances, and transaction history are stored locally using SharedPreferences for quick access.

## Technologies Used

- **Flutter**: A powerful UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart**: The programming language used to develop this application.
- **SharedPreferences**: A lightweight storage solution for persisting user data, transaction history, and balance.
- **Font Awesome**: A popular icon library used for displaying intuitive icons in the app.
- **Animated Text Kit**: A library used for creating engaging and animated text effects, enhancing the user interface.
- ![gifmaker_me](https://github.com/user-attachments/assets/dafb8d7e-dfba-4ea0-bfbc-bf6f457ce140)



## Getting Started

To get started with the Wallet App, ensure that you have the necessary software installed on your machine. Follow the instructions below for installation and setup.

### Prerequisites

Before you begin, make sure the following tools are installed:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Typically comes bundled with Flutter.
- **Code Editor**: A code editor like **VSCode** or **Android Studio**.
- **Emulator or Physical Device**: For running the app.

### Installation Steps

1. **Clone the repository**:

    ```bash
    git clone https://github.com/Mohamedosama-dev/Wallet_Mobile.git
    ```

2. **Navigate to the project directory**:

    ```bash
    cd wallet
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

2. **Deposit Page**:  
   Allows you to deposit funds into your wallet. You can add money to your balance, which will be reflected immediately in your available funds.

3. **Withdraw Page**:  
   Enables users to withdraw funds from their wallet. The app checks the available balance to ensure sufficient funds before processing the withdrawal.

4. **Transfer Page**:  
   Allows you to initiate money transfers to other users by entering their phone number and the amount to transfer. The app will deduct the transferred amount from your balance and update the transaction history.

5. **Transfer to Charity Page**:  
   A special page dedicated to transferring funds to a charity. You can select the amount to donate, and the app will process the transaction, updating the history accordingly.

6. **Recharge Phone Credit Page**:  
   Allows you to recharge your phone or another user’s phone credit. You can enter the phone number and the recharge amount, and the app will handle the transaction.

7. **Pay Bill Page**:  
   This page allows you to pay various bills directly from your wallet. You can select the bill category (e.g., electricity, water) and input the amount to pay. The app will deduct the bill amount from your wallet and process the transaction.

8. **Transactions Page**:  
   View a detailed list of all past transactions, including deposits, withdrawals, transfers (to users or charity), phone credit recharges, and bill payments.

## File Structure

The project follows the directory structure outlined below for better organization and maintainability:


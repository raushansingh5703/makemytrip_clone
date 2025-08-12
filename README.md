MakeMyTrip Style Travel App (UI Clone with Auth Flow)
Project: MakeMyTrip Style Travel App — UI clone with authentication flows (Login, Register, Forgot Password) and a Dashboard.

This repository contains a Flutter UI-clone of MakeMyTrip focused on UI/UX, navigation, and basic (dummy) authentication logic. It's intended as an intermediate-level app assignment that demonstrates form validation, state handling, routing, and reusable components.

🔧 Features
Authentication flows

Login screen (email + password, show/hide password)

Register screen (email, password, confirm password, validation)

Forgot Password flow (verify email → update password)

Single-screen login/signup option (optional)

“Remember me” checkbox (UI only)

Dummy auth stored locally (SharedPreferences)

Dashboard

Top AppBar with location selector & profile icon

Category tabs/cards for Flights, Hotels, Trains, Cabs, Holidays

Promo banners (carousel slider)

Popular destination cards (dummy data)

Bottom navigation bar (Home, Bookings, Offers, Profile)

Reusable widgets

CustomTextField with validation & visibility toggle

Promo carousel widget

Destination card widget

Responsive UI

Works across device sizes with adaptive layouts

Code Quality

Separation of UI and logic, reusable components, comments

🗂 Project Structure

lib/
├── main.dart
├── routes/
│   └── app_routes.dart
├── screens/
│   ├── auth/
│   │   ├── login_signup_screen.dart
│   │   └── forgot_password_screen.dart
│   └── dashboard/
│       ├── dashboard_screen.dart
│       └── widgets/
│           ├── category_tabs.dart
│           ├── promo_carousel.dart
│           └── destination_card.dart
├── models/
│   └── destination_model.dart
├── widgets/
│   └── custom_text_field.dart
└── utils/
└── validators.dart
📦 Dependencies
Add these dependencies to pubspec.yaml (example list):


dependencies:
flutter:
sdk: flutter
carousel_slider: ^4.0.0
ticket_widget: ^1.0.0
shared_preferences: ^2.0.0
fluttertoast: ^8.0.0   # optional, for toast notifications
Use flutter pub get after updating pubspec.yaml.

🚀 Getting Started (Run Locally)
Clone the repo:

git clone https://github.com/<your-username>/make_my_trip_ui_clone.git
cd make_my_trip_ui_clone
Install dependencies:


flutter pub get
Run on device/emulator:


flutter run
🧠 Implementation Notes
Authentication (Dummy)
Users are stored locally using SharedPreferences (JSON map of email → password).

AuthService handles:

loginOrSignup(email, password) — registers if email not present, otherwise tries login.

resetPassword(email, newPassword) — only if email exists.

isEmailRegistered(email) — check if email exists.

logout() & isLoggedIn() management via a flag plus current user email.

Security note: This is only for demo/assignment. Never store plaintext passwords in production. Use secure backend + hashed passwords or services like Firebase Auth.

UI / UX
LoginScreen and ForgotPasswordScreen use a background image + gradient overlay + carousel + TicketWidget to match the MakeMyTrip look.

CustomTextField wraps TextFormField with common styling, validation hook, and optional show/hide toggle.

All forms use Form + GlobalKey<FormState> and TextFormField validators from utils/validators.dart.

✅ Acceptance Criteria (Checklist)
Clean, readable, and commented code

Separation of UI and logic (services & widgets)

Responsive layout (tests manually on multiple device sizes)

Reusable widgets (CustomTextField, promo_carousel, destination_card)

Form validation implemented using Form and TextFormField

Navigation implemented via Navigator (or GoRouter if preferred)

Dummy data loaded from local models

📸 Screenshots / Recording
Add screenshots or a short screen recording to the repository under /assets/screenshots/ and list them here:

screenshots/login.png

screenshots/forgot_password.png

screenshots/dashboard.png

(Replace with your actual images.)

🧩 How to Test
Open app — you should land on Login screen.

Try to register a new user by entering a new email and password (confirm if separate register screen exists).

Try logging in with existing credentials — should navigate to Dashboard.

Use Forgot Password: verify email → update password → login with updated password.

Check responsiveness by resizing emulator or running on a different device.

📚 Useful Files Overview
lib/services/user_preference.dart — authentication logic (SharedPreferences operations).

lib/widgets/custom_text_field.dart — custom, reusable text field widget.

lib/utils/validators.dart — email and password validators.

lib/screens/auth/login_signup_screen.dart — login UI + form validation + auth calls.

lib/screens/auth/forgot_password_screen.dart — email verify + reset UI.

lib/screens/dashboard/dashboard_screen.dart — MakeMyTrip-like dashboard UI.

lib/models/destination_model.dart — dummy model for destination cards.

lib/routes/app_routes.dart — centralized route names (optional).
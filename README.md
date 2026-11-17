# 🌟 Random Quote Generator

A clean, modern, and minimal Flutter application that delivers daily inspiration with smooth animations, category filters, light/dark themes, and bookmarking.

![Flutter](https://img.shields.io/badge/Flutter-3.47.5-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.13.4-0175C2?logo=dart)
![License](https://img.shields.io/badge/license-MIT-green)

---

## 📱 Features

- **Random Quote on Launch**: Automatically displays an inspiring quote every time the app opens.
- **"New Quote" Button**: Generates a different quote on every click, guaranteeing no immediate repeats.
- **Clear Author Attribution**: Beautiful editorial typography pairing serif quote text with clear author attribution.
- **Category Filtering**: Explore quotes by theme (*Wisdom*, *Inspiration*, *Success*, *Life*, *Philosophy*, *Mindfulness*).
- **Clean & Minimal UI/UX**:
  - Smooth card transitions (`AnimatedSwitcher`) with fade & slide.
  - Light & Dark mode support with customized palettes.
  - Interactive micro-gestures: Swipe card to switch quote, double-tap card to like with heart pop animation.
  - Copy quote to clipboard with instant toast notification.
  - Share quotes directly through the system share sheet.
  - Saved Quotes modal bottom sheet to manage favorite quotes.

---

## 🛠️ Project Structure

```
lib/
├── data/
│   └── quote_repository.dart       # Curated quotes database & random generation logic
├── models/
│   └── quote_model.dart            # Quote entity model
├── screens/
│   └── quote_screen.dart           # Primary screen with header, filter chips, and CTA
├── theme/
│   └── app_theme.dart              # Light & Dark theme definitions
├── widgets/
│   ├── favorites_sheet.dart        # Saved quotes modal bottom sheet
│   └── quote_card.dart             # Hero quote card with gesture & action handlers
└── main.dart                       # App entry point & theme state management
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.x or higher)
- Dart SDK (3.x or higher)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/shehabshawky/random_quote_generator.git
   cd random_quote_generator
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

### Running Tests

```bash
flutter test
```

---

## 📄 License

This project is licensed under the MIT License.

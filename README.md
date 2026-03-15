# 🏎️ Street Racer

A 2D top-down car racing game built with **Flutter** and the **Flame** game engine.  
5 increasingly difficult levels, touch + keyboard controls, local high-score saving.

---

## Project Structure

```
street_racer/
├── lib/
│   ├── main.dart                        # App entry point
│   ├── game/
│   │   ├── racing_game.dart             # Main Flame game class (loop, input, state)
│   │   ├── components/
│   │   │   ├── road.dart                # Scrolling road background
│   │   │   ├── player_car.dart          # Player-controlled car
│   │   │   ├── enemy_car.dart           # Enemy traffic car
│   │   │   ├── obstacle.dart            # Road obstacle (barrel)
│   │   │   ├── coin.dart                # Collectible coin
│   │   │   └── hud.dart                 # Score, lives, progress bar
│   │   └── managers/
│   │       └── spawn_manager.dart       # Spawns enemies, obstacles, coins
│   ├── models/
│   │   └── level_config.dart            # Level difficulty definitions
│   ├── screens/
│   │   ├── main_menu_screen.dart        # Title / main menu
│   │   ├── level_select_screen.dart     # Level selection grid
│   │   ├── settings_screen.dart         # Sound toggle
│   │   └── game_screen.dart             # Game + overlay dialogs
│   ├── utils/
│   │   ├── constants.dart               # Colours, sizes, tunable values
│   │   └── storage_helper.dart          # SharedPreferences wrapper
│   └── widgets/                         # (reserved for future shared widgets)
├── assets/
│   ├── images/                          # (add sprite PNGs here later)
│   ├── audio/                           # (add MP3/OGG files here later)
│   └── README.md
├── web/
│   ├── index.html
│   └── manifest.json
├── test/
│   └── widget_test.dart
├── pubspec.yaml
├── analysis_options.yaml
└── README.md                            # ← you are here
```

---

## Prerequisites

| Tool                | Version   | How to install                                  |
|---------------------|-----------|-------------------------------------------------|
| Flutter SDK         | ≥ 3.10    | https://docs.flutter.dev/get-started/install    |
| Android Studio      | any       | https://developer.android.com/studio            |
| Chrome              | any       | (for web testing)                               |
| VS Code (optional)  | any       | https://code.visualstudio.com                   |

After installing Flutter, verify:

```bash
flutter doctor
```

Make sure at least **Flutter**, **Android toolchain**, and **Chrome** show ✓.

---

## Setup (Step by Step)

### 1. Create the Flutter project scaffold

```bash
flutter create street_racer
cd street_racer
```

### 2. Replace generated files

Delete the auto-generated `lib/` folder and `test/` folder, then copy all
files from this project into the `street_racer/` directory so the folder
structure matches the tree above.

**Or** if you received this as a zip, extract it directly.

### 3. Install dependencies

```bash
flutter pub get
```

---

## Running the Game

### Desktop (Linux / macOS / Windows)

```bash
flutter run -d linux    # or -d macos  or  -d windows
```

> On first run, Flutter may download platform tools – this is normal.

### Web (Chrome)

```bash
flutter run -d chrome
```

Use **Arrow keys** or **A / D** to steer.  Press **Esc** or **P** to pause.

### Android Emulator

1. Open **Android Studio → Device Manager** and create / start an emulator.
2. Run:

```bash
flutter run -d emulator-5554    # or just:  flutter run
```

### Physical Android Device

1. Enable **Developer Options** and **USB Debugging** on your phone.
2. Connect via USB.
3. Run:

```bash
flutter devices          # verify your phone is listed
flutter run              # deploys to connected device
```

---

## Building the APK

### Debug APK (fast, bigger file)

```bash
flutter build apk --debug
```

Output: `build/app/outputs/flutter-apk/app-debug.apk`

### Release APK (optimized, smaller)

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Install APK on your phone

Transfer the `.apk` file to your phone and tap to install.  
Or install directly via:

```bash
flutter install
```

---

## Controls

| Platform  | Move Left             | Move Right            | Pause        |
|-----------|-----------------------|-----------------------|--------------|
| Android   | Tap left half         | Tap right half        | Pause button |
| Desktop   | ← Arrow or A          | → Arrow or D          | Esc or P     |
| Web       | ← Arrow or A          | → Arrow or D          | Esc or P     |

---

## Game Features

- **5 levels** with increasing speed, traffic, and obstacle density
- **Touch controls** (Android) and **keyboard controls** (desktop/web)
- **Collision detection** with enemy cars, obstacles, and coins
- **Lives system** (3 hearts) with brief invincibility after a hit
- **Score** from distance traveled + coin pickups
- **Level unlock system** saved locally
- **High score** saved locally
- **Pause / Resume / Restart** overlays
- **Level complete + Game Over** screens
- All graphics are **code-drawn** – no external image assets required

---

## 5 Future Improvements

1. **Nitro Boost** – collect fuel pickups to activate a temporary speed burst  
2. **Coin Shop** – spend collected coins on car skins and upgrades  
3. **Multiple Cars** – unlock different vehicles with varied stats (speed, handling)  
4. **Boss Level** – face a police car that tries to ram you at the end of each world  
5. **Endless Mode** – infinite procedurally generated road with online leaderboard  

---

## Troubleshooting

| Problem                           | Solution                                        |
|-----------------------------------|-------------------------------------------------|
| `flutter pub get` fails           | Run `flutter doctor` and fix any issues          |
| Black screen on web               | Make sure `web/index.html` exists                |
| "No devices found"                | Start an emulator or connect a physical device   |
| APK won't install                 | Enable "Install from unknown sources" on phone   |
| Slow on old phone                 | Lower `scrollSpeed` values in `level_config.dart`|

---

## License

This project is provided as-is for learning purposes. Feel free to modify,
extend, and share.

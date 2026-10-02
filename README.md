# Word Clock Widget

A stylish home screen widget for both Android and iOS that tells the time using words instead of numbers, inspired by the iconic QLOCKTWO design.

## Platforms

### Android
The Android version is a native widget built with Kotlin and `RemoteViews`.
- **Location:** `word-clock/`
- **Features:** Updates exactly on the minute using `AlarmManager.setExact`. 
- **Note on Latency:** Due to how modern Android operating systems optimize battery life and background processes, there may sometimes be a slight latency (a few seconds) when the system minute ticks over before the widget redraws.

### iOS
The iOS version is built natively using Swift, SwiftUI, and WidgetKit.
- **Location:** `ios-word-clock/`
- **Features:** Uses `TimelineProvider` to schedule precise minute-by-minute updates.
- **Note on Latency:** Similar to Android, iOS manages widget refresh cycles to save battery. While WidgetKit is highly optimized, minor delays in redraws can occasionally happen depending on the device's current power state.

## Getting Started

### Android
1. Open the `word-clock` folder in Android Studio.
2. Connect your device or start an emulator.
3. Click "Run" to install the app.
4. Long-press your home screen and add the "Word Clock" widget.

### iOS
*(Requires a Mac with Xcode)*
1. Open Xcode and create a new iOS App.
2. Add a **Widget Extension** target.
3. Replace the generated widget files with `TimeToWordsConverter.swift` and `WordClockWidget.swift` from the `ios-word-clock/` folder.
4. Build and run on your iPhone or iOS Simulator.

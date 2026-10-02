# Word Clock Widget

A stylish home screen widget for Android that tells the time using words instead of numbers, inspired by the iconic QLOCKTWO design.

## Details

The Android version is a native widget built with Kotlin and `RemoteViews`.
- **Location:** `word-clock/`
- **Features:** Updates exactly on the minute using `AlarmManager.setExact`. 
- **Note on Latency:** Due to how modern Android operating systems optimize battery life and background processes, there may sometimes be a slight latency (a few seconds) when the system minute ticks over before the widget redraws.

## Getting Started

1. Open the `word-clock` folder in Android Studio.
2. Connect your Android device or start an emulator.
3. Click "Run" to install the app.
4. Long-press your home screen, go to Widgets, and drag the "Word Clock" widget onto your screen.

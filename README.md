# Word Clock Widget

A stylish home screen widget for Android that tells the time using words instead of numbers, inspired by the iconic QLOCKTWO design.

## Details

The Android version is a native widget built with Kotlin and `RemoteViews`.
- **Location:** `word-clock/`
- **Features:** Updates exactly on the minute using `AlarmManager.setExact`. 
- **Note on Latency:** Due to how modern Android operating systems optimize battery life and background processes, there may sometimes be a slight latency (a few seconds) when the system minute ticks over before the widget redraws.

## Quick Install (No code required!)

The easiest way to get the widget on your phone is to just download the pre-built app:

1. Download the **`WordClockWidget.apk`** file from this repository to your Android phone.
2. Tap the file to install it. *(You may need to allow "Install from unknown sources" in your settings).*
3. Go to your home screen, long-press on an empty space, tap **Widgets**, and drag the **Word Clock** widget onto your screen!

## For Developers

If you want to edit the code or build it yourself:
1. Open the `word-clock` folder in Android Studio.
2. Connect your Android device or start an emulator.
3. Click "Run" to install the app.

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

## How to Read the Time

The clock tells time in five-minute intervals using the illuminated words on the grid (e.g., "IT IS TEN PAST TWELVE"). 

To know the exact minute, look at the **four small dots** at the bottom of the widget:
- **0 dots lit:** Exactly the time written (e.g., 12:10).
- **1 dot lit:** Add one minute (12:11).
- **2 dots lit:** Add two minutes (12:12).
- **3 dots lit:** Add three minutes (12:13).
- **4 dots lit:** Add four minutes (12:14).

Once the 5th minute passes, the words will update to the next interval (e.g., "IT IS A QUARTER PAST TWELVE") and the dots will reset to zero.

## For Developers

If you want to edit the code or build it yourself:
1. Open the `word-clock` folder in Android Studio.
2. Connect your Android device or start an emulator.
3. Click "Run" to install the app.

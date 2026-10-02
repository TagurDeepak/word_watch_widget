package com.example.wordclock

import java.util.Calendar

object TimeToWordsConverter {

    val grid = arrayOf(
        "ITLISASAMPM",
        "ACQUARTERDC",
        "TWENTYFIVEX",
        "HALFBTENFTO",
        "PASTERUNINE",
        "ONESIXTHREE",
        "FOURFIVETWO",
        "EIGHTELEVEN",
        "SEVENTWELVE",
        "TENSEOCLOCK"
    )

    data class WordPos(val row: Int, val col: Int, val length: Int)

    fun getHighlightedWords(calendar: Calendar): List<WordPos> {
        val highlighted = mutableListOf<WordPos>()
        
        // "IT IS"
        highlighted.add(WordPos(0, 0, 2)) // IT
        highlighted.add(WordPos(0, 3, 2)) // IS

        var minute = calendar.get(Calendar.MINUTE)
        var hour = calendar.get(Calendar.HOUR)
        if (hour == 0) hour = 12 // 12-hour format

        // If minutes >= 35, we say "TO" the next hour
        if (minute >= 35) {
            hour = (hour % 12) + 1
        }

        // Add minute words
        val minuteInterval = minute / 5
        when (minuteInterval) {
            0 -> highlighted.add(WordPos(9, 5, 6)) // OCLOCK
            1 -> {
                highlighted.add(WordPos(2, 6, 4)) // FIVE
                highlighted.add(WordPos(4, 0, 4)) // PAST
            }
            2 -> {
                highlighted.add(WordPos(3, 5, 3)) // TEN
                highlighted.add(WordPos(4, 0, 4)) // PAST
            }
            3 -> {
                highlighted.add(WordPos(1, 0, 1)) // A
                highlighted.add(WordPos(1, 2, 7)) // QUARTER
                highlighted.add(WordPos(4, 0, 4)) // PAST
            }
            4 -> {
                highlighted.add(WordPos(2, 0, 6)) // TWENTY
                highlighted.add(WordPos(4, 0, 4)) // PAST
            }
            5 -> {
                highlighted.add(WordPos(2, 0, 6)) // TWENTY
                highlighted.add(WordPos(2, 6, 4)) // FIVE
                highlighted.add(WordPos(4, 0, 4)) // PAST
            }
            6 -> {
                highlighted.add(WordPos(3, 0, 4)) // HALF
                highlighted.add(WordPos(4, 0, 4)) // PAST
            }
            7 -> {
                highlighted.add(WordPos(2, 0, 6)) // TWENTY
                highlighted.add(WordPos(2, 6, 4)) // FIVE
                highlighted.add(WordPos(3, 9, 2)) // TO
            }
            8 -> {
                highlighted.add(WordPos(2, 0, 6)) // TWENTY
                highlighted.add(WordPos(3, 9, 2)) // TO
            }
            9 -> {
                highlighted.add(WordPos(1, 0, 1)) // A
                highlighted.add(WordPos(1, 2, 7)) // QUARTER
                highlighted.add(WordPos(3, 9, 2)) // TO
            }
            10 -> {
                highlighted.add(WordPos(3, 5, 3)) // TEN
                highlighted.add(WordPos(3, 9, 2)) // TO
            }
            11 -> {
                highlighted.add(WordPos(2, 6, 4)) // FIVE
                highlighted.add(WordPos(3, 9, 2)) // TO
            }
        }

        // Add hour word
        when (hour) {
            1 -> highlighted.add(WordPos(5, 0, 3)) // ONE
            2 -> highlighted.add(WordPos(6, 8, 3)) // TWO
            3 -> highlighted.add(WordPos(5, 6, 5)) // THREE
            4 -> highlighted.add(WordPos(6, 0, 4)) // FOUR
            5 -> highlighted.add(WordPos(6, 4, 4)) // FIVE
            6 -> highlighted.add(WordPos(5, 3, 3)) // SIX
            7 -> highlighted.add(WordPos(8, 0, 5)) // SEVEN
            8 -> highlighted.add(WordPos(7, 0, 5)) // EIGHT
            9 -> highlighted.add(WordPos(4, 7, 4)) // NINE
            10 -> highlighted.add(WordPos(9, 0, 3)) // TEN
            11 -> highlighted.add(WordPos(7, 5, 6)) // ELEVEN
            12 -> highlighted.add(WordPos(8, 5, 6)) // TWELVE
        }

        return highlighted
    }

    fun getExtraMinutes(calendar: Calendar): Int {
        return calendar.get(Calendar.MINUTE) % 5
    }
}

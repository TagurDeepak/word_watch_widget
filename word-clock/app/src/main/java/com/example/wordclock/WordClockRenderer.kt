package com.example.wordclock

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Typeface
import java.util.Calendar

object WordClockRenderer {

    fun createClockBitmap(context: Context, width: Int, height: Int, calendar: Calendar): Bitmap {
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)

        // Background
        canvas.drawColor(Color.BLACK)

        val grid = TimeToWordsConverter.grid
        val rows = grid.size
        val cols = grid[0].length

        // We need to leave some space at the bottom for the 4 minute dots
        val padding = 40f
        val dotAreaHeight = 80f
        
        val cellWidth = (width - 2 * padding) / cols
        val cellHeight = (height - 2 * padding - dotAreaHeight) / rows

        val activePaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = Color.WHITE
            textSize = cellHeight * 0.7f
            typeface = Typeface.DEFAULT_BOLD
            textAlign = Paint.Align.CENTER
            setShadowLayer(10f, 0f, 0f, Color.WHITE) // Glow effect
        }

        val inactivePaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = Color.DKGRAY
            textSize = cellHeight * 0.7f
            typeface = Typeface.DEFAULT_BOLD
            textAlign = Paint.Align.CENTER
        }

        val highlightedWords = TimeToWordsConverter.getHighlightedWords(calendar)
        val activeIndices = mutableSetOf<Pair<Int, Int>>()
        
        for (word in highlightedWords) {
            for (i in 0 until word.length) {
                activeIndices.add(Pair(word.row, word.col + i))
            }
        }

        // Draw grid
        for (r in 0 until rows) {
            for (c in 0 until cols) {
                val letter = grid[r][c].toString()
                val x = padding + c * cellWidth + cellWidth / 2f
                val y = padding + r * cellHeight + cellHeight / 2f - (activePaint.descent() + activePaint.ascent()) / 2f

                if (activeIndices.contains(Pair(r, c))) {
                    canvas.drawText(letter, x, y, activePaint)
                } else {
                    canvas.drawText(letter, x, y, inactivePaint)
                }
            }
        }

        // Draw minute dots at the bottom
        val extraMinutes = TimeToWordsConverter.getExtraMinutes(calendar)
        val dotRadius = 8f
        val dotSpacing = 40f
        val startX = width / 2f - (3 * dotSpacing) / 2f
        val dotY = height - padding - dotAreaHeight / 2f

        val activeDotPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = Color.WHITE
            setShadowLayer(10f, 0f, 0f, Color.WHITE)
        }
        val inactiveDotPaint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = Color.DKGRAY
        }

        for (i in 0 until 4) {
            val x = startX + i * dotSpacing
            val paint = if (i < extraMinutes) activeDotPaint else inactiveDotPaint
            canvas.drawCircle(x, dotY, dotRadius, paint)
        }

        return bitmap
    }
}

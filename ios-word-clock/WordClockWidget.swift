import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of one entry per minute for the next hour
        let currentDate = Date()
        let calendar = Calendar.current
        
        for minuteOffset in 0 ..< 60 {
            if let entryDate = calendar.date(byAdding: .minute, value: minuteOffset, to: currentDate) {
                // Strip seconds to update exactly on the minute
                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: entryDate)
                if let exactMinuteDate = calendar.date(from: components) {
                    entries.append(SimpleEntry(date: exactMinuteDate))
                }
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WordClockWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 8) {
                // Word Grid
                let grid = TimeToWordsConverter.grid
                let highlightedWords = TimeToWordsConverter.getHighlightedWords(for: entry.date)
                
                // Precompute active indices for O(1) lookup
                let activeIndices = computeActiveIndices(highlightedWords: highlightedWords)
                
                VStack(spacing: 4) {
                    ForEach(0..<grid.count, id: \.self) { row in
                        HStack(spacing: 4) {
                            let rowString = Array(grid[row])
                            ForEach(0..<rowString.count, id: \.self) { col in
                                let isActive = activeIndices.contains(Pair(row: row, col: col))
                                Text(String(rowString[col]))
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                    .foregroundColor(isActive ? .white : .gray.opacity(0.3))
                                    .shadow(color: isActive ? .white : .clear, radius: isActive ? 2 : 0)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                Spacer(minLength: 5)
                
                // Extra Minute Dots
                let extraMinutes = TimeToWordsConverter.getExtraMinutes(for: entry.date)
                HStack(spacing: 16) {
                    ForEach(0..<4, id: \.self) { i in
                        Circle()
                            .fill(i < extraMinutes ? Color.white : Color.gray.opacity(0.3))
                            .frame(width: 6, height: 6)
                            .shadow(color: i < extraMinutes ? .white : .clear, radius: i < extraMinutes ? 2 : 0)
                    }
                }
                .padding(.bottom, 10)
            }
            .padding(.top, 10)
        }
    }
    
    struct Pair: Hashable {
        let row: Int
        let col: Int
    }
    
    func computeActiveIndices(highlightedWords: [WordPos]) -> Set<Pair> {
        var indices = Set<Pair>()
        for word in highlightedWords {
            for i in 0..<word.length {
                indices.insert(Pair(row: word.row, col: word.col + i))
            }
        }
        return indices
    }
}

@main
struct WordClockWidget: Widget {
    let kind: String = "WordClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WordClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Word Clock")
        .description("Displays the time in words.")
        .supportedFamilies([.systemLarge])
    }
}

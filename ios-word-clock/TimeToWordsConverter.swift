import Foundation

struct WordPos: Hashable {
    let row: Int
    let col: Int
    let length: Int
}

struct TimeToWordsConverter {
    
    static let grid: [String] = [
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
    ]
    
    static func getHighlightedWords(for date: Date) -> [WordPos] {
        var highlighted: [WordPos] = []
        
        // "IT IS"
        highlighted.append(WordPos(row: 0, col: 0, length: 2)) // IT
        highlighted.append(WordPos(row: 0, col: 3, length: 2)) // IS
        
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        var hour = calendar.component(.hour, from: date)
        
        // 12-hour format
        hour = hour % 12
        if hour == 0 { hour = 12 }
        
        // If minutes >= 35, we say "TO" the next hour
        if minute >= 35 {
            hour = (hour % 12) + 1
        }
        
        // Add minute words
        let minuteInterval = minute / 5
        switch minuteInterval {
        case 0:
            highlighted.append(WordPos(row: 9, col: 5, length: 6)) // OCLOCK
        case 1:
            highlighted.append(WordPos(row: 2, col: 6, length: 4)) // FIVE
            highlighted.append(WordPos(row: 4, col: 0, length: 4)) // PAST
        case 2:
            highlighted.append(WordPos(row: 3, col: 5, length: 3)) // TEN
            highlighted.append(WordPos(row: 4, col: 0, length: 4)) // PAST
        case 3:
            highlighted.append(WordPos(row: 1, col: 0, length: 1)) // A
            highlighted.append(WordPos(row: 1, col: 2, length: 7)) // QUARTER
            highlighted.append(WordPos(row: 4, col: 0, length: 4)) // PAST
        case 4:
            highlighted.append(WordPos(row: 2, col: 0, length: 6)) // TWENTY
            highlighted.append(WordPos(row: 4, col: 0, length: 4)) // PAST
        case 5:
            highlighted.append(WordPos(row: 2, col: 0, length: 6)) // TWENTY
            highlighted.append(WordPos(row: 2, col: 6, length: 4)) // FIVE
            highlighted.append(WordPos(row: 4, col: 0, length: 4)) // PAST
        case 6:
            highlighted.append(WordPos(row: 3, col: 0, length: 4)) // HALF
            highlighted.append(WordPos(row: 4, col: 0, length: 4)) // PAST
        case 7:
            highlighted.append(WordPos(row: 2, col: 0, length: 6)) // TWENTY
            highlighted.append(WordPos(row: 2, col: 6, length: 4)) // FIVE
            highlighted.append(WordPos(row: 3, col: 9, length: 2)) // TO
        case 8:
            highlighted.append(WordPos(row: 2, col: 0, length: 6)) // TWENTY
            highlighted.append(WordPos(row: 3, col: 9, length: 2)) // TO
        case 9:
            highlighted.append(WordPos(row: 1, col: 0, length: 1)) // A
            highlighted.append(WordPos(row: 1, col: 2, length: 7)) // QUARTER
            highlighted.append(WordPos(row: 3, col: 9, length: 2)) // TO
        case 10:
            highlighted.append(WordPos(row: 3, col: 5, length: 3)) // TEN
            highlighted.append(WordPos(row: 3, col: 9, length: 2)) // TO
        case 11:
            highlighted.append(WordPos(row: 2, col: 6, length: 4)) // FIVE
            highlighted.append(WordPos(row: 3, col: 9, length: 2)) // TO
        default:
            break
        }
        
        // Add hour word
        switch hour {
        case 1: highlighted.append(WordPos(row: 5, col: 0, length: 3)) // ONE
        case 2: highlighted.append(WordPos(row: 6, col: 8, length: 3)) // TWO
        case 3: highlighted.append(WordPos(row: 5, col: 6, length: 5)) // THREE
        case 4: highlighted.append(WordPos(row: 6, col: 0, length: 4)) // FOUR
        case 5: highlighted.append(WordPos(row: 6, col: 4, length: 4)) // FIVE
        case 6: highlighted.append(WordPos(row: 5, col: 3, length: 3)) // SIX
        case 7: highlighted.append(WordPos(row: 8, col: 0, length: 5)) // SEVEN
        case 8: highlighted.append(WordPos(row: 7, col: 0, length: 5)) // EIGHT
        case 9: highlighted.append(WordPos(row: 4, col: 7, length: 4)) // NINE
        case 10: highlighted.append(WordPos(row: 9, col: 0, length: 3)) // TEN
        case 11: highlighted.append(WordPos(row: 7, col: 5, length: 6)) // ELEVEN
        case 12: highlighted.append(WordPos(row: 8, col: 5, length: 6)) // TWELVE
        default: break
        }
        
        return highlighted
    }
    
    static func getExtraMinutes(for date: Date) -> Int {
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        return minute % 5
    }
}

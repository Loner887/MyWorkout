import UIKit

extension Date {
    private var calendar: Calendar{
        return Calendar.current
    }
    
    var startOfWeek: Date {
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        components.weekday = calendar.firstWeekday
        guard let firstDay = calendar.date(from: components) else { return self }
        return firstDay
    }
    
    func agoForward(to days: Int) -> Date {
        return calendar.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    func stripTime() -> Date {
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components) ?? self
    }
}

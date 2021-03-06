import FluentSQLite
import Vapor

final class Category: Codable {
    var id: Int?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Category {
    var reminders: Siblings<Category, Reminder, ReminderCategoryPivot> {
        return siblings()
    }
}

extension Category: SQLiteModel { }
extension Category: Content { }
extension Category: Migration { }
extension Category: Parameter { }

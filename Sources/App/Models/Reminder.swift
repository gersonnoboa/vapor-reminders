import FluentSQLite
import Vapor

final class Reminder: Codable {
    var id: Int?
    var title: String
    var userId: User.ID
    
    init(title: String, userId: User.ID) {
        self.title = title
        self.userId = userId
    }
}

extension Reminder {
    var user: Parent<Reminder, User> {
        return parent(\.userId)
    }
    
    var categories: Siblings<Reminder, Category, ReminderCategoryPivot> {
        return siblings()
    }
}

extension Reminder: SQLiteModel { }
extension Reminder: Content { }
extension Reminder: Migration { }
extension Reminder: Parameter { }

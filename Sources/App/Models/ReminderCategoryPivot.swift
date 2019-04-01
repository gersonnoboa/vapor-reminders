import FluentSQLite
import Foundation

final class ReminderCategoryPivot: SQLiteUUIDPivot {
    var id: UUID?
    var reminderId: Reminder.ID
    var categoryId: Category.ID

    typealias Left = Reminder
    typealias Right = Category
    static let leftIDKey: LeftIDKey = \.reminderId
    static let rightIDKey: RightIDKey = \.categoryId
    
    init(_ reminder: Reminder, _ category: Category) throws {
        self.reminderId = try reminder.requireID()
        self.categoryId = try category.requireID()
    }
}

extension ReminderCategoryPivot: ModifiablePivot { }
extension ReminderCategoryPivot: Migration { }

import FluentSQLite
import Vapor

final class User: Codable {
    var id: Int?
    var name: String
    var username: String
    
    init(name: String, username: String) {
        self.name = name
        self.username = username
    }
}

struct CreateDefaultUser: SQLiteMigration {
    static func prepare(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        let user = User(name: "Gerson", username: "gersonnoboa")
        return user.save(on: conn).transform(to: ())
    }
    
    static func revert(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        return .done(on: conn)
    }
}

extension User {
    var reminders: Children<User, Reminder> {
        return children(\.userId)
    }
}

extension User: SQLiteModel {}
extension User: Content {}
extension User: Migration {}
extension User: Parameter {}

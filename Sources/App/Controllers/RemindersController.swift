import Vapor

struct RemindersController: RouteCollection {
    func boot(router: Router) throws {
        let remindersRoute = router.grouped("api", "reminders")
        remindersRoute.post(use: createHandler)
    }
    
    func createHandler(_ req: Request) throws -> Future<Reminder> {
        return try req.content.decode(Reminder.self)
            .flatMap(to: Reminder.self) { reminder in
            return reminder.save(on: req)
        }
    }
}

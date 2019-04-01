import Vapor

struct RemindersController: RouteCollection {
    func boot(router: Router) throws {
        let remindersRoute = router.grouped("api", "reminders")
        remindersRoute.post(use: createHandler)
        remindersRoute.get(use: getAllHandler)
        remindersRoute.get(Reminder.parameter, use: getSingleHandler)
    }
    
    func createHandler(_ req: Request) throws -> Future<Reminder> {
        return try req.content.decode(Reminder.self)
            .flatMap(to: Reminder.self) { reminder in
            return reminder.save(on: req)
        }
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Reminder]> {
        return Reminder.query(on: req).all()
    }
    
    func getSingleHandler(_ req: Request) throws -> Future<Reminder> {
        let user = try req.parameters.next(Reminder.self)
        return user
    }
}

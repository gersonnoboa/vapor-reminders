import Vapor

struct UsersController: RouteCollection {
    func boot(router: Router) throws {
        let usersRoute = router.grouped("api", "users")
        usersRoute.post(use: createHandler)
        usersRoute.get(use: getAllHandler)
        usersRoute.get(User.parameter, use: getSingleHandler)
        usersRoute.delete(User.parameter, use: deleteHandler)
        usersRoute.put(User.self, at: User.parameter, use: updateHandler)
        usersRoute.get(User.parameter, "reminders", use: getRemindersHandler)
    }
    
    func createHandler(_ req: Request) throws -> Future<User> {
        return try req.content
            .decode(User.self)
            .save(on: req)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func getSingleHandler(_ req: Request) throws -> Future<User> {
        let user = try req.parameters.next(User.self)
        return user
    }
    
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        let user = try req.parameters.next(User.self)
        return user.delete(on: req).transform(to: .noContent)
    }
    
    func updateHandler(_ req: Request, updatedUser: User) throws -> Future<User> {
        return try req.parameters.next(User.self)
            .flatMap(to: User.self) { user in
                user.name = updatedUser.name
                user.username = updatedUser.username
                
                return user.save(on: req)
            }
    }
    
    func getRemindersHandler(_ req: Request) throws -> Future<[Reminder]> {
        return try req.parameters.next(User.self)
            .flatMap(to: [Reminder].self) { user in
            return try user.reminders.query(on: req).all()
        }
    }
}

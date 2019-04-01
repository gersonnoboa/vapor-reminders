import Vapor

struct CategoriesController: RouteCollection {
    func boot(router: Router) throws {
        let categoriesRoute = router.grouped("api", "categories")
        categoriesRoute.post(Category.self, use: createHandler)
        categoriesRoute.get(use: getAllHandler)
        categoriesRoute.get(Category.parameter, use: getSingleHandler)
    }
    
    func createHandler(_ req: Request, category: Category) throws -> Future<Category> {
        return category.save(on: req)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Reminder]> {
        return Reminder.query(on: req).all()
    }
    
    func getSingleHandler(_ req: Request) throws -> Future<Reminder> {
        let reminder = try req.parameters.next(Reminder.self)
        return reminder
    }
}

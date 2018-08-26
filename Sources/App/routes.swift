import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let messagesController = MessagesController()
    try router.register(collection: messagesController)
}

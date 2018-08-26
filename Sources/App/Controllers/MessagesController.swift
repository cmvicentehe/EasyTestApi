//
//  MessagesController.swift
//  App
//
//  Created by Carlos Manuel Vicente Herrero on 26/8/18.
//

import Foundation
import Vapor

class MessagesController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: getHomeHandler)
        router.get(use: getMessagesInViewHandler)
        router.get("messages", use: getMessagesHandler)
        router.get("messages", String.parameter, use: getMessagesByUserHandler)
        router.delete("deleteInFormView", Message.parameter, use: deleteMessageByIdInViewHandler)
        router.delete("delete", Message.parameter, use: deleteMessageByIdHandler)
        router.post("send", use: postMessageHandler)
    }
    
    func getHomeHandler(_ request: Request) throws -> Future<View> {
        return try request.view().render("home")
    }
    
    func getMessagesInViewHandler(_ request: Request) throws -> Future<View> {
        return Message.query(on: request).sort(\Message.date, .descending).all().flatMap(to: View.self) { messages in
            let context = ["messages": messages]
            return try request.view().render("home", context)
        }
    }
    
    func getMessagesHandler(_ request: Request) throws -> Future<[Message]> {
       return Message.query(on: request).sort(\Message.date, .descending).all()
    }
    
    func getMessagesByUserHandler(_ request: Request) throws -> Future<[Message]> {
        let username = try request.parameters.next(String.self)
        return Message.query(on: request).filter(\Message.username, ._equal, username).sort(\Message.date, .descending).all()
    }
    
    func deleteMessageByIdInViewHandler(_ request: Request) throws -> Future<Response> {
        return try request.parameters.next(Message.self).flatMap(to: Response.self) { message in
            return message.delete(on: request).map(to: Response.self) { _ in
                return request.redirect(to: "/")
            }
        }
    }
    
    func deleteMessageByIdHandler(_ request: Request) throws -> Future<HTTPStatus> {
        return try request.parameters.next(Message.self).flatMap(to: HTTPStatus.self) { message in
            return message.delete(on: request).transform(to: .noContent)
        }
    }
    
    func postMessageHandler(_ request: Request) throws -> Future<Response> {
        let username: String = try request.content.syncGet(at: "username")
        let content: String = try request.content.syncGet(at: "content")
        let message = Message(
            id: nil,
            username: username,
            content: content,
            date: Date()
        )
        return message.save(on: request).map(to: Response.self) { _ in
            return request.redirect(to: "/")
        }
    }
}

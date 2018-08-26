//
//  Message.swift
//  App
//
//  Created by Carlos Manuel Vicente Herrero on 25/8/18.
//

import Vapor
import FluentSQLite
import Foundation

struct Message: Codable {
    var id: UUID?
    var username: String
    let content: String
    let date: Date
}

extension Message: Content {}
extension Message: Migration {}
extension Message: SQLiteUUIDModel {}
extension Message: Parameter {}

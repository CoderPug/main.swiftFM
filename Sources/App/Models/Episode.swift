//
//  Episode.swift
//  Hello
//
//  Created by Jose Torres on 1/11/16.
//
//

import Vapor
import Fluent
import Foundation

final class Episode: Entity, Model {
    
    var id: Node?
    var date: String
    var title: String
    var description: String
    var imageURL: String
    var audioURL: String
    
    init(title: String, description: String, imageURL: String, audioURL: String, date: String) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.audioURL = audioURL
        self.date = date
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        title = try node.extract("title")
        description = try node.extract("description")
        imageURL = try node.extract("imageURL")
        audioURL = try node.extract("audioURL")
        date = try node.extract("date")
    }
    
    convenience init() {
        self.init(title: "", description: "", imageURL: "", audioURL: "", date: "")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "title": title,
            "description": description,
            "imageURL": imageURL,
            "audioURL": audioURL,
            "date": date
        ])
    }
    
    static func prepare(_ database: Database) throws {
        
    }
    
    static func revert(_ database: Database) throws {
        
    }
}

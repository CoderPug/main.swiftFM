//
//  Episode.swift
//  Hello
//
//  Created by Jose Torres on 1/11/16.
//
//

import Vapor
import Fluent

final class Episode: Model {
    
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
        imageURL = try node.extract("imageurl")
        audioURL = try node.extract("audiourl")
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
            "imageurl": imageURL,
            "audiourl": audioURL,
            "date": date
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("episodes") { episodes in
            episodes.id()
            episodes.string("title")
            episodes.string("description")
            episodes.string("imageurl")
            episodes.string("audiourl")
            episodes.string("date")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("episodes")
    }
}

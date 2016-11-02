//
//  Host.swift
//  Hello
//
//  Created by Jose Torres on 1/11/16.
//
//

import Vapor
import Fluent

final class Host: Entity, Model {
    
    var id: Node?
    var name: String
    var url: String
    var imageURL: String
    
    init(name: String, url: String, imageURL: String) {
        self.name = name
        self.url = url
        self.imageURL = imageURL
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        url = try node.extract("url")
        imageURL = try node.extract("imageURL")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "url": url,
            "imageURL": imageURL
            ])
    }
    
    static func prepare(_ database: Database) throws {
        
    }
    
    static func revert(_ database: Database) throws {
        
    }
}

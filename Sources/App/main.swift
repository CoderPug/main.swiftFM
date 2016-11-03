

import Vapor
import VaporPostgreSQL

let drop = Droplet()

try drop.addProvider(VaporPostgreSQL.Provider.self)
drop.preparations.append(Episode.self)
drop.preparations.append(Host.self)

drop.get("version") { request in
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version)
    } else {
        return "No db connection"
    }
}

drop.post("episode") { request in
    
    guard let title = request.data["title"]?.string,
        let description = request.data["description"]?.string,
        let imageURL = request.data["imageurl"]?.string,
        let audioURL = request.data["audiourl"]?.string,
        let date = request.data["date"]?.string else {
            throw Abort.badRequest
    }
    
    var episode = Episode(title: title, description: description, imageURL: imageURL, audioURL: audioURL, date: date)
    
    try episode.save()
    
    return episode
}

drop.get("episodes") { request in
    
    return try JSON(node: Episode.all())
}

drop.post("host") { request in
    
    guard let name = request.data["name"]?.string,
        let url = request.data["url"]?.string,
        let imageURL = request.data["imageurl"]?.string else {
            throw Abort.badRequest
    }
    
    var host = Host(name: name, url: url, imageURL: imageURL)
    
    try host.save()
    
    return host
}

drop.get("hosts") { request in
    
    return try JSON(node: Host.all())
}

drop.get("/welcome") { request in
    return try drop.view.make("welcome", [
        "message": drop.localization[request.lang, "welcome", "title"]
        ])
}

drop.get("/mainswift") { request in
    
    var arrayEpisodes: [Node]?
    do {
        if let db = drop.database?.driver as? PostgreSQLDriver {
            let resultArray = try db.raw("select * from episodes limit 5")
            arrayEpisodes = resultArray.nodeArray
        } else {
            arrayEpisodes = []
        }
    } catch {
        print(error)
        arrayEpisodes = []
    }
    
    var arrayHosts: [AnyObject]?
    do {
        arrayHosts = try Host.all()
    } catch {
        print(error)
        arrayHosts = []
    }
    
    let featuredEpisode: Node?
    if arrayEpisodes != nil && arrayEpisodes!.count > 0 {
        featuredEpisode = arrayEpisodes?.first
        arrayEpisodes?.removeFirst()
    } else {
        featuredEpisode = nil
    }
    
    var argument: [String: NodeRepresentable]
    
    if featuredEpisode != nil {
        argument = [
            "swiftLogoURL": "images/mainswiftlogo500x500.png",
            "featuredEpisode": featuredEpisode ?? EmptyNode,
            "episodes": try arrayEpisodes?.makeNode() ?? EmptyNode,
            "hosts": try (arrayHosts as? [Host])?.makeNode() ?? EmptyNode
        ]
    } else {
        argument = [
            "swiftLogoURL": "images/mainswiftlogo500x500.png",
            "episodes": try arrayEpisodes?.makeNode() ?? EmptyNode,
            "hosts": try (arrayHosts as? [Host])?.makeNode() ?? EmptyNode
        ]
    }
    
    return try drop.view.make("mainswift", argument)
}

drop.get("/mainswift/episodes") { request in
    
    var arrayEpisodes: [AnyObject]?
    do {
        arrayEpisodes = try Episode.all()
    } catch {
        print(error)
        arrayEpisodes = []
    }
    
    var arrayHosts: [AnyObject]?
    do {
        arrayHosts = try Host.all()
    } catch {
        print(error)
        arrayHosts = []
    }
    
    return try drop.view.make("episodes", [
        "swiftLogoURL": "../images/mainswiftlogo500x500.png",
        "episodes": try (arrayEpisodes as? [Episode])?.makeNode() ?? EmptyNode,
        "hosts": try (arrayHosts as? [Host])?.makeNode() ?? EmptyNode
        ])
}

drop.get("/mainswift/episodes/", Int.self) { request, episodeId in
    
    var episode: Episode?
    do {
        episode = try Episode.find(episodeId)
    } catch {
        print(error)
        episode = nil
    }
    
    var arrayHosts: [AnyObject]?
    do {
        arrayHosts = try Host.all()
    } catch {
        print(error)
        arrayHosts = []
    }
    
    var argument: [String: NodeRepresentable]
    
    if episode != nil {
        argument = [
            "swiftLogoURL": "../../images/mainswiftlogo500x500.png",
            "episode": try episode?.makeNode() ?? EmptyNode,
            "hosts": try (arrayHosts as? [Host])?.makeNode() ?? EmptyNode
        ]
    } else {
        argument = [
            "swiftLogoURL": "../../images/mainswiftlogo500x500.png",
            "hosts": try (arrayHosts as? [Host])?.makeNode() ?? EmptyNode
        ]
    }
    
    return try drop.view.make("episode", argument)

}

drop.run()

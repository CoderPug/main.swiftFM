

import Vapor

let drop = Droplet()

drop.get("/welcome") { request in
    return try drop.view.make("welcome", [
        "message": drop.localization[request.lang, "welcome", "title"]
        ])
}

drop.get("/mainswift") { request in
    
    let episodeA = Episode(title: "1", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    let episodeB = Episode(title: "2", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    let episodeC = Episode(title: "3", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    let episodeD = Episode(title: "4", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    let episodeE = Episode(title: "5", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    var arrayEpisodes = [episodeA, episodeB, episodeC, episodeD, episodeE]
    
    let hostA = Host(name: "Ricardo Herrera", url: "https://twitter.com/nicetonoeu", imageURL: "https://pbs.twimg.com/profile_images/2387209127/46xaeh8qd9f76b9xrjv2_400x400.jpeg")
    let hostB = Host(name: "Jose Torres", url: "https://twitter.com/coderpug", imageURL: "https://pbs.twimg.com/profile_images/576949656304799744/f2wKztB1_400x400.jpeg")
    let hostC = Host(name: "Alsey Coleman", url: "https://twitter.com/colemancda", imageURL: "https://pbs.twimg.com/profile_images/706080273096708096/X32YKWdN_400x400.jpg")
    let arrayHosts = [hostA, hostB, hostC]
    
    let featuredEpisode: Episode?
    if arrayEpisodes.count > 0 {
        featuredEpisode = arrayEpisodes.first
        arrayEpisodes.removeFirst()
    } else {
        featuredEpisode = Episode()
    }
    
    return try drop.view.make("mainswift", [
        "swiftLogoURL": "images/mainswiftlogo500x500.png",
        "featuredEpisode": featuredEpisode?.makeNode() ?? EmptyNode,
        "episodes": arrayEpisodes.makeNode(),
        "hosts": arrayHosts.makeNode()
        ])
}

drop.get("/mainswift/episodes") { request in
    
    let episodeA = Episode(title: "1", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    let episodeB = Episode(title: "2", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    let episodeC = Episode(title: "3", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    let episodeD = Episode(title: "4", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    let episodeE = Episode(title: "5", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    var arrayEpisodes = [episodeA, episodeB, episodeC, episodeD, episodeE]
    
    let hostA = Host(name: "Ricardo Herrera", url: "https://twitter.com/nicetonoeu", imageURL: "https://pbs.twimg.com/profile_images/2387209127/46xaeh8qd9f76b9xrjv2_400x400.jpeg")
    let hostB = Host(name: "Jose Torres", url: "https://twitter.com/coderpug", imageURL: "https://pbs.twimg.com/profile_images/576949656304799744/f2wKztB1_400x400.jpeg")
    let hostC = Host(name: "Alsey Coleman", url: "https://twitter.com/colemancda", imageURL: "https://pbs.twimg.com/profile_images/706080273096708096/X32YKWdN_400x400.jpg")
    let arrayHosts = [hostA, hostB, hostC]
    
    return try drop.view.make("episodes", [
        "swiftLogoURL": "../images/mainswiftlogo500x500.png",
        "episodes": arrayEpisodes.makeNode(),
        "hosts": arrayHosts.makeNode()
        ])
}

drop.get("/mainswift/episodes/", String.self) { request, episodeId in
    
    let episodeA = Episode(title: "1", description: "descripción", imageURL: "", audioURL: "", date: "01 Noviembre")
    
    let hostA = Host(name: "Ricardo Herrera", url: "https://twitter.com/nicetonoeu", imageURL: "https://pbs.twimg.com/profile_images/2387209127/46xaeh8qd9f76b9xrjv2_400x400.jpeg")
    let hostB = Host(name: "Jose Torres", url: "https://twitter.com/coderpug", imageURL: "https://pbs.twimg.com/profile_images/576949656304799744/f2wKztB1_400x400.jpeg")
    let hostC = Host(name: "Alsey Coleman", url: "https://twitter.com/colemancda", imageURL: "https://pbs.twimg.com/profile_images/706080273096708096/X32YKWdN_400x400.jpg")
    let arrayHosts = [hostA, hostB, hostC]
    
    return try drop.view.make("episode", [
        "swiftLogoURL": "../../images/mainswiftlogo500x500.png",
        "episode": episodeA.makeNode(),
        "hosts": arrayHosts.makeNode()
        ])

}

drop.run()

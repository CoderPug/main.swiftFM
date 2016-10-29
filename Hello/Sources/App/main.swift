import Vapor

let drop = Droplet()

drop.get("/welcome") { request in
    return try drop.view.make("welcome", [
        "message": drop.localization[request.lang, "welcome", "title"]
        ])
}

drop.get("/") { request in
    return try drop.view.make("index", [
    	"message": drop.localization[request.lang, "welcome", "title"]
        ])
}

drop.run()

//
//  main.swift
//  Quiz-backend
//
//  Created by Abdullah Alnutayfi on 07/02/2022.
//

import Foundation
import Kitura
//import SwiftyJSON

#if os(Linux)
    import Glibc
    srand(UInt32(time(nil)))
#else
    import Darwin.C
#endif

// Create a new router
let router = Router()

// Create cards
let cards = ["A room without books is like a body without a soul.","Be who you are and say what you feel, because those who mind don't matter, and those who matter don't mind.","Don’t walk in front of me… I may not follow. Don’t walk behind me… I may not lead. Walk beside me… just be my friend","Always forgive your enemies; nothing annoys them so much."]

// Handle HTTP GET requests to /cards
router.get("/cards") {
    request, response, next in
#if os(Linux)
    let idx = Int(random() % salutations.count)
#else
    let idx = Int(arc4random_uniform(UInt32(cards.count)))
    let encoder = JSONEncoder()
    let json = try? encoder.encode(cards[idx])
 //   print(json)
#endif
 
    response.send(String(decoding: json ?? Data(), as: UTF8.self))
    next()
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 1001, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()

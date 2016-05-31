//
//  PerfectHandlers.swift
//  RoutingProject
//
//  Created by IVAN CHIRKOV on 31.05.16.
//  Copyright © 2016 IVAN CHIRKOV. All rights reserved.
//

import PerfectLib // release-1.0.1

public func PerfectServerModuleInit() {
    
    /* Registering routes for API: */
    Routing.Handler.registerGlobally()
    // For example:
    Routing.Routes["GET", ["/api/info"] ] = { (_:WebResponse) in return APIInfoHandler() } // Not working without calling registerGlobally()!
    // For AJAX:
    // Routing.Routes["GET", ["/api/user"] ] = ...
    // Routing.Routes["POST", ["/api/user"] ] = ...
    // Routing.Routes["DELETE", ["/api/user"] ] = ...
    // ...
    
    
    
    /* Registering handlers for Mustache: */
    PageHandlerRegistry.addPageHandler("IndexHandler") { (_:WebResponse) -> PageHandler in // Not work when registerGlobally() called!
        return IndexHandler()
    }
    
    PageHandlerRegistry.addPageHandler("RegistationHandler") { (_:WebResponse) -> PageHandler in // Not work when registerGlobally() called!
        // This page called /api/user methods via AJAX
        return RegistationHandler()
    }
    // ...
    
    
    /* Summary 
     
     If you call `Routing.Handler.registerGlobally()`:
     0.0.0.0:8181/ and 0.0.0.0:8181/registration not working with message: "The file /registration was not found."
     
     If you not call `Routing.Handler.registerGlobally()`:
     0.0.0.0:8181/api/info and 0.0.0.0:8181/api/user not working with message: "The file "/api/info" was not found."
     
     How to make them work together?
     
     */
    
    
    
}

class APIInfoHandler: RequestHandler {
    
    func handleRequest(request: WebRequest, response: WebResponse) {
        
        let endpointInfo: [String: JSONValue] = [
            "version" : "0.1",
            "about" : "This is API, which runs on the same server as the site."
        ]
        
        let encoder = JSONEncoder()
        let jsonString = try! encoder.encode(endpointInfo)
        
        response.addHeader("Content-Type", value: "application/json")
        response.appendBodyString(jsonString)
        response.requestCompletedCallback()
    }
    
}


class IndexHandler: PageHandler {
    
    func valuesForResponse(context: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) throws -> MustacheEvaluationContext.MapType {
        // ...
        return MustacheEvaluationContext.MapType()
    }
    
}

class RegistationHandler: PageHandler {
    
    func valuesForResponse(context: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) throws -> MustacheEvaluationContext.MapType {
        // ...
        return MustacheEvaluationContext.MapType()
    }
    
}
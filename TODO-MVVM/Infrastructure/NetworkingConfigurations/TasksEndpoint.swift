//
//  TasksEndpoint.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 18/2/2022.
//

import Foundation

// if you wish you can have multiple services like this in a project
enum TasksServiceEndpoints {
  // organise all the end points here for clarity
    case getTasks
    

  //specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .getTasks:
            return .GET
        }
    }
    
  // compose the NetworkRequest
    func createRequest() -> NetworkRequest {
        return NetworkRequest(url: getURL(), headers: AppConfiguration.getHeader(), reqBody: requestBody, httpMethod: httpMethod)
    }
    
  // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .getTasks:
            return nil

        }
    }
    
  // compose urls for each request
    func getURL() -> String {
        switch self {
        case .getTasks: return EndPoints.getAllTasks.description
        }
    }
}

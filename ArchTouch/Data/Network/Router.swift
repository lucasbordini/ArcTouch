//
//  Router.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 13/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

enum Router {
    
    case getKeywords
    
    var scheme: String {
        switch self {
        case .getKeywords:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getKeywords:
            return "codechallenge.arctouch.com"
        }
    }
    
    var path: String {
        switch self {
        case .getKeywords:
            return "/quiz/1"
        }
    }
    
    var method: String {
        switch self {
        case .getKeywords:
            return "GET"
        }
    }
    
    
}

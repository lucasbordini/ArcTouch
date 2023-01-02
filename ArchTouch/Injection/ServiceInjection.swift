//
//  ServiceInjection.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 13/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

class ServiceInjection {
    
    static var quizService: QuizService {
        if isMock() {
           return QuizServiceMock()
        }
        return QuizServiceServer()
    }
}

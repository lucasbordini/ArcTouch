//
//  QuizServiceMock.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 13/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

class QuizServiceMock: QuizService {
    
    func getQuiz(completion: @escaping (Quiz?) -> ()) {
        let quiz = Quiz(question: "What are all the Java keywords ?", answer: ["final", "try", "catch", "return", "finally"])
        completion(quiz)
    }
    
}

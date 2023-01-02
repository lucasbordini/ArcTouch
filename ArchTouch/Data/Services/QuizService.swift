//
//  QuizService.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 13/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

protocol QuizService {
    
    func getQuiz(completion: @escaping (Quiz?) -> ())
    
}

class QuizServiceServer: QuizService {
    
    func getQuiz(completion: @escaping (Quiz?) -> ()){
        ServiceLayer.request(router: .getKeywords) { (result: Result<Quiz, Error>) in
            switch result {
            case .success(let quiz):
                completion(quiz)
            case .failure:
                completion(nil)
            }
        }
    }
    
}

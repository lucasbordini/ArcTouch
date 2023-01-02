//
//  QuizTests.swift
//  ArchTouchTests
//
//  Created by Lucas Bordini Ribeiro de Araujo on 13/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation
import XCTest

@testable import ArchTouch

class QuizTests: XCTestCase {
    
    let presenter = QuizPresenter()
    
    func testLoadData() {
        XCTAssertNil(presenter.quiz)
        presenter.loadData()
        XCTAssertNotNil(self.presenter.quiz)
        let question = "What are all the Java keywords ?"
        let answers = ["final", "try", "catch", "return", "finally"]
        XCTAssertEqual(presenter.quiz?.answer, answers)
        XCTAssertEqual(presenter.quiz?.question, question)
    }
    
    func testAttachView() {
        XCTAssertNil(presenter.viewController)
        let vc = QuizViewController()
        presenter.attachView(vc: vc)
        XCTAssertNotNil(presenter.viewController)
    }
    
    func testStartGame() {
        presenter.loadData()
        self.presenter.startGame()
        XCTAssertEqual(self.presenter.seconds, 300)
        XCTAssertEqual(self.presenter.lefttovers, self.presenter.quiz?.answer)
        XCTAssertTrue(self.presenter.timer.isValid)
        XCTAssertTrue(self.presenter.hits.isEmpty)
    }
    
    func testCompareAnswer() {
        presenter.loadData()
        presenter.startGame()
        XCTAssertEqual(presenter.lefttovers, presenter.quiz?.answer)
        XCTAssertTrue(presenter.hits.isEmpty)
        var answers = ["final", "try", "catch", "return", "finally"]
        var leftouversCount = presenter.lefttovers.count
        var hitsCount = presenter.hits.count
        while (!answers.isEmpty) {
            if let answer = answers.popLast() {
                presenter.compareAnswer(answer)
                XCTAssertEqual(answers, presenter.lefttovers)
                leftouversCount -= 1
                hitsCount += 1
                XCTAssertEqual(leftouversCount, presenter.lefttovers.count)
                XCTAssertEqual(hitsCount, presenter.hits.count)
            }
        }
        XCTAssertFalse(presenter.timer.isValid)
    }
    
    func testTimeString() {
        let answerOne = "05:00"
        let answerTwo = "02:50"
        let answerThree = "01:25"
        let answerFour = "00:43"
        let answerFive = "00:07"
        
        XCTAssertEqual(presenter.timeString(300), answerOne)
        XCTAssertEqual(presenter.timeString(170), answerTwo)
        XCTAssertEqual(presenter.timeString(85), answerThree)
        XCTAssertEqual(presenter.timeString(43), answerFour)
        XCTAssertEqual(presenter.timeString(7), answerFive)
    }
}

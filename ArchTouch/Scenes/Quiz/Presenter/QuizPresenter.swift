//
//  Presenter.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 12/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

class QuizPresenter {
    
    weak private(set) var viewController: QuizViewController?

    private var service: QuizService
    
    private(set) var timer: Timer = Timer()
    private(set) var seconds: TimeInterval = 300
    private(set) var quiz: Quiz?
    private(set) var hits: [String] = [String]()
    private(set) var lefttovers: [String] = [String]()
    
    init() {
        service = ServiceInjection.quizService
    }
    
    func attachView(vc: QuizViewController) {
        viewController = vc
    }
    
    func loadData() {
        viewController?.toogleLoading(show: true)
        service.getQuiz(completion: { [weak self] quiz in
            if let quiz = quiz {
                self?.quiz = quiz
                self?.viewController?.toogleLoading(show: false)
            } else {
                self?.viewController?.showErrorAlert()
            }
        })
    }
    
    func startGame() {
        guard let quiz = quiz else { return }
        seconds = 300
        hits.removeAll()
        viewController?.updateHits("0", of: quiz.answer.count.toString)
        viewController?.reloadTable()
        viewController?.updateTimer(timeString(seconds))
        lefttovers = quiz.answer
        timer.invalidate()
        runTimer()
    }
    
    
    func compareAnswer(_ answer: String) {
        guard let quiz = quiz else { return }
        if (lefttovers.contains(answer)) {
            hits.append(answer)
            lefttovers.removeAll(where: { $0 == answer })
            if (lefttovers.isEmpty) {
                viewController?.showAlert(win: true)
                timer.invalidate()
            }
            viewController?.updateHits(hits.count.toString, of: quiz.answer.count.toString)
        }
    }
    
    func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] time in
            self?.seconds -= 1
            self?.viewController?.updateTimer(self?.timeString(self?.seconds ?? 0) ?? "")
            if (self?.seconds == 0) {
                self?.viewController?.showAlert(win: false)
                time.invalidate()
            }
        })
    }
    
}

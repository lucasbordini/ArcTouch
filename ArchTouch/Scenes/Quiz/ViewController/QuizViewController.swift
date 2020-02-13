//
//  QuizViewController.swift
//  ArchTouch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 12/02/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak private var answerTextField: UITextField!
    @IBOutlet weak private var hitsTableView: UITableView!
    @IBOutlet weak private var hitsLabel: UILabel!
    @IBOutlet weak private var timerLabel: UILabel!
    @IBOutlet weak private var scrollView: UIScrollView!
    
    @IBOutlet weak private var bottomConstraint: NSLayoutConstraint!
    
    var loadingView = LoadingView()
    
    let presenter = QuizPresenter()
    let cellIdentifier = "mainCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        hitsTableView.keyboardDismissMode = .onDrag
        scrollView.keyboardDismissMode = .onDrag
        presenter.attachView(vc: self)
        presenter.loadData()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration, animations: {
                self.bottomConstraint.constant += keyboardSize.height
            })
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration, animations: {
                self.bottomConstraint.constant = 0
            })
        }
    }
    
    @objc
    private func textChanged(_ sender: UITextField) {
        guard let insertedText = sender.text?.lowercased() else { return }
        presenter.compareAnswer(insertedText)
    }
    
    @IBAction private func onButtonTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == ButtonState.start.rawValue {
            sender.setTitle(ButtonState.reset.rawValue, for: .normal)
        }
        view.endEditing(true)
        hitsTableView.isHidden = false
        answerTextField.isEnabled = true
        presenter.startGame()
    }
    
    func updateHits(_ hits: String, of: String) {
        answerTextField.text = ""
        hitsLabel.text = "\(hits)/\(of)"
        hitsTableView.reloadData()
    }
    
    func toogleLoading(show: Bool) {
        if show {
            loadingView.tag = 1
            view.addSubview(loadingView)
        } else {
            view.viewWithTag(1)?.removeFromSuperview()
        }
        
    }
    
    func updateTimer(_ time: String) {
        timerLabel.text = time
    }
    
    func showAlert(win: Bool) {
        var title: String = ""
        var message: String = ""
        var buttonTitle: String = ""
        if (win) {
            title = "Congratulations"
            message = "Good job! You found all the answers on time. Keep up with the great work."
            buttonTitle = "Play Again"
        } else {
            title = "Time finished"
            message = "Sorry, time is up! You got \(presenter.hits.count) of \(presenter.quiz?.answer.count ?? 00)"
            buttonTitle = "Try Again"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: { [weak self] _ in
            self?.presenter.startGame()
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error!", message: "Error trying to fetch data from server, please try again later", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
            self?.presenter.loadData()
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func reloadTable() {
        hitsTableView.reloadData()
    }
    
}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: QuizCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? QuizCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        cell.setupCell(hit: presenter.hits[index])
        return cell
    }
    
}

fileprivate enum ButtonState: String {
    case start = "Start"
    case reset = "Reset"
}


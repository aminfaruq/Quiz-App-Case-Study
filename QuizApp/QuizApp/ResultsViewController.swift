//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Amin faruq on 16/02/24.
//

import UIKit

struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    
}

class WrongAnswerCell: UITableViewCell {
    
}

class ResultsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var summary = ""
    private var answers = [PresentableAnswer]()
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        headerLabel.text = summary
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answers = answers[indexPath.row].isCorrect        
        return answers == true ? CorrectAnswerCell() : WrongAnswerCell()
    }

}

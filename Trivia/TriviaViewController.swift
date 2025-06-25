//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Mythily Kalra on 6/24/25.
//

import UIKit

class TriviaViewController: UIViewController {
    @IBOutlet weak var questionnumberLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answeroneButton: UIButton!
    
    @IBOutlet weak var answertwoButton: UIButton!
    
    @IBOutlet weak var answerthreeButton: UIButton!
    
    @IBOutlet weak var answerfourButton: UIButton!
    
    var questions: [TriviaPages] = [] // holds all the trivia questions
    var currentIndex: Int = 0
    var score: Int = 0 //tracks the user's score
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questions = [
            TriviaPages(category: "Entertainment: Artists", questionString: "What was Kendrick Lamar's previous stage name?", answers: ["K.Dot", "Ken Birdworth", "B.Dot", "MC Kenny"], correctAnswer: "K.Dot"),
            TriviaPages(category: "Engertainment: Movies", questionString: "Which movie won the Best Picture Oscar in 2023?", answers: ["Everything Everywhere All at Once", "Top Gun: Maverick", "The Fabelmans", "Avatar: The Way of Water"], correctAnswer: "Everything Everywhere All at Once"),
            TriviaPages(category: "Engertainment: TV", questionString: "In Friends, what is the name of Ross's pet monkey?", answers: ["Marcel", "Marceline", "Marcela", "Marcelino"], correctAnswer: "Marcel")
        ]
        configure()
    }
    private func configure() {
        guard currentIndex < questions.count else {
            showQuizResults()
            return
        }
        let currentQuestion = questions[currentIndex]
        questionnumberLabel.text = "Question: \(currentIndex + 1)/\(questions.count)"
        categoryLabel.text = currentQuestion.category
        questionLabel.text = currentQuestion.questionString
        
        let shuffledAnswers = currentQuestion.answers.shuffled() // Shuffle for variety
                answeroneButton.setTitle(shuffledAnswers[0], for: .normal)
                answertwoButton.setTitle(shuffledAnswers[1], for: .normal)
                answerthreeButton.setTitle(shuffledAnswers[2], for: .normal)
                answerfourButton.setTitle(shuffledAnswers[3], for: .normal)
        
        
    }
    private func checkAnswer(selectedAnswer: String) {
            let currentQuestion = questions[currentIndex]

            if selectedAnswer == currentQuestion.correctAnswer {
                score += 1
                print("Correct!")
            }

            // Move to the next question after a short delay to allow feedback to register
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.currentIndex += 1
                self.configure()
            }
    }
    private func showQuizResults() {
            let alert = UIAlertController(title: "Game Over!",
                                          message: "Final Score: \(score) / \(questions.count)",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Restart", style: .default) { _ in
                // Optional: Reset quiz or navigate back
                self.currentIndex = 0
                self.score = 0
                self.configure() // Restart quiz for example
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
    }
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let answer = sender.titleLabel?.text else { return }
                checkAnswer(selectedAnswer: answer)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

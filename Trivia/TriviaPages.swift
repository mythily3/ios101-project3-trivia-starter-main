//
//  TriviaPages.swift
//  Trivia
//
//  Created by Mythily Kalra on 6/25/25.
//

import Foundation
import UIKit



struct TriviaPages {
    let category: String
    let questionString: String
    let answers: [String]
    let correctAnswer: String
//    private enum CodingKeys: String, CodingKey {
//        case category = "category"
//        case questionString = "question"
//        case answers = "incorrect_answers"
//        case correctAnswer = "correct_answer"
//    }
}
extension TriviaPages: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case category
        case questionString = "question"
        case answers = "incorrect_answers"
        case correctAnswer = "correct_answer"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let rawCategory = try container.decode(String.self, forKey: .category)
        self.category = rawCategory.decoded
        
        let rawQuestion = try container.decode(String.self, forKey: .questionString)
        self.questionString = rawQuestion.decoded
        
        let rawCorrectAnswer = try container.decode(String.self, forKey: .correctAnswer)
        self.correctAnswer = rawCorrectAnswer.decoded
        
        let rawAnswers = try container.decode([String].self, forKey: .answers)
        self.answers = rawAnswers.map { $0.decoded }
    }
}

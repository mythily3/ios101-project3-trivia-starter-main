//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Mythily Kalra on 7/9/25.
//

import Foundation
class TriviaQuestionService {
    static func fetchQuestion (completion: (([TriviaPages]) -> Void)? = nil) {
        let url = URL(string: "https://opentdb.com/api.php?amount=10")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // this closure is fired when the response is received
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            // at this point, `data` contains the data received from the response
            //let question = parse(data: data)
            // this response will be used to change the UI, so it must happen on the main thread
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaResponse.self, from: data)
            DispatchQueue.main.async {
                completion?(response.questions)
            }
        }
        task.resume() // resume the task and fire the request
    }
    private static func parse(data: Data) -> TriviaResponse {
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let results = jsonDictionary["results"] as! [[String: Any]]
        
        var questions: [TriviaPages] = []
        
        for result in results {
            let category = result["category"] as! String
            let question = result["question"] as! String
            let correctAnswer = result["correct_answer"] as! String
            var incorrectAnswers = result["incorrect_answers"] as! [String]
            incorrectAnswers.append(correctAnswer)
            print(incorrectAnswers)
            let triviaQuestion = TriviaPages(
                category: category,
                questionString: question,
                answers: incorrectAnswers,
                correctAnswer: correctAnswer
            )
            
            questions.append(triviaQuestion)
        }
        
        return TriviaResponse(questions: questions)
        
    }
}
    
    
    

//
//  ViewController.swift
//  WZH
//
//  Created by SD on 28/03/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var quizQuestions: [QuizQuestion] = []
    var categoryQuestions: [QuizQuestion] = []
    
    var currentIndex = 0
    var scoreCount = 0
    var getScore = true
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var showAnswer: UIButton!
    @IBOutlet weak var nextQuestion: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerField.delegate = self
        // Do any additional setup after loading the view.
        
        setupQuiz()
    }
    
    func setupQuiz() {
        getLocalQuizData()
    }
    
    
    @IBAction func buttonOne(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .red}
        questionLabel.text = categoryQuestions[currentIndex].question
    }
    
    @IBAction func buttonTwo(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .green}
        questionLabel.text = categoryQuestions[currentIndex].question
    }
    
    @IBAction func buttonThree(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .blue}
        questionLabel.text = categoryQuestions[currentIndex].question
    }
    
    @IBAction func buttonFour(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .yellow}
        questionLabel.text = categoryQuestions[currentIndex].question
    }
    
    @IBAction func buttonFive(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .orange}
        questionLabel.text = categoryQuestions[currentIndex].question
    }

    @IBAction func showAnswer(_ sender: Any) {
        currentIndex += 0
        answerLabel.text = categoryQuestions[currentIndex].answer
        answerLabel.isHidden = false
        answerField.isHidden = true
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        currentIndex += 1
        questionLabel.text = categoryQuestions[currentIndex].question
        answerLabel.isHidden = true
        answerField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerLabel.isHidden = false
        let answer = answerField.text
        if answer?.lowercased() == categoryQuestions[currentIndex].answer{
            answerLabel.text = "✅"
            if getScore == true{
                scoreCount = scoreCount + 1
                getScore = false
            }
            scoreLabel.text = "Score: \(scoreCount)"
        }
        else{
            answerLabel.text = "❌"
        }
        return true;
    }

    @IBAction func backButton(_ sender: Any) {
        currentIndex = 0
        showButtons()
        answerField.text = ""
        scoreCount = 0
        scoreLabel.text = "Score: "
        getScore = true
    }
    
    func hideButtons(){
        redButton.isHidden = true
        greenButton.isHidden = true
        blueButton.isHidden = true
        yellowButton.isHidden = true
        orangeButton.isHidden = true
        backButton.isHidden = false
        
        questionLabel.isHidden = false
        answerField.isHidden = false
        showAnswer.isHidden = false
        nextQuestion.isHidden = false
        scoreLabel.isHidden = false
    }
    
    func showButtons(){
        redButton.isHidden = false
        greenButton.isHidden = false
        blueButton.isHidden = false
        yellowButton.isHidden = false
        orangeButton.isHidden = false
        backButton.isHidden = true
        
        questionLabel.isHidden = true
        answerLabel.isHidden = true
        answerField.isHidden = true
        showAnswer.isHidden = true
        nextQuestion.isHidden = true
        scoreLabel.isHidden = true
    }
    
    func getLocalQuizData() {
        // Call readLocalFile function with the name of the local file (localQuizData)
        if let localData = self.readLocalFile(forName: "localQuizData") {
            // File exists, now parse 'localData' with the parse function
            self.parse(jsonData: localData)
        }
        
    }

    // Read local file

    private func readLocalFile(forName name: String) -> Data? {
        do {
            // Check if file exists in application bundle, then try to convert it to a string, if that works return that
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error) // Something went wrong, show an alert
        }
        
        return nil
    }

    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([QuizQuestion].self,
                                                       from: jsonData)
            /*
            print("Question: ", decodedData[0].question)
            print("Answer: ", decodedData[0].answer)
            print("===================================")
            */
            
            self.quizQuestions = decodedData
            print ("quizQuestions = \(quizQuestions)")
            
        } catch {
            print("decode error")
        }
    }
    
    
    
    
}


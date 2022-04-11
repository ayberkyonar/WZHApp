//
//  ViewController.swift
//  WZH
//
//  Created by SD on 28/03/2022.
//

import UIKit

class ViewController: UIViewController {

    var quizQuestions: [QuizQuestion] = []
    var categoryQuestions: [QuizQuestion] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupQuiz()
    }
    
    func setupQuiz() {
        getLocalQuizData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        showButtons()
    }
    
    @IBAction func buttonOne(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .red}
        questionLabel.text = categoryQuestions[0].question
        
    }
    
    @IBAction func buttonTwo(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .green}
        questionLabel.text = categoryQuestions[1].question
    }
    
    @IBAction func buttonThree(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .blue}
        questionLabel.text = categoryQuestions[2].question
    }
    
    @IBAction func buttonFour(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .yellow}
        questionLabel.text = categoryQuestions[3].question
    }
    
    @IBAction func buttonFive(_ sender: Any) {
        hideButtons()
        categoryQuestions = quizQuestions.filter{$0.category == .orange}
        questionLabel.text = categoryQuestions[4].question
    }
    
    func hideButtons(){
        redButton.isHidden = true
        greenButton.isHidden = true
        blueButton.isHidden = true
        yellowButton.isHidden = true
        orangeButton.isHidden = true
        backButton.isHidden = false
        
        questionLabel.isHidden = false
        answerLabel.isHidden = false
        answerField.isHidden = false
        showAnswer.isHidden = false
        nextQuestion.isHidden = false
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


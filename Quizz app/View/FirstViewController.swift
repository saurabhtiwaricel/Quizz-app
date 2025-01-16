import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var optionButton3: UIButton!
    @IBOutlet weak var optionButton4: UIButton!
    
    var questions = DataLoader().userData
    var currentQuestionIndex = 0
    var selectedAnswers: [(question: String, correct: String, selected: String)] = []
    var score = 0
    var questionNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUIElement(questionLabel)
           styleUIElement(optionButton1)
           styleUIElement(optionButton2)
           styleUIElement(optionButton3)
           styleUIElement(optionButton4)
        loadQuestion()
        questionNumber = 1
    }
    
   
    
    func loadQuestion() {
        guard currentQuestionIndex < questions.count else { return }
        
       
        let currentQuestion = questions[currentQuestionIndex]
        
        // Calculate the question number based on the currentQuestionIndex
        questionNumber = currentQuestionIndex + 1
        questionLabel.text = "Q \(questionNumber): \(currentQuestion.question)"
        
        var numbers = Array(0...3)
        numbers.shuffle()
//        print(numbers)
      
        optionButton1.setTitle(currentQuestion.options[numbers[0]], for: .normal)
        optionButton2.setTitle(currentQuestion.options[numbers[1]], for: .normal)
        optionButton3.setTitle(currentQuestion.options[numbers[2]], for: .normal)
        optionButton4.setTitle(currentQuestion.options[numbers[3]], for: .normal)

     
    }

    func styleUIElement(_ element: UIView) {
            element.layer.cornerRadius = 10
            element.layer.masksToBounds = true
            element.layer.borderWidth = 1.0
            element.layer.borderColor = UIColor.lightGray.cgColor
        }
    
    @IBAction func optionSelected(_ sender: UIButton) {
        guard let selectedAnswer = sender.title(for: .normal) else { return }
        
        let currentQuestion = questions[currentQuestionIndex]
        let isCorrect = selectedAnswer == currentQuestion.answer
        
        if isCorrect { score += 1 }
        
        selectedAnswers.append((question: currentQuestion.question,
                                correct: currentQuestion.answer,
                                selected: selectedAnswer))
        
        currentQuestionIndex += 1

        
        if currentQuestionIndex < questions.count {
            loadQuestion()
        } else {
            performSegue(withIdentifier: "showResults", sender: nil)
            currentQuestionIndex = 0
//            selectedAnswers.removeAll()
//            score = 0
         
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults",
           let secondVC = segue.destination as? SecondViewController {
            secondVC.score = score
            secondVC.answers = selectedAnswers
            
        }
    }
}

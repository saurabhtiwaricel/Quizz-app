import UIKit
class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var scerelbl: UILabel!
    var score = 0
    var answers: [(question: String, correct: String, selected: String)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        scerelbl.text = "Score: \(score)/\(answers.count)"
//        print("Final Score: \(score)")
        self.navigationController?.isNavigationBarHidden = true
        styleUIElement(restartButton)
    }
    
    @IBAction func restartQuiz(_ sender: UIButton) {
                score = 0
                answers.removeAll()
                
                // Navigate back to the first view controller and reset it
                if let firstVC = navigationController?.viewControllers.first as? FirstViewController {
                    firstVC.currentQuestionIndex = 0 // Reset question index
                    firstVC.selectedAnswers.removeAll() // Reset answers
                    firstVC.score = 0 // Reset score
                
                }
                
                // Reload the table view and update UI
                tableView.reloadData()
                
                // Navigate to the first view controller
                navigationController?.popToRootViewController(animated: true)
        
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return answers.count
     
        
    }
    func styleUIElement(_ element: UIView) {
            element.layer.cornerRadius = 10
            element.layer.masksToBounds = true
            element.layer.borderWidth = 1.0
            element.layer.borderColor = UIColor.lightGray.cgColor
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        let answer = answers[indexPath.row]
        let questionNumber = indexPath.row + 1
        cell.textLabel?.text = "Q \(questionNumber): \(answer.question)"
      
        if (answer.correct) != (answer.selected) {
            cell.detailTextLabel?.text = "Correct: \(answer.correct) \n Selected: \(answer.selected)"
            cell.detailTextLabel?.textColor = UIColor.red
        }else{
            cell.detailTextLabel?.text = "Answer: \(answer.correct)"
            cell.detailTextLabel?.textColor = UIColor.green
        }
        cell.contentView.layer.cornerRadius = 10 // Adjust as needed
           cell.contentView.layer.masksToBounds = true
           cell.contentView.layer.borderWidth = 1.0 // Optional
           cell.contentView.layer.borderColor = UIColor.lightGray.cgColor // Optional
        return cell
    }
}

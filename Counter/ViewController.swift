import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak private var informationField: UITextView!
    @IBOutlet weak private var counterLabel: UILabel!
    
    private var counter = 0
    private let counterStep = 1
    private let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd.MM HH:mm:ss"
        informationField.text = "История изменений:\n"
        scrollInformationField()
    }
    
    private func scrollInformationField() {
        informationField.setContentOffset(
            CGPoint(x: 0, y: informationField.contentSize.height - informationField.bounds.height),
            animated: false
        )
    }
    
    private func updateCounterLabel(_ value: Int) {
        if value >= 0 {
            counterLabel.text = String(value)
        }
    }

    private func addMessageToInformationField(
        _ valueSing: String,
        _ isReset: Bool = false
    ) {
        var submessage: String = ""
        
        if counter >= 0 {
            submessage = "значение изменено на " + valueSing + String(counterStep)
        }
        if counter < 0 {
            submessage = "попытка уменьшить значение счётчика ниже 0"
        }
        if isReset {
            submessage = "значение сброшено"
        }
        
        informationField.text?.append("[" + dateFormatter.string(from: Date()) + "]:" + submessage + "\n")
        
        scrollInformationField()
    }
    
    @IBAction private func resetCounter() {
        counter = 0
        updateCounterLabel(counter)
        addMessageToInformationField("", true)
    }
    
    @IBAction private func decreaseCounter() {
        counter -= counterStep
        updateCounterLabel(counter)
        addMessageToInformationField("-")
        
        if counter < 0 {
            counter = 0
        }
    }
    
    @IBAction private func increaseCounter() {
        counter += counterStep
        updateCounterLabel(counter)
        addMessageToInformationField("+")
    }
}

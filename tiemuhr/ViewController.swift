import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var counterLabel: UILabel
    @IBOutlet var descriptionLabel: UILabel
    
    var currentCounter = -1

    var timer = IGTimer(clock: IGClock())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCounter()
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        currentCounter++
        updateCounter()
    }
    
    func updateCounter() {
        timer.increment()
        if(timer.lastRoundMessage != "") {
            descriptionLabel.text = timer.lastRoundMessage
        }
        counterLabel.text = String(currentCounter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var counterLabel: UILabel
    var currentCounter = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCounter()
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        currentCounter++
        updateCounter()
    }
    
    func updateCounter() {
        counterLabel.text = String(currentCounter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    
    let RED = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    let WHITE = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var currentCounter = -1

    var nsTimer: NSTimer?
    let timer = IGTimer(clock: IGClock())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCounter()
        var interval = NSTimeInterval(1)
        nsTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "updateRound:", userInfo: nil, repeats: true)
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        currentCounter++
        updateCounter()
        counterLabel.textColor = WHITE
    }

    
    func updateCounter() {
        timer.increment()
        if(timer.lastRoundMessage != "") {
            var interval = NSTimeInterval(timer.average)

            descriptionLabel.text = timer.lastRoundMessage
            averageLabel.text = timer.getAverage()
        }
        counterLabel.text = String(currentCounter)
    }
    
    
    func updateRound(nsTimer: NSTimer) {
        if (timer.lastRoundMessage == "") { return }
        var elapsed = timer.timeElapsed()

        println("elapsed: \(elapsed) | \(timer.average)")
        if (elapsed > timer.average) {
            counterLabel.textColor = RED
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


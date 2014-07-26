import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!

    let RED = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    let WHITE = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    let PI = 3.1415926535897932384626433832795028841

    var currentCounter = -1

    var nsTimer: NSTimer?
    let timer = IGTimer(clock: IGClock())
    var circleView: CircleView?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCounter()
        var interval = NSTimeInterval(0.001)
        nsTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "updateRound:", userInfo: nil, repeats: true)
    }

    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        currentCounter++
        updateCounter()
        counterLabel.textColor = WHITE
    }

    func updateCounter() {
        timer.increment()
        if(timer.averageAvailable()) {
            descriptionLabel.text = timer.lastRoundMessage
            averageLabel.text = timer.getAverage()
        }
        counterLabel.text = String(currentCounter)
    }


    func showCircle(percent: Float) {
        var frame = CGRectMake(view.frame.width/2-150, counterLabel.frame.origin.y-75, 300, 300)
        circleView = CircleView(frame: frame, percent: percent)
        view.insertSubview(circleView, belowSubview: counterLabel)
    }
    
    func updateRound(nsTimer: NSTimer) {
        if (!timer.averageAvailable()) { return }
        
        var elapsed = timer.timeElapsed()
        showCircle(Float(Float(elapsed)/Float(timer.average)))

        println("--- timer elapsed: \(elapsed) < \(timer.average)")

        if (elapsed > timer.average) {
            counterLabel.textColor = RED
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


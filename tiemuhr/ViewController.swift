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
    var progressView: IGProgessView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCounter()
        var interval = NSTimeInterval(1)
        nsTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "updateRound:", userInfo: nil, repeats: true)
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        currentCounter++
        updateCounter()
        addProgessBar()
        counterLabel.textColor = WHITE
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func addProgessBar() {
        view.becomeFirstResponder()

        if(!timer.averageAvailable()) { return }
        progressView?.removeFromSuperview()
        
        var rect = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 1)
        progressView = IGProgessView(frame: rect)
        view.addSubview(progressView!)
        view.sendSubviewToBack(progressView!)

        var theProgressView = (progressView!)
        var interval = NSTimeInterval(timer.average)

        UIView.animateWithDuration(interval, delay: 0,
            options: .AllowUserInteraction, animations: {
            theProgressView.frame.size.height = self.view.frame.height
            }, completion:  {
                (value: Bool) in
                theProgressView.backgroundColor = UIColor.redColor()
        })
    }
    
    func updateCounter() {
        timer.increment()
        if(timer.averageAvailable()) {
            var interval = NSTimeInterval(timer.average)

            descriptionLabel.text = timer.lastRoundMessage
            averageLabel.text = timer.getAverage()
        }
        counterLabel.text = String(currentCounter)
    }
    
    func updateRound(nsTimer: NSTimer) {
        if (!timer.averageAvailable()) { return }
        var elapsed = timer.timeElapsed()

        println("--- timer elapsed: \(elapsed) < \(timer.average)")
        
        if (elapsed > timer.average) {
            println("You are late!")
        }
    }
}


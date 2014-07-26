
import UIKit

class CircleView: UIView {
    let PI_2 = 6.2831853071
    var _percent = Float(0.0)
    
    var percent: Float {
        get {
            return _percent;
        }
        set(newPercent) {
            if(_percent == newPercent) { return }
            _percent = newPercent
            setNeedsDisplay()
        }
    }
    
    init(frame: CGRect, percent: Float) {
        super.init(frame: frame)
        self.percent = percent
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(context, 0.1, 0.5, 0.1, 0.5)
        CGContextBeginPath(context)
        
        CGContextMoveToPoint(context, 150, 150)
        CGContextAddArc(context, 150, 150, 120, 0, CGFloat(6.2831853071 * percent), 0)
        
        CGContextClosePath(context)
        CGContextFillPath(context)
    }
    
    func drawOver(interval: NSTimeInterval) {
        UIView.setAnimationDelay(interval)
        
        UIView.commitAnimations()
    }
}

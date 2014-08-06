import Foundation
import UIKit

class IGProgessView: UIView {
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect)  {
        super.init(frame: frame)
        backgroundColor = UIColor.greenColor()

    }
    
    override func drawRect(rect: CGRect) {
        println("yeah")
    }

 }

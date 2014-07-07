import UIKit
import QuartzCore

extension CGRect {
    var center : CGPoint {
    return CGPointMake(CGRectGetMidX(self), CGRectGetMidY(self))
    }
}
func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

class ViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainview = self.view
        
        let iv = UIImageView(image:UIImage(named:"Mars")) // asset catalog
        mainview.addSubview(iv)
        
        iv.clipsToBounds = true // default is false...
        // though this won't matter unless you also play with the content mode
        iv.contentMode = .ScaleAspectFit // default is .ScaleToFill...
        // ... which fits but doesn't preserve aspect
        
//        println(iv.clipsToBounds)
//        println(iv.contentMode.toRaw())
        
        // just to clarify boundaries of image view
        iv.layer.borderColor = UIColor.blackColor().CGColor
        iv.layer.borderWidth = 2
        
        let which = 1
        switch which {
        case 1:
            // position using autoresizing-type behavior
            iv.center = iv.superview.bounds.center // useful utility extension to CGRect, see above
            iv.frame = CGRectIntegral(iv.frame)
        case 2:
            // position using constraints
            iv.setTranslatesAutoresizingMaskIntoConstraints(false)
            iv.superview.addConstraint(
                NSLayoutConstraint(item: iv,
                    attribute: .CenterX,
                    relatedBy: .Equal,
                    toItem: iv.superview,
                    attribute: .CenterX,
                    multiplier: 1, constant: 0)
            )
            iv.superview.addConstraint(
                NSLayoutConstraint(item: iv,
                    attribute: .CenterY,
                    relatedBy: .Equal,
                    toItem: iv.superview,
                    attribute: .CenterY,
                    multiplier: 1, constant: 0)
            )
        default: break
        }
        
        // showing what happens when a different image is assigned
        delay (2) {
            iv.image = UIImage(named:"bottle5.png")
            // if we're using constraints...
            // the image view is resized setting the image changes the intrinsic content size
        }
        
    }
    
    
    
}
import UIKit

public extension UIView {
    public var leftConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .left)
    }

    public var rightConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .right)
    }

    public var topConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .top)
    }

    public var bottomConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .bottom)
    }

    public var heightConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .height)
    }

    public var widthConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .width)
    }

    public var trailingConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .trailing)
    }

    public var leadingConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .leading)
    }

    public var centerXConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .centerX)
    }

    public var centerYConstraint: NSLayoutConstraint? {
        return constraintForView(self, attribute: .centerY)
    }
}

func constraintForView(_ v: UIView, attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {

    func lookForConstraint(in view: UIView?) -> NSLayoutConstraint? {
        guard let constraints = view?.constraints else {
            return nil
        }
        for c in constraints {
            if let fi = c.firstItem as? NSObject, fi == v && c.firstAttribute == attribute {
                return c
            } else if let si = c.secondItem as? NSObject, si == v && c.secondAttribute == attribute {
                return c
            }
        }
        return nil
    }

    return lookForConstraint(in: v.superview) ?? lookForConstraint(in: v)
}

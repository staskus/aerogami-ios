import UIKit

extension UIViewController {
    @objc func injected() {

        viewWillDisappear(true)
        viewWillAppear(true)

        view.subviews
            .forEach { $0.removeFromSuperview() }

        NSLayoutConstraint.deactivate(view.constraints)

        viewDidLoad()
        viewWillAppear(true)
        viewDidAppear(true)
    }
}

import UIKit

extension UIView {
    var horizontalScale: CGFloat {
        return pow(
            pow(transform.a, 2) + pow(transform.c, 2),
            0.5
        )
    }

    var verticalScale: CGFloat {
        return pow(
            pow(transform.b, 2) + pow(transform.d, 2),
            0.5
        )
    }
}

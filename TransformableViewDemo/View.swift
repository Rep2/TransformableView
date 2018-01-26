import UIKit
import TransformableView
import RxSwift

class View: UIView, TransformableView {
    var minX: CGFloat? = 10
    var maxX: CGFloat? = 200
    var minY: CGFloat? = 10
    var maxY: CGFloat? = 400

    var minScale: CGFloat? = 0.5
    var maxScale: CGFloat?

    let disposeBag = DisposeBag()

    var scale: CGFloat = 1
    var borderType = BorderType.border(width: 10, color: .black)

    override init(frame: CGRect) {
        super.init(frame: frame)

        addGesturesHandling()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        addGesturesHandling()
    }

    func didUpdate(frame: CGRect) {
    }

    func didUpdate(rotation: CGFloat) {
    }
}

import UIKit
import TransformableView
import RxSwift

class View: UIView, TransformableView {
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

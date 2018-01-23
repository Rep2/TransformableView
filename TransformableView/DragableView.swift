import UIKit
import RxGesture
import RxSwift

public protocol DraggableView {
    var disposeBag: DisposeBag { get }

    func addDragGestrueHandling()
    func didUpdate(frame: CGRect)
}

extension DraggableView where Self: UIView {
    public func addDragGestrueHandling() {
        layer.borderColor = UIColor.black.cgColor

        rx
            .panGesture()
            .subscribe(
                onNext: { [weak self] panGestureRecognizer in
                    guard let strongSelf = self else { return }

                    switch panGestureRecognizer.state {
                    case .began:
                        strongSelf.layer.borderWidth = 10
                    case .changed:
                        let translation = panGestureRecognizer.translation(in: strongSelf.superview)

                        strongSelf.transform = strongSelf
                            .transform
                            .concatenating(CGAffineTransform(translationX: translation.x, y: translation.y))

                        panGestureRecognizer.setTranslation(.zero, in: strongSelf.superview)
                    case .ended:
                        strongSelf.didUpdate(frame: strongSelf.frame)
                        strongSelf.layer.borderWidth = 0
                    default:
                        break
                    }
            }
        ).disposed(by: disposeBag)
    }
}

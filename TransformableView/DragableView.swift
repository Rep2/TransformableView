import UIKit
import RxGesture
import RxSwift

public protocol DragableView {
    var disposeBag: DisposeBag { get }

    func addDragGestrueHandling()
    func didUpdate(frame: CGRect)
}

extension DragableView where Self: UIView {
    func addDragGestrueHandling() {
        rx
            .panGesture()
            .subscribe(
                onNext: { [weak self] panGestureRecognizer in
                    guard let strongSelf = self else { return }

                    switch panGestureRecognizer.state {
                    case .changed:
                        let translation = panGestureRecognizer.translation(in: strongSelf.superview)

                        strongSelf.transform = strongSelf
                            .transform
                            .concatenating(CGAffineTransform(translationX: translation.x, y: translation.y))

                        panGestureRecognizer.setTranslation(.zero, in: strongSelf.superview)
                    case .ended:
                        strongSelf.didUpdate(frame: strongSelf.frame)
                    default:
                        break
                    }
            }
        ).disposed(by: disposeBag)
    }
}

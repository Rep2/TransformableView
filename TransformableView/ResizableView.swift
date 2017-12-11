import UIKit
import RxGesture
import RxSwift

public protocol ResizableView {
    var disposeBag: DisposeBag { get }
    var scale: CGFloat { get set }

    func addScaleGestrueHandling()
    func didUpdate(frame: CGRect)
}

extension ResizableView where Self: UIView {
    public func addScaleGestrueHandling() {
        rx
            .pinchGesture(
                configuration: { _, delegate in
                    delegate.simultaneousRecognitionPolicy = .never
            }
            ).subscribe(
                onNext: { [weak self] pinchGestureRecognizer in
                    guard var strongSelf = self else { return }

                    switch pinchGestureRecognizer.state {
                    case .changed:
                        let scale = pinchGestureRecognizer.scale / strongSelf.scale

                        strongSelf.transform = strongSelf
                            .transform
                            .scaledBy(x: scale, y: scale)

                        strongSelf.scale = pinchGestureRecognizer.scale
                    case .ended:
                        strongSelf.scale = 1

                        strongSelf.didUpdate(frame: strongSelf.frame)
                    default:
                        break
                    }
            }
        ).disposed(by: disposeBag)
    }
}

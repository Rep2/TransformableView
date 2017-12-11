import UIKit
import RxGesture
import RxSwift

public protocol RotateableView {
    var disposeBag: DisposeBag { get }

    func addRotateGestrueHandling()
    func didUpdate(rotation: CGFloat)
}

extension RotateableView where Self: UIView {
    func addRotateGestrueHandling() {
        rx
            .rotationGesture(
                configuration: { _, delegate in
                    delegate.simultaneousRecognitionPolicy = .never
                }
            ).subscribe(
                onNext: { [weak self] rotationGestureRecognizer in
                    guard let strongSelf = self else { return }

                    switch rotationGestureRecognizer.state {
                    case .changed:
                        let x = strongSelf.layer.bounds.minX
                        let y = strongSelf.layer.bounds.minY

                        strongSelf.transform = strongSelf
                            .transform
                            .translatedBy(x: x, y: y)
                            .rotated(by: rotationGestureRecognizer.rotation)
                            .translatedBy(x: -x, y: -y)

                        rotationGestureRecognizer.rotation = 0
                    case .ended:
                        strongSelf.didUpdate(rotation: rotationGestureRecognizer.rotation)
                    default:
                        break
                    }
                }
            ).disposed(by: disposeBag)
    }
}

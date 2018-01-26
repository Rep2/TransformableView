import UIKit
import RxGesture
import RxSwift

public protocol RotatableView {
    var disposeBag: DisposeBag { get }
    var

    func addRotateGestrueHandling()
    func didUpdate(rotation: CGFloat)
}

extension RotatableView where Self: UIView {
    public func addRotateGestrueHandling(displayBorder: Bool = false, borderWidth: Float = 10, borderColor: UIColor = .black) {
        layer.borderColor = borderColor.cgColor

        rx
            .rotationGesture(
                configuration: { _, delegate in
                    delegate.simultaneousRecognitionPolicy = .never
                }
            ).subscribe(
                onNext: { [weak self] rotationGestureRecognizer in
                    guard let strongSelf = self else { return }

                    switch rotationGestureRecognizer.state {
                    case .began:
                        strongSelf.layer.borderWidth = displayBorder ? borderWidth : 0
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
                        strongSelf.layer.borderWidth = 0

                        strongSelf.didUpdate(
                            rotation: atan2(strongSelf.transform.b, strongSelf.transform.a)
                        )
                    default:
                        break
                    }
                }
            ).disposed(by: disposeBag)
    }
}

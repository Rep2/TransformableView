import UIKit
import RxGesture
import RxSwift

public protocol ResizableView {
    var disposeBag: DisposeBag { get }
    var scale: CGFloat { get set }
    var borderType: BorderType { get }

    var minScale: CGFloat? { get }
    var maxScale: CGFloat? { get }

    func addScaleGestrueHandling()

    func updateDidBegin()
    func didUpdate(frame: CGRect)
}

extension ResizableView where Self: UIView {
    public func addScaleGestrueHandling() {
        layer.borderColor = borderType.borderColor?.cgColor

        rx
            .pinchGesture()
            .subscribe(
                onNext: { [weak self] pinchGestureRecognizer in
                    guard var strongSelf = self else { return }

                    switch pinchGestureRecognizer.state {
                    case .began:
                        strongSelf.layer.borderWidth = strongSelf.borderType.borderWidth

                        strongSelf.updateDidBegin()
                    case .changed:
                        var scale = pinchGestureRecognizer.scale / strongSelf.scale

                        let newScale = scale * strongSelf.verticalScale

                        if let minScale = strongSelf.minScale, newScale < minScale {
                            scale = minScale / strongSelf.verticalScale
                        } else if let maxScale = strongSelf.maxScale, newScale > maxScale {
                            scale = maxScale / strongSelf.verticalScale
                        }

                        strongSelf.transform = strongSelf
                            .transform
                            .scaledBy(x: scale, y: scale)

                        strongSelf.scale = pinchGestureRecognizer.scale
                    case .ended:
                        strongSelf.scale = 1
                        strongSelf.layer.borderWidth = 0

                        strongSelf.didUpdate(frame: strongSelf.frame)
                    default:
                        break
                    }
            }
        ).disposed(by: disposeBag)
    }
}

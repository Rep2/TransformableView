import UIKit
import RxGesture
import RxSwift

public protocol DraggableView {
    var disposeBag: DisposeBag { get }
    var borderType: BorderType { get }

    var minX: CGFloat? { get }
    var maxX: CGFloat? { get }
    var minY: CGFloat? { get }
    var maxY: CGFloat? { get }

    func addDragGestrueHandling()
    func didUpdate(frame: CGRect)
}

extension DraggableView where Self: UIView {
    public func addDragGestrueHandling() {
        layer.borderColor = borderType.borderColor?.cgColor

        rx
            .panGesture()
            .subscribe(
                onNext: { [weak self] panGestureRecognizer in
                    guard let strongSelf = self else { return }

                    switch panGestureRecognizer.state {
                    case .began:
                        strongSelf.layer.borderWidth = strongSelf.borderType.borderWidth
                    case .changed:
                        var translation = panGestureRecognizer.translation(in: strongSelf.superview)

                        if let minX = strongSelf.minX, strongSelf.frame.origin.x + translation.x < minX {
                            translation.x = minX - strongSelf.frame.origin.x
                        } else if let maxX = strongSelf.maxX, strongSelf.frame.origin.x + translation.x > maxX {
                            translation.x = maxX - strongSelf.frame.origin.x
                        }

                        if let minY = strongSelf.minY, strongSelf.frame.origin.y + translation.y < minY {
                            translation.y = minY - strongSelf.frame.origin.y
                        } else if let maxY = strongSelf.maxY, strongSelf.frame.origin.y + translation.y > maxY {
                            translation.y = maxY - strongSelf.frame.origin.y
                        }

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

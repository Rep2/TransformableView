# TransformableView

Draggable, resizable and rotatable UIView implemented using protocols in Swift. Uses RxCocoa, RxGesture and RxSwift to avoid protocol extension restrictions.

## Usage

`TransformableView` is a composition of `DraggableView`, `ResizableView` and `RotatableView`. Implement desired protocol as needed.

```Swift
class View: UIView, TransformableView {}

class NonRotatableView: UIView, DraggableView, ResizableView {}
```

Protocols require `var disposeBag: DisposeBag { get }` and include optional `func didUpdate(frame: CGRect)` and `func didUpdate(rotation: CGFloat)` methods.

Finnaly, add gesture handling 

```Swift
view.addGesturesHandling()
```

## Example

Demo is included in the project.

![Demo](https://github.com/Rep2/TransformableView/blob/master/demo.gif)

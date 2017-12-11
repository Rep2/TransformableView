public protocol TransformableView: DraggableView, ResizableView, RotatableView {}

extension TransformableView {
    public func addGesturesHandling() {
        addDragGestrueHandling()
        addScaleGestrueHandling()
        addRotateGestrueHandling()
    }
}

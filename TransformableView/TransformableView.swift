public protocol TransformableView: DraggableView, ResizableView, RotatableView {
    func addGesturesHandling()
}

extension TransformableView {
    public func addGesturesHandling() {
        addDragGestrueHandling()
        addScaleGestrueHandling()
        addRotateGestrueHandling()
    }
}

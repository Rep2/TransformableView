public protocol TransformableView: DragableView, ResizableView, RotateableView {
    func addGesturesHandling()
}

extension TransformableView {
    public func addGesturesHandling() {
        addDragGestrueHandling()
        addScaleGestrueHandling()
        addRotateGestrueHandling()
    }
}

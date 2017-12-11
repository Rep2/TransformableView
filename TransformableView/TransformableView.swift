public protocol TransformableView: DragableView, ResizableView, RotateableView {
    func addGesturesHandling()
}

extension TransformableView {
    func addGesturesHandling() {
        addDragGestrueHandling()
        addScaleGestrueHandling()
        addRotateGestrueHandling()
    }
}

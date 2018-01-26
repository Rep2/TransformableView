public protocol TransformableView: DraggableView, ResizableView, RotatableView {
    func addGesturesHandling()
}

extension TransformableView {
    public func addGesturesHandling(displayBorder: Bool = false, borderWidth: Float = 10, borderColor: UIColor = .black) {
        addDragGestrueHandling(displayBorder: displayBorder, borderWidth: borderWidth, borderColor: borderColor)
        addScaleGestrueHandling(displayBorder: displayBorder, borderWidth: borderWidth, borderColor: borderColor)
        addRotateGestrueHandling(displayBorder: displayBorder, borderWidth: borderWidth, borderColor: borderColor)
    }
}

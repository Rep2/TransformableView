public enum BorderType {
    case none
    case border(width: CGFloat, color: UIColor)

    var borderColor: UIColor? {
        switch self {
        case .none:
            return nil
        case .border(_, let color):
            return color
        }
    }

    var borderWidth: CGFloat {
        switch self {
        case .none:
            return 0
        case .border(let width, _):
            return width
        }
    }
}

import UIKit

class ViewController: UIViewController {
    lazy var transformableView: View = {
        let view = View(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

        view.backgroundColor = .blue
        view.isUserInteractionEnabled = true

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(transformableView)
    }
}

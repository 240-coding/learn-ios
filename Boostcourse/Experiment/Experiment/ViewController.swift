
import UIKit


let reuseIdentifier = "CellIdentifer";


class ViewController: UIViewController {

    @IBOutlet var btn: UIButton!
    @IBAction func pressUpButton(_ sender: Any) {
        guard let url = URL(string: "https://www.google.com") else {
            return
        }
        let shareSheetVc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.present(shareSheetVc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let navigationBar = navigationController?.navigationBar
        let statusBarStyle = navigationBar?.barStyle
        // statusBarStyle is .black or .default
//        if case .black = statusBarStyle {
//             navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
//        } else {
//            navigationController?.navigationBar.overrideUserInterfaceStyle = .light
//        }
//        navigationController?.navigationBar.barStyle = statusBarStyle!
//        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    


}

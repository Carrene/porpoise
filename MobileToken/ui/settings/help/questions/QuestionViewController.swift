import UIKit
import WebKit

class QuestionViewController: BaseViewController {
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "answer", withExtension: "html")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func initUIComponents() {
        
    }
    
    func initListeners() {
        
    }
    

}

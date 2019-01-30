import UIKit
import WebKit

class QuestionViewController: BaseViewController {
    
    @IBOutlet var webView: WKWebView!
    private var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "answer", withExtension: "html")
        let request = URLRequest(url: url!)
        webView.load(request)
        //webView.evaluateJavaScript("window.location.hash='q5'")


    }
    
    
    func setIndex(index:Int) {
        self.index = index
    }
    
    func initUIComponents() {
        
    }
    
    func initListeners() {
        
    }
    
    
    
    

}

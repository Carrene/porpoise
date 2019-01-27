import UIKit
import WebKit

class QuestionViewController: BaseViewController {
    
    @IBOutlet var webView: WKWebView!
    private var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = Bundle.main.url(forResource: "answer", withExtension: "html")
        let components = NSURLComponents(string: "#q5")
        //url?.appendPathComponent(components)
        //url = url?.appendingPathComponent("#"+"q5", isDirectory: true)
        print(url!)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func setIndex(index:Int) {
        self.index = index
    }
    
    func initUIComponents() {
        
    }
    
    func initListeners() {
        
    }
    

}

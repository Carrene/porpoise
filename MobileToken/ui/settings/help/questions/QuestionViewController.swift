import UIKit
import WebKit

class QuestionViewController: BaseViewController,WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        view.addSubview(webView)
        var url: URL?
        if Locale.preferredLanguages[0] == "ar" {
            url = Bundle.main.url(forResource: "answer-ar", withExtension: "html")
        }else {
            url = Bundle.main.url(forResource: "answer-en", withExtension: "html")
        }
        let request = URLRequest(url: url!)
        webView.backgroundColor = R.color.primary()
        webView.tintColor = R.color.primary()
        webView.load(request)
        webView.navigationDelegate = self

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("scrollToId('q\(index)')")
    }
    
    
    func setIndex(index:Int) {
        self.index = index
    }
    
    func initUIComponents() {
        
    }
    
    func initListeners() {
        
    }
    
}

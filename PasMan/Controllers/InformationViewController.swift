import UIKit
import WebKit

class InformationViewController: UIViewController {
    
    var webView: WKWebView!
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.color = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        indicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.webView.addSubview(indicator)
        return indicator
    }()
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let url = URL(string: "https://github.com/TheDanz/PasMan")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        setupActivityIndicatorViewConstraints()
    }
    
    func setupActivityIndicatorViewConstraints() {
        activityIndicatorView.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true
    }
}

extension InformationViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicatorView.stopAnimating()
    }
}

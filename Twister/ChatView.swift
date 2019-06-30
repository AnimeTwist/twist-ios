//
//  ChatView.swift
//  Twister
//
//  Created by Thoralf Thelle on 17/06/2019.
//  Copyright © 2019 twist. All rights reserved.
//

//
//  ViewController.swift
//  Twister
//
//  Created by Thoralf Thelle on 17/06/2019.
//  Copyright © 2019 twist. All rights reserved.
//

import UIKit
import WebKit

// Chat VC
class ChatView: UIViewController, WKUIDelegate {
    
    let TWIST_CHAT_URL: String = "https://twist.moe/chat"
    var webView: WKWebView!
    
    func setNavigationBar ()
    {
        let navBar = self.navigationController?.navigationBar
        //let rightItem = UIBarButtonItem(title: "Login", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        self.navigationItem.title = "Chat"
        //self.navigationItem.rightBarButtonItem = rightItem
        navBar?.barStyle = UIBarStyle.blackTranslucent
        navBar?.backgroundColor = nil
        navBar?.tintColor = .white
    }
    
    // Yes, this is lazy but fuck reimplementing the chat in Swift
    func setupChatWebView ()
    {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
                    webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                    webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                    webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
    
    override func loadView() {
        super.loadView()
        
        setNavigationBar()
        setupChatWebView()
    }
    
    // constructor()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .black
        let _url = URL(string: TWIST_CHAT_URL)
        let _request = URLRequest(url: _url!)
        webView.load(_request)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

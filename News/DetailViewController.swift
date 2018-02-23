//
//  DetailViewController.swift
//  News
//
//  Created by 李超逸 on 2018/02/23.
//  Copyright © 2018 李超逸. All rights reserved.
//

import WebKit
import UIKit

class DetailViewController: UIViewController {

    var urlString: String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(urlString)
        if let urlString = urlString,
            let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }

}

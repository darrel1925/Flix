//
//  TrailerViewController.swift
//  flix
//
//  Created by Darrel Muonekwu on 4/15/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var movieKey: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.movieKey)
        self.setTrailer(id: self.movieKey)

    }
    
    func setTrailer(id movieID: String){
        
        let baseYoutubeURL = "https://youtube.com/watch?v="
        
        let URLString = baseYoutubeURL + movieID
        print(URLString)
        let url = URL(string: URLString)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        print("done")
        
        
    }

}

//
//  MovieDetailsViewController.swift
//  flix
//
//  Created by Darrel Muonekwu on 4/14/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//

import UIKit
import AlamofireImage
import WebKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summeryLabel: UITextView!
    @IBOutlet weak var trailerButton: UIButton!
    
    
    var movie: [String:Any]!
    var videoAPI: [String:Any]!
    var movieKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let darkModeOn = UserDefaults.standard.object(forKey: "darkModeOn") {
            
            
            if (darkModeOn as! Bool == true) {
                enableDarkMode()
            }
            else {
                disableDarkMode()
            }
        }
        
        titleLabel.text = movie["title"] as? String ?? movie["original_title"] as? String
        summeryLabel.text = movie["overview"] as? String
        
        titleLabel.sizeToFit()
       // summeryLabel.sizeToFit()
        trailerButton.layer.cornerRadius = 20
        
        // for image
        let baseURL = "https://image.tmdb.org/t/p/w300/"
        let posterPath = movie["poster_path"] as! String
        let finalURL = URL(string: baseURL + posterPath)
        
        posterView.af_setImage(withURL: finalURL!)
        // for image
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780/" + backdropPath)
        
        backdropView.af_setImage(withURL: backdropURL!)
        
    
        backdropView.layer.zPosition = -5
        
        
        print(movie["title"])
        
        loadTrailer()
    }
    
    
    func loadTrailer() {
        let baseMovieUrl = "https://api.themoviedb.org/3/movie/"
        let movieId = movie["id"]
        let baseMovieURL2 = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let movieAPIURL = "\(baseMovieUrl)\(movieId!)\(baseMovieURL2)"
        print(movieAPIURL)
        print("\n\n\n\n\n")

        makeNetworkRequest(movieAPIURL: movieAPIURL)
        
        //let baseYoutubeURL = "htpps://youtube/watchv?="
        
        //print(self.videoAPI)
        //let videoID = self.videoAPI["id"]
        
        //let URLString = baseYoutubeURL + videoID
        
        //print(videoID)
    }
    
    func makeNetworkRequest(movieAPIURL: String) {
        let url = URL(string: movieAPIURL)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                    print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let d = dataDictionary["results"] as! [[String:Any]]
                print(d[0])
                self.movieKey = (d[0]["key"] as! String)
                
      ///          self.videoAPI = d[0]
    //            self.setTrailer(id: d[0]["key"]! as! String)
            }
        }
        task.resume()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let TrailerVC = segue.destination as! TrailerViewController
        
        TrailerVC.movieKey = self.movieKey
    }
    
    func enableDarkMode() {
        titleLabel.textColor = .white
        summeryLabel.backgroundColor = .black
        summeryLabel.textColor = .white
        summeryLabel.reloadInputViews()
        view.backgroundColor = .black
    }

    func disableDarkMode() {
        titleLabel.textColor = .black
        summeryLabel.backgroundColor = .white
        summeryLabel.textColor = .black
        summeryLabel.reloadInputViews()
        view.backgroundColor = .white
    }
}

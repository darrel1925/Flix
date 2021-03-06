//
//  MovieGridViewController.swift
//  flix
//
//  Created by Darrel Muonekwu on 4/15/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mov = [[String:Any]]()
    var movies = [[String:Any]]()
    
    override func viewDidAppear(_ animated: Bool) {
        if let darkModeOn = UserDefaults.standard.object(forKey: "darkModeOn") {
            if (darkModeOn as! Bool == true) {
                enableDarkMode()
            }
            else {
                print("Going to diableDarkMode")
                disableDarkMode()
            }
        }
        
    setUserDefaults()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // what you use to configure the layout of MovieGrid
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumLineSpacing * 2) / 3
        
        layout.itemSize = CGSize(width: width , height: width * 3 / 2)
        //let length = view.frame.size.height
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/299537/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //print(dataDictionary)
                
                self.mov = dataDictionary["results"] as! [[String:Any]]
                
                self.movies = self.mov.sorted(by: ({ ($0["original_title"] as! String) < ($1["original_title"] as! String )}) )
//                print(self.movies[0]["title"] ?? "ERROR HAPPENED")
                ["original_title"].count
                
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // this will give you a version of the cell that you will need to cast a a MovieGridCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath ) as! MovieGridCell
        
        // for poster
        let baseURL = "https://image.tmdb.org/t/p/w300/"
        let movie = movies[indexPath.item]
        let posterPath = movie["poster_path"] as! String
        let finalURL = URL(string: baseURL + posterPath)

        cell.posterView.af_setImage(withURL: finalURL!)
        
        if let darkModeOn = UserDefaults.standard.object(forKey: "darkModeOn") {
            if (darkModeOn as! Bool == true) {
                print("DARKK MODEEEEE")
                cell.backgroundColor = .black
            }
            else {
                print("LIGHT MODEEEEE")
                cell.backgroundColor = .white
            }
        }
        
        return cell
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsController"{
        
            let MovieDetailsVC = segue.destination as! MovieDetailsViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)
            let movie = self.movies[indexPath!.item]
        
            MovieDetailsVC.movie = movie
        }
        else if segue.identifier == "toSettingsController"{
            print("Hey, this worked Great!")
        }
    }
    
    func disableDarkMode() {
        
        // change NavBar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().barTintColor = .white
        
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.reloadData()
    }
    
    func enableDarkMode() {
        
        // change NavBar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = .black
        
        view.backgroundColor = .black
        collectionView.backgroundColor = .black
        collectionView.reloadData()
    }
    
    func setUserDefaults() {
        if UserDefaults.standard.object(forKey: "genre") == nil {
            //Avngrs Endgame          Dumbo
            let movieGenres: [String:String] = ["superhero": "299534","kids":"329996", "romance":  "", "action":""]
            UserDefaults.standard.set("299534", forKey: "genre")
        }
    }
}

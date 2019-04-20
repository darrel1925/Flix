//
//  MoviesViewController.swift
//  flix
//
//  Created by Darrel Muonekwu on 4/6/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//
//
// MARK: setNeedsStatusBarAppearsUpdate

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // array of dictionaries with key as string and values and any
    var movies = [[String:Any]]()
    var isDeafultStatusBar = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDeafultStatusBar ? .default : .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        print("NETWORK REQUEST STARTED")
        makeNetworkRequest()
        
        print("VIEW LOAD")
        
        }
    
    override func viewDidAppear(_ animated: Bool) {
        print("VIEW APPEAR")
        if let darkModeOn = UserDefaults.standard.object(forKey: "darkModeOn") {
            
            if (darkModeOn as! Bool == true) {
                enableDarkMode()
            }
            else {
                disableDarkMode()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let summery = movie["overview"] as! String
        
        // for image
        let baseURL = "https://image.tmdb.org/t/p/w300/"
        let posterPath = movie["poster_path"] as! String
        let finalURL = URL(string: baseURL + posterPath)
        
        cell.posterView.af_setImage(withURL: finalURL!)
        
        cell.titleLabel.text = title
        cell.summeryLabel.text = summery
        
        
        if let darkModeOn = UserDefaults.standard.object(forKey: "darkModeOn") {
            
            if (darkModeOn as! Bool == true) {
                cell.titleLabel.textColor = UIColor.white
                cell.summeryLabel.textColor = UIColor.white
                cell.backgroundColor = .black            }
            else {
                cell.titleLabel.textColor = UIColor.black
                cell.summeryLabel.textColor = UIColor.black
                cell.backgroundColor = .white
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsController" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            
            let movie = movies[indexPath![1]]

            let MovieDetailsVC = segue.destination as! MovieDetailsViewController
            MovieDetailsVC.movie = movie
            // unhilights the selected cell when you come back
                tableView.deselectRow(at: indexPath!, animated: true)
        }
    }
    
    func makeNetworkRequest() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //print(dataDictionary)
                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.tableView.reloadData()
//                print(self.movies[0]["title"] ?? "ERROR HAPPENED")
                print("NETWORK REQUEST FINISHED")
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        task.resume()
    }
    
    func enableDarkMode() {
        
        // change NavBar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = .black
    
        
        // views background color
        self.view.backgroundColor = UIColor.black
        
        tableView.backgroundColor = UIColor.black
        tableView.reloadData()
    }
    
    func disableDarkMode() {
        // change NavBar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        UINavigationBar.appearance().barTintColor = .white
        
        // views background color
        self.view.backgroundColor = UIColor.white
        
        tableView.backgroundColor = UIColor.white
        tableView.reloadData()
        // change TabBar
        // MARK: HOW DO I CHANGE THE TAB BAR COLOR
        
//        UITabBar.appearance().backgroundColor = .orange
//        UITabBar.appearance().tintColor
        
        
        

        //cell.titleLabel.textColor = UIColor.green
        
        //        let cell = MovieCell()
         // MovieCell().makeTitleLabelLight()
//        cell.summeryLabel.textColor = UIColor.green
        
//        cell.titleLabel.text = title
//        cell.summeryLabel.text = summery
//        UINavigationBar.appearance().prefersLargeTitles = false
//        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
//
        
//        UINavigationBar.appearance().tintColor = .blue

        // UINavigationBar.appearance().isTranslucent = false
    }
}

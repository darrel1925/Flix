//
//  SettingsTableViewController.swift
//  flix
//
//  Created by Darrel Muonekwu on 4/16/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet var settingsTableView: UITableView!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var darkModeCell: UIView!
    @IBOutlet weak var darkModeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        if let darkModeOn = UserDefaults.standard.object(forKey: "darkModeOn") as? Bool {
            darkModeSwitch.isOn = darkModeOn
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    @IBAction func darkModePressed(_ sender: Any) {
        print("darkMode IS \(darkModeSwitch.isOn)")
        if (darkModeSwitch.isOn) {
            enableDarkMode()
        }
        else {
            enableLightMode()
            print("Going to light mode function.")
        }
    }
        
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//
//    }
    
    func enableLightMode(){
        // TODO: add userdefaults then change the viewdidloads on ther other pages
        
        UserDefaults.standard.setValue(false, forKey: "darkModeOn")
        
        
        // change NavBar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UINavigationBar.appearance().barTintColor = .white
        
        // views background color
        self.view.backgroundColor = UIColor.white
        
        // change row color
        darkModeCell.backgroundColor = .white
        darkModeLabel.textColor = .black
        
        
        settingsTableView.backgroundColor = UIColor.white
        settingsTableView.reloadData()
        print("User defaults is now false")
    }
        
    func enableDarkMode(){
        
        UserDefaults.standard.setValue(true, forKey: "darkModeOn")
        
        // change NavBar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = .black
        
        // views background color
        self.view.backgroundColor = UIColor.black
        
        // change row color
        darkModeCell.backgroundColor = .black
        darkModeLabel.textColor = .white
        
        settingsTableView.backgroundColor = UIColor.black
        settingsTableView.reloadData()
        
        
    
        
    }
    

}





































    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



//
//  ViewController.swift
//  Twister
//
//  Created by Thoralf Thelle on 17/06/2019.
//  Copyright © 2019 twist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil);
    
    
    @objc func showSettings ()
    {
        print("x")
        let settingsView = SettingsView()
        self.navigationController?.pushViewController(settingsView, animated: true)
    }
    
    func setNavigationBar ()
    {
        let navBar = self.navigationController?.navigationBar
        let appLogo = UIImage(named: "logo-white")
        let appLogoView = UIImageView(image: appLogo)
        appLogoView.contentMode = .scaleAspectFit
        //let rightItem = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(showSettings))
        
        self.navigationItem.titleView = appLogoView
        //self.navigationItem.rightBarButtonItem = rightItem
        self.navigationItem.hidesSearchBarWhenScrolling = false
        navBar?.barStyle = UIBarStyle.blackTranslucent
        navBar?.backgroundColor = nil
        navBar?.tintColor = .white
    }
    
    func setSearchController ()
    {
        self.searchController.searchBar.placeholder = "Search for anime"
        self.searchController.searchBar.barStyle = .black
        self.searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
    
    override func loadView() {
        super.loadView()
        
        self.setNavigationBar()
    }
    
    // constructor()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        view.backgroundColor = .black
        self.setSearchController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

extension ViewController: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        //Show Cancel
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.tintColor = .white
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        //Filter function
        //self.filterFunction(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Hide Cancel
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        
        guard let term = searchBar.text , term.isEmpty == false else {
            
            //Notification "White spaces are not permitted"
            return
        }
        
        //Filter function
        //self.filterFunction(searchText: term)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        //Hide Cancel
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = String()
        searchBar.resignFirstResponder()
        
        //Filter function
        //self.filterFunction(searchText: searchBar.text)
    }
}

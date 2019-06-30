//
//  ViewController.swift
//  Twister
//
//  Created by Thoralf Thelle on 17/06/2019.
//  Copyright © 2019 twist. All rights reserved.
//

import UIKit

// Main VC
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(animes[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        
        cell.textLabel!.text = "\(animes[indexPath.row].animeTitle)"
        return cell
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var animes = [AnimeItem]()
    var tableView: UITableView! = nil
    
    
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
        self.fetchData()
    }
    
    // Fetch data from the feed and build a tableview out of it
    func fetchData() {
        AnimeFeedFetch().getAll {
            items in
            self.animes = items.sorted { $0.animeTitle < $1.animeTitle }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor.darkGray
        self.view.addSubview(tableView)
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
        let search = Normalize(string: searchText.lowercased())
        
        print(search)
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

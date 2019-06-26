//
//  SettingsView.swift
//  Twister
//
//  Created by Thoralf Thelle on 17/06/2019.
//  Copyright © 2019 twist. All rights reserved.
//

import UIKit

class SettingsView: UIViewController {
    
    func setNavigationBar ()
    {
        let navBar = self.navigationController?.navigationBar
        
        self.navigationItem.title = "Settings"
        navBar?.barStyle = UIBarStyle.blackTranslucent
        navBar?.backgroundColor = nil
        navBar?.tintColor = .white
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
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

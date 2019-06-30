//
//  AnimeCell.swift
//  Twister
//
//  Created by Thoralf Thelle on 30/06/2019.
//  Copyright © 2019 twist. All rights reserved.
//

import Foundation
import UIKit

class AnimeCell : UITableViewCell {
    
    var anime : AnimeItem? {
        didSet {
            animeTitle.text = anime?.animeTitle
            animeOngoing.text = anime!.animeOngoing > 0 ? "Ongoing" : nil
        }
    }
    
    private let animeTitle : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let animeOngoing : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .red
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .right
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(animeOngoing)
        addSubview(animeTitle)
        
        animeOngoing.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        animeTitle.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 24, enableInsets: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

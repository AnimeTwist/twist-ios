//
//  utils.swift
//  Twister
//
//  Created by Thoralf Thelle on 30/06/2019.
//  Copyright © 2019 twist. All rights reserved.
//

import Foundation

func Normalize(string: String) -> String {
    let output = string.folding(options: .diacriticInsensitive, locale: nil)
    return output
}

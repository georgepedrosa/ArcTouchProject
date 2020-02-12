//
//  String+Extensions.swift
//  ArcTouchChallenge
//
//  Created by George Pedrosa on 15/12/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

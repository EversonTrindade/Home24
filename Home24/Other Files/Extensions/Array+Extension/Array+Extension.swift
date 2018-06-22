//
//  Array+Extension.swift
//  Home24
//
//  Created by Everson Trindade on 19/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

extension Array {
    func object(index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        }
        return nil
    }
}

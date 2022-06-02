//
//  Arrays.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 01/02/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import Foundation

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}

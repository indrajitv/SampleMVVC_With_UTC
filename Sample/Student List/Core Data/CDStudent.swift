//
//  CDStudent.swift
//  SOLID
//
//  Created by Indrajit Chavda on 28/12/21.
//

import Foundation

struct CDStudent {
    var name: String?
}

extension CDStudent {
    func toStudent() -> Student {
        return Student() // For future
    }
}

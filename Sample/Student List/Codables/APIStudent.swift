//
//  APIStudent.swift
//  SOLID
//
//  Created by Indrajit Chavda on 28/12/21.
//

import Foundation

struct APIStudent: Decodable {
    var name: String?
}

extension APIStudent {
    func toStudent() -> Student {
        return Student() // For future
    }
}

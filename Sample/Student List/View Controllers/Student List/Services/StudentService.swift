//
//  StudentService.swift
//  SOLID
//
//  Created by Indrajit Chavda on 29/12/21.
//

import Foundation

protocol StudentService {
    func getStudentData(completion: @escaping (Result<[Student], Error>) -> Void)
}

//
//  StudentAPIServices.swift
//  SOLID
//
//  Created by Indrajit Chavda on 29/12/21.
//

import Foundation

struct StudentAPIServices: StudentService {
    func getStudentData(completion: @escaping (Result<[Student], Error>) -> Void) {
        /*completion(.failure(NSError.init(domain: "No API for now as it is demo project",
         code: 100,
         userInfo: nil))) // In real life these will some values
         In case of failure
         */
        let students: [Student] = [
            .init(name: "Foo", rollNumber: 1, dob: Date().addingTimeInterval(-24 * 60 * 60 * 1000)),
            .init(name: "Bar", rollNumber: 2, dob: Date().addingTimeInterval(-24 * 60 * 60 * 2000)),
            .init(name: "One", rollNumber: 3, dob: Date().addingTimeInterval(-24 * 60 * 60 * 2500)),
            .init(name: "New New", rollNumber: 3, dob: Date().addingTimeInterval(-24 * 60 * 60 * 10000))
        ]
        completion(.success(students))
    }
}

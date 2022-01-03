//
//  File.swift
//  SOLIDTests
//
//  Created by Indrajit Chavda on 30/12/21.
//

import XCTest

enum ResultType {
    case error
    case successWithEmptyStudents
    case successWithOneStudents
    case successWith100Students
}

class MockedStudentService: StudentService {
    let resultType: ResultType
    
    init(type: ResultType) {
        self.resultType = type
    }
    
    func getStudentData(completion: @escaping (Result<[Student], Error>) -> Void) {
        switch self.resultType {
        case .error:
            completion(.failure(NSError.init(domain: "Something went wrong!",
                                             code: 1002,
                                             userInfo: nil)))
        case .successWithEmptyStudents:
            completion(.success([]))
        case .successWithOneStudents:
            completion(.success(self.getStudents(count: 1)))
        case .successWith100Students:
            completion(.success(self.getStudents(count: 100)))
        }
    }
    
    func getStudents(count: Int) -> [Student] {
        var students = [Student]()
        let studentsNames = ["Foo", "Bar", "Student1", "Student2", "Student3"]
        for i in 1...count {
            students.append(.init(name: studentsNames.randomElement(),
                                  rollNumber: i+1,
                                  dob: Date().addingTimeInterval(TimeInterval(i + 1 * 5000))))
        }
        return students
    }
}


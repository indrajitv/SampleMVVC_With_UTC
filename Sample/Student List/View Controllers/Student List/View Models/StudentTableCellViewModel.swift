//
//  StudentTableCellViewModel.swift
//  SOLID
//
//  Created by Indrajit Chavda on 28/12/21.
//

import Foundation

protocol StudentTableCellViewModelProtocol {
    var student: Student { get }
    var studentName: String { get set }
    var studentDOB: String { get }

    func checkIfAdult(date: Date?) -> Bool?
    init(student: Student)
}

class StudentTableCellViewModel: StudentTableCellViewModelProtocol {
    var student: Student
    var studentName: String
    var studentDOB: String
    
    required init(student: Student) {
        self.student = student
        studentName = "Mr. \(student.name ?? "Unknown")"
        studentDOB = "Not available"
        if let dob = student.dob {
            studentDOB = self.convertDateToString(date: dob)
        }
        
        if let _isAdult = self.checkIfAdult(date: student.dob), _isAdult {
            studentDOB += " (Adult)"
        } else {
            studentDOB += " (Minor)"
        }
    }
    
    func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    func checkIfAdult(date: Date?) -> Bool? {
        if let date = date {
           return abs(date.timeIntervalSinceNow) >= 6570 * 24 * 60 * 60  
        }
        return nil
    }
}



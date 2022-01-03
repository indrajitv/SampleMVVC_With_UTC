//
//  StudentDetailsViewModel.swift
//  SOLID
//
//  Created by Indrajit Chavda on 02/01/22.
//

import Foundation

struct StudentDetailsViewModel {
    let student: Student
    
    let studentName: String
    
    init(student: Student) {
        self.student = student
        
        self.studentName = "This is details view for \(student.name ?? "Unknown")"
    }
}

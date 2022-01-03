//
//  StudentTableCellViewModelTest.swift
//  SOLIDTests
//
//  Created by Indrajit Chavda on 03/01/22.
//

import XCTest

class StudentTableCellViewModelTest: XCTestCase {
    func test_onIntitalisation_propertiesGetSet_whilePropertiesSetToNotNil() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let student = Student(name: "Ironman", rollNumber: 1,
                              dob: formatter.date(from: "2022/01/01"))
        let viewModel = StudentTableCellViewModel(student: student)
        
        XCTAssertEqual(viewModel.studentName, "Mr. Ironman")
        XCTAssertEqual(viewModel.studentDOB, "01 Jan 2022 (Minor)")
        
        let student2 = Student(name: "Spiderman", rollNumber: 2,
                               dob: formatter.date(from: "1992/01/01"))
        let viewModel1 = StudentTableCellViewModel(student: student2)
        
        XCTAssertEqual(viewModel1.studentName, "Mr. Spiderman")
        XCTAssertEqual(viewModel1.studentDOB, "01 Jan 1992 (Adult)")
    }
    
    func test_onIntitalisation_propertiesGetSet_whilePropertiesSetToNil() {
        let viewModel = StudentTableCellViewModel(student: Student(name: nil, rollNumber: 1, dob: nil))
        
        XCTAssertEqual(viewModel.studentName, "Mr. Unknown")
        XCTAssertEqual(viewModel.studentDOB, "Not available (Minor)")
    }
    
    func test_checkIfAdult() {
        let viewModel = StudentTableCellViewModel(student: .init())
        
        XCTAssertNil(viewModel.checkIfAdult(date: nil))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = .current
        
        XCTAssertFalse(viewModel.checkIfAdult(date: formatter.date(from: "2017/01/01"))!)
        XCTAssertFalse(viewModel.checkIfAdult(date: formatter.date(from: "2020/01/01"))!)
        XCTAssertFalse(viewModel.checkIfAdult(date: formatter.date(from: "2019/12/12"))!)
        XCTAssertTrue(viewModel.checkIfAdult(date: formatter.date(from: "2000/09/03"))!)
        XCTAssertTrue(viewModel.checkIfAdult(date: formatter.date(from: "1992/09/03"))!)
    }
}

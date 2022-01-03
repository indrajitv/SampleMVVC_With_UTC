//
//  StudentTableCellTest.swift
//  SOLIDTests
//
//  Created by Indrajit Chavda on 03/01/22.
//


import XCTest

class StudentTableCellTest: XCTestCase {
    func test_cellShowsProperData_onSuccess() {
        let cell = StudentTableCell()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let student = Student(name: "IronMan", rollNumber: 1,
                              dob: formatter.date(from: "2022/01/01"))
        cell.viewModel = StudentTableCellViewModel(student: student)
        XCTAssertEqual(cell.textLabel!.text!, "Mr. IronMan\n01 Jan 2022 (Minor)")
    }
    
    func test_cellShowsProperData_while_nameIsNil() {
        let cell = StudentTableCell()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let student = Student(name: nil, rollNumber: 1,
                              dob: formatter.date(from: "2022/01/01"))
        cell.viewModel = StudentTableCellViewModel(student: student)
        
        XCTAssertEqual(cell.textLabel!.text!, "Mr. Unknown\n01 Jan 2022 (Minor)")
    }
    
    func test_cellShowsProperData_while_dateIsNil() {
        let cell = StudentTableCell()
        
        let student = Student(name: nil, rollNumber: 1,
                              dob: nil)
        cell.viewModel = StudentTableCellViewModel(student: student)
        
        XCTAssertEqual(cell.textLabel!.text!, "Mr. Unknown\nNot available (Minor)")
    }
    
    func test_cellID_isSameAsClassName() {
        XCTAssertEqual(StudentTableCell.cellID, "StudentTableCell")
    }
}

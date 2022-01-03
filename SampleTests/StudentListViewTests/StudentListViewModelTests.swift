//
//  StudentListViewModelTest.swift
//  SOLIDTests
//
//  Created by Indrajit Chavda on 30/12/21.
//

import XCTest

class StudentListViewModelTest: XCTestCase {
    
    func test_serviceIsNotNil_whileInitialization() {
        let sut = makeSUT(resultType: .successWithEmptyStudents)
        XCTAssertNotNil(sut.services)
    }
    
    func test_observerReturns_whileStudentArrayUpdated() {
        let sut = makeSUT(resultType: .successWithOneStudents)
        var students:[Any] = []
        
        sut.observStudentData = { result in
            switch result {
            case .success(let _students):
                students.append(contentsOf: _students)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        sut.loadStudentData()
        XCTAssertEqual(students.count, 1, "First time it will must come 1")
        
        sut.loadStudentData()
        XCTAssertEqual(students.count, 3, "First time it will must come 1 + 2")
    }
    
    func test_loadStudentMethod_shouldReturnError_inCaseTheseIsError() {
        let sut = makeSUT(resultType: .error)
        var students:[Any] = []
        let exp = expectation(description: "Error should not be nil.")
        
        sut.observStudentData = { result in
            switch result {
            case .success(let _students):
                students.append(contentsOf: _students)
            case .failure(let error):
                if error.localizedDescription != "" {
                    exp.fulfill()
                }
            }
        }
        XCTAssertEqual(students.count, 0, "Student must be 0")
        sut.loadStudentData()
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_getStudentMethod_returnsProperObjectAtIndex_andReturnNil_ifIndexOutofBound() {
        var sut = self.makeSUT(resultType: .successWithEmptyStudents)
        sut.loadStudentData()
        XCTAssertNil(sut.getStudent(at: 0))
        XCTAssertNil(sut.getStudent(at: -1))
        
        sut = self.makeSUT(resultType: .successWithOneStudents)
        sut.loadStudentData()
        XCTAssertNotNil(sut.getStudent(at: 0))
        XCTAssertNil(sut.getStudent(at: 1))
        
        sut = self.makeSUT(resultType: .successWith100Students)
        sut.loadStudentData()
        XCTAssertNotNil(sut.getStudent(at: 0))
        XCTAssertNotNil(sut.getStudent(at: 99))
        XCTAssertNil(sut.getStudent(at: 100))
    }
    
    func test_nunmberOfStudentCount_inDifferentScenario() {
        var sut = self.makeSUT(resultType: .successWithEmptyStudents)
        sut.loadStudentData()
        XCTAssertEqual(sut.getGetNumberOfStudent(), 0)
        
        sut = self.makeSUT(resultType: .successWithOneStudents)
        sut.loadStudentData()
        XCTAssertEqual(sut.getGetNumberOfStudent(), 1)
        
        sut = self.makeSUT(resultType: .successWith100Students)
        sut.loadStudentData()
        XCTAssertEqual(sut.getGetNumberOfStudent(), 100)
    }
    
    func test_ifStudent_getRemovedAtSpecificIndex_alsoCheckStudentCount_afterRemoval() {
        var sut = self.makeSUT(resultType: .successWithEmptyStudents)
        sut.loadStudentData()
        XCTAssertThrowsError(try sut.removeStudentAtIndex(index: -1))
        XCTAssertThrowsError(try sut.removeStudentAtIndex(index: 0))
        XCTAssertThrowsError(try sut.removeStudentAtIndex(index: 10))
        XCTAssertEqual(sut.getGetNumberOfStudent(), 0)
        
        sut = self.makeSUT(resultType: .successWithOneStudents)
        sut.loadStudentData()
        XCTAssertThrowsError(try sut.removeStudentAtIndex(index: -1))
        XCTAssertNoThrow(try sut.removeStudentAtIndex(index: 0))
        XCTAssertThrowsError(try sut.removeStudentAtIndex(index: 0))
        XCTAssertEqual(sut.getGetNumberOfStudent(), 0)
        
        sut = self.makeSUT(resultType: .successWith100Students)
        sut.loadStudentData()
        XCTAssertThrowsError(try sut.removeStudentAtIndex(index: -1))
        XCTAssertNoThrow(try sut.removeStudentAtIndex(index: 0))
        XCTAssertNoThrow(try sut.removeStudentAtIndex(index: 98))
        XCTAssertEqual(sut.getGetNumberOfStudent(), 98)
    }
    
    func test_headerTitle() {
        let sut = makeSUT(resultType: .successWithOneStudents)
        XCTAssertEqual(sut.title, "Student List")
    }
    
    func makeSUT(resultType: ResultType) -> StudentListViewModel {
        let mockedStudentService = MockedStudentService(type: resultType)
        let sut = StudentListViewModel(service: mockedStudentService)
        return sut
    }
    
}



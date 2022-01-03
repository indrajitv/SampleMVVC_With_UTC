//
//  StudentListViewTest.swift
//  SOLIDTests
//
//  Created by Indrajit Chavda on 03/01/22.
//

import XCTest

class StudentListViewTest: XCTestCase {
    
    func test_headerTitle_visibleAndSet() {
        let sut = self.makeSUT(resultType: .successWithOneStudents)
        XCTAssertEqual(sut.title, "Student List")
    }
    
    func test_colorsOfViewControllerComponents_setOrNot() {
        let sut = self.makeSUT(resultType: .successWithOneStudents)
        let view = sut.view!
       
        XCTAssertEqual(view.backgroundColor, .white)
    }
    
    func test_tableViewHasDatasourceAndDelegates_also_cellHasRegisteredOrNot() {
        let sut = self.makeSUT(resultType: .successWithOneStudents)
        let table = sut.tableView
        XCTAssertNotNil(table.dataSource)
        XCTAssertNotNil(table.delegate)
        XCTAssertNotNil(table.dequeueReusableCell(withIdentifier: StudentTableCell.cellID))
    }
    
    func test_subViewsFrames_properlySetOrNot() {
        let sut = self.makeSUT(resultType: .successWithOneStudents)
        _ = sut.view
        XCTAssertEqual(sut.tableView.frame, sut.view.bounds)
    }
    
    func test_doesViewController_load_studentData() {
        let sut = self.makeSUT(resultType: .successWith100Students)
        _ = sut.view
        XCTAssertEqual(sut.viewModel.getGetNumberOfStudent(), 100)
    }
    
    func test_doesViewController_showsError_whileDataLoadMethodFails() {
        let sut = self.makeSUT(resultType: .error)
        _ = sut.view
        let table = sut.tableView
        XCTAssertTrue(sut.viewModel.getGetNumberOfStudent() == 0)
        XCTAssertEqual(sut.tableView(table, numberOfRowsInSection: 0), 0)
    }
    
    func test_tableViewDatasourceMethods_and_tableLoadsDataAsExpected() {
        let sut = self.makeSUT(resultType: .successWith100Students)
        _ = sut.view
        let table = sut.tableView
        XCTAssertEqual(table.numberOfSections, 1)
        XCTAssertEqual(table.numberOfRows(inSection: 0), 100)
        XCTAssertNotNil(table.cellForRow(at: .init(row: 0, section: 0)))
        XCTAssertNotNil(table.cellForRow(at: .init(row: 2, section: 0)))
        let lastIndex: IndexPath = .init(row: 99, section: 0)
        table.scrollToRow(at: lastIndex, at: .bottom, animated: false)
        if let lastCell = table.cellForRow(at:lastIndex) {
            XCTAssertTrue(lastCell.canBecomeFocused)
        } else {
            XCTFail("Last cell should exist.")
        }
    }
    
    func test_table_numberOfRowsInSection() {
        let sut = self.makeSUT(resultType: .successWith100Students)
        _ = sut.view
        let table = sut.tableView
        XCTAssertEqual(sut.tableView(table, numberOfRowsInSection: 0), 100)
        XCTAssertTrue(sut.tableView(table, numberOfRowsInSection: 0) <= 100)
    }
    
    func test_table_cellForRowAt() {
        let sut = self.makeSUT(resultType: .successWith100Students)
        _ = sut.view
        let table = sut.tableView
        let lastIndex1: IndexPath = .init(row: 0, section: 0)
        let cell1 = sut.tableView(table, cellForRowAt: lastIndex1) as! StudentTableCell
        XCTAssertNotNil(cell1)
        XCTAssertNotNil(cell1.viewModel)
        
        let lastIndex2: IndexPath = .init(row: 99, section: 0)
        let cell2 = sut.tableView(table, cellForRowAt: lastIndex2) as! StudentTableCell
        XCTAssertNotNil(cell2)
        XCTAssertNotNil(cell2.viewModel)
    }
    
    func test_table_didSelectRowAt() {
        let sut = self.makeSUT(resultType: .successWith100Students)
        _ = sut.view
        let table = sut.tableView
        let expectation = expectation(description: "sut.didSelectRowAtCompletion should get called on didSelect")
        sut.didSelectRowAtCompletion = { (_ viewModel: StudentTableCellViewModelProtocol?) in
            expectation.fulfill()
            XCTAssertNotNil(viewModel)
        }
        
        let lastIndex1: IndexPath = .init(row: 0, section: 0)
        sut.tableView(table, didSelectRowAt: lastIndex1)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func makeSUT(resultType: ResultType) -> StudentListView {
        let mockedStudentService = MockedStudentService(type: resultType)
        let viewModel = StudentListViewModel(service: mockedStudentService)
        let studentList = StudentListView(viewModel: viewModel)
        return studentList
    }
    
    func testPerformance() {
        let sut = makeSUT(resultType: .successWith100Students)
        measure {
            _ = sut.view
        }
    }
    
}

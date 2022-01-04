//
//  StudentListViewModel.swift
//  SOLID
//
//  Created by Indrajit Chavda on 28/12/21.
//

import Foundation

protocol StudentListViewModelProtocol {
    typealias StudentDataObserver = (Result<[StudentTableCellViewModelProtocol], Error>) -> Void
    var services: StudentService? { get }
    var observStudentData: StudentDataObserver? { get set }
    var students: [StudentTableCellViewModelProtocol] { get }
    var title:String { get }
    
    init(service: StudentService)
    func getStudent(at index: Int) -> StudentTableCellViewModelProtocol?
    func loadStudentData()
    func getGetNumberOfStudent() -> Int
    func removeStudentAtIndex(index: Int) throws
    func updateStudentName(at index: Int, newName: String)
}

class StudentListViewModel: StudentListViewModelProtocol {
    
    // MARK: Properties
    var services: StudentService?
    var observStudentData: StudentDataObserver? // This property updates implimenter when student gets updated.
    var students: [StudentTableCellViewModelProtocol] = [] {
        didSet {
            self.observStudentData?(.success(self.students))
        }
    } // This property becomes private(set) as we have { get } only in protocol. If we will make it {get set} from protocol the out sider can change the property. Note: Right now out sider can not change the property which is private(set)
    
    var title = "Student List"
    
    // MARK: Life cycle
    required init(service: StudentService) {
        services = service
    }
    
    // MARK: Methods
    func loadStudentData() {
        services?.getStudentData(completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .failure(let error):
                self.observStudentData?(.failure(error))
            case .success(let students):
                self.students.append(contentsOf: self.convertStudentToViewModel(students: students))
            }
        })
    }
    
    private func convertStudentToViewModel(students: [Student]) -> [StudentTableCellViewModelProtocol] {
        let studentViewModels = students.compactMap({ StudentTableCellViewModel(student: $0) })
        return studentViewModels
    }
    
    func getStudent(at index: Int) -> StudentTableCellViewModelProtocol? { // Despite the student array is accesible, we want this method because we may want to make sure validation happens in case of > index.
        if index < self.students.count, index >= 0 {
            return self.students[index]
        }
        return nil
    }
    
    func getGetNumberOfStudent() -> Int { // This can be optional for current scenario. People can access students directly. Method makes sense if we want to manipulate the result in some cases.
        return self.students.count
    }
    
    func removeStudentAtIndex(index: Int) throws { // notice!, We have used throws which reduces the possibilty of nested if else.
        if index < self.students.count, index >= 0 {
            self.students.remove(at: index)
        } else {
            throw NSError.init(domain: "Something went wrong", code: 1001, userInfo: nil)
        }
        /*
         if !hasAccess {
         throw NSError.init(domain: "You do not have access!", code: 1002, userInfo: nil)
         } else if let _systemError = systemError {
         throw NSError.init(domain: "Some system error.", code: 1002, userInfo: nil)
         Or you can send direct error msg
         throw NSError.init(domain: _systemError.localizedDescription, code: 1002, userInfo: nil)
         } else if index > self.students.count, index < 0 {
         throw NSError.init(domain: "Index out of bound", code: 1001, userInfo: nil)
         } else {
         self.students.remove(at: index)
         }
         
         How to use it?,  Now just below lines of code can handle all errors gracefully
         do {
         try removeStudentAtIndex(index: 2)
         } catch {
         print(error.localizedDescription)
         }
         */
    }
    
    func updateStudentName(at index: Int, newName: String) {
        if index < self.students.count, index >= 0 {
            var student = self.students[index].student
            student.name = newName
            self.students[index] = convertStudentToViewModel(students: [student])[0]
        }
    }
}

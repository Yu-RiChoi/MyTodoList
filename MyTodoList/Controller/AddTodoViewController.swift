//
//  AddTodoViewController.swift
//  MyTodoList
//
//  Created by 최유리 on 1/8/24.
//

import UIKit

class AddTodoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todos = [Todo]()
    var todosSection = ["daily","study"]
    
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        readTodo()
        todoTableView.reloadData()
    }
    
    
    @IBAction func addTodoButton(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
    // MARK: - TableView
    
    // section 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return todosSection.count
    }
    
    // header title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return todosSection[section]
    }
    
    // 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    // 특정 인덱스 row의 셀에 대한 정보를 넣어 셀을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.selectionStyle = .none
        
        let todo = self.todos[indexPath.row].title
        cell.textLabel?.text = todo

        return cell
    }
    
    // 행이 선택되었을 때 호출
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // 셀 클릭 시 얼럿창 -> 입력하면 수정됨. 수정은 되는데 맨마지막으로 순서가 바뀜
        self.todos.remove(at: indexPath.row)
        showAlert()
        createTodo()
    }
    
    // 스와이프로 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            todoTableView.reloadData()
        }
        // 삭제 후 데이터 저장
        createTodo()
    }
    
    // JSONEncoder를 사용. 인코딩하여 데이터 저장
    func createTodo() {
        let encoder = JSONEncoder()
        if let encodeData = try? encoder.encode(todos) {
            UserDefaults.standard.set(encodeData, forKey: "todos")
        }
    }
    
    // JSONDecoder를 사용. 디코딩하여 데이터 읽기
    func readTodo() {
        if let readData = UserDefaults.standard.data(forKey: "todos"),
           let decodeData = try? JSONDecoder().decode([Todo].self, from: readData) {
            todos = decodeData
        }
    }

    func showAlert() {
        let alert = UIAlertController(title: "할 일 추가", message: "할 일을 입력하세요", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = "할 일을 입력하세요"
        }
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { _ in
            guard let title = alert.textFields?[0].text else { return }
            self.todos.append(Todo(title: title, isCompleted: false))
            // todos 추가 후 데이터 저장
            self.createTodo()
            self.todoTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .destructive))
        
        self.present(alert, animated: true, completion: nil)
    }
}

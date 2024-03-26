//
//  ViewController.swift
//  myTodoList
//
//  Created by 쌩 on 3/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    let todoViewModel = TodoViewModel()
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        return button
    }()
    
    @objc func didTapAddAlertButton(_ sender: Any) {
        let controller = UIAlertController(title: "Todo를 추가하시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
        controller.addTextField { field in
            field.placeholder = "Write todo here"
        }
        let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
            if let firstTextField = controller.textFields?.first {
//                self.todoTitle = firstTextField.text ?? ""
                if firstTextField.text == "" {
                    self.todoViewModel.todoTitle = "입력된 값이 없습니다." // alert 위에 alert 로 입력된 값이 없다고 말해주는게 맞나 ..? // alert 위 alert 가 되기는 하나 ?????
                } else {
                    self.todoViewModel.todoTitle = firstTextField.text!
                }
                }
            self.didTapAlertOkButton()
            print(self.todoViewModel.todoTitle)
            }
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler : nil)
       
        controller.addAction(cancel)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }

   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.button.addTarget(self, action: #selector(didTapAddAlertButton), for: .touchUpInside)
    }
    private func setupUI() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(button)
        
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .white
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            button.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc func didTapAlertOkButton() {
        let myTodo = todo(id: todoViewModel.todoList.count, title: "\(self.todoViewModel.todoTitle)", isDone: false)
//        todoViewModel.todoList.append(myTodo)
//        todoViewModel.todoRealList = [todoViewModel.todoList]

        todoViewModel.append(todo: myTodo)
                tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return todoViewModel.todoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.imageView?.image = UIImage(systemName: "square")
        cell.textLabel?.text = todoViewModel.todoList[indexPath.row].title
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              self.todoViewModel.remove(at: indexPath, to: tableView)
              tableView.deleteRows(at: [indexPath], with: .automatic)
          }
         tableView.reloadData()
      }
   
}

class TodoViewModel {
    var todoList: Array<todo> = []
    var todoTitle: String = ""
    func append(todo: todo) {
        todoList.append(todo)
//        tableView.insertRows(at: [IndexPath(row: todoList.count-1, section: 0)], with: .automatic)
    }
    
    func remove(at indexPath: IndexPath, to tableView: UITableView) {
        todoList.remove(at: indexPath.row)
        
    }
}

struct todo {
    var id: Int
    var title: String
    var isDone: Bool
//    var importance: Int
//    var isLocked: Bool
//    var password: String
//    let dueDate: String   기한설정 스트링 ?
}

//#Preview {
//  ViewController()
//}
//   

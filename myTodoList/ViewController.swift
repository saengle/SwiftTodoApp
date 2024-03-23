//
//  ViewController.swift
//  myTodoList
//
//  Created by 쌩 on 3/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    var todoList: Array<todo> = []
    var todoRealList: Array<Array<todo>> = []
    var todoTitle: String = ""
    var testList = [["테스트 데이터 1", "테스트 데이터2", "테스트 데이터3", "ㅁㄴㅇㄹ", "asjdfsidgh"]]
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        return button
    }()
    
    @objc func didTapAddButtonAlert(_ sender: Any) {
        let controller = UIAlertController(title: "Todo를 추가하시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
        controller.addTextField { field in
            field.placeholder = "Write todo here"
        }
        let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
            if let firstTextField = controller.textFields?.first {
                self.todoTitle = firstTextField.text ?? ""
                }
            self.didTapAddButton()
            print(self.todoTitle)
            }
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler : nil)
       
        controller.addAction(cancel)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }

   
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.button.addTarget(self, action: #selector(didTapAddButtonAlert), for: .touchUpInside)
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
    
    @objc func didTapAddButton() {
        print("버튼 누름")
        let myTodo = todo(id: todoList.count, title: "\(self.todoTitle)", isDone: false)
        todoList.append(myTodo)
        todoRealList = [todoList]
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todoRealList.isEmpty {
            return testList[section].count
        } else {return todoRealList[section].count}
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.imageView?.image = UIImage(systemName: "square")
        if todoRealList.isEmpty {
            cell.textLabel?.text = testList[indexPath.section][indexPath.row]
        } else {cell.textLabel?.text = todoRealList[indexPath.section][indexPath.row].title}

        return cell
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

#Preview {
  ViewController()
}
   

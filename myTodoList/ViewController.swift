//
//  ViewController.swift
//  myTodoList
//
//  Created by 쌩 on 3/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    var todoList: Array<Array<todo>> = []
    
    var testList = [["테스트 데이터 1", "테스트 데이터2", "테스트 데이터3", "ㅁㄴㅇㄹ", "ㅁㄴㅇㅁㄹ", "훌랄라숯불바베큐", "먹고싶다", "아니 왜 요기는 바로 반영돼?", "테스트 데이터 1", "테스트 데이터2", "테스트 데이터3", "ㅁㄴㅇㄹ", "ㅁㄴㅇㅁㄹ", "훌랄라숯불바베큐", "먹고싶다","테스트 데이터 1", "테스트 데이터2", "테스트 데이터3", "ㅁㄴㅇㄹ", "ㅁㄴㅇㅁㄹ", "훌랄라숯불바베큐", "먹고싶다",]]
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
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
        let test = todo(id: todoList.count, title: "훌랄라 숯불 바베큐", isDone: false)
        print(todoList)
        todoList.append([test])
        testList[0].append("데이터 하나씩 추가")
        print(testList[0].count)
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todoList.isEmpty {
            return testList[section].count
        } else {return todoList[section].count}
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        if todoList.isEmpty {
            cell.textLabel?.text = testList[indexPath.section][indexPath.row]
        } else {cell.textLabel?.text = todoList[indexPath.section][indexPath.row].title}

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

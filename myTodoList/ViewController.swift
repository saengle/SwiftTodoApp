//
//  ViewController.swift
//  myTodoList
//
//  Created by 쌩 on 3/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    var testList = [["테스트 데이터 1", "테스트 데이터2", "테스트 데이터3"]]
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let button: UIButton = {
        let button = UIButton()
//            button.setTitle("아무말이없어서?", for: .normal)
//            button.backgroundColor = .systemBlue
//            button.layer.cornerRadius = 7
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
//            button.widthAnchor.constraint(equalToConstant: 300),
//            button.heightAnchor.constraint(equalToConstant: 300),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc func didTapAddButton() {
        print("버튼 누름")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testList[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.textLabel?.text = testList[indexPath.section][indexPath.row]
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

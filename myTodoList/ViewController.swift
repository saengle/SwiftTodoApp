//
//  ViewController.swift
//  myTodoList
//
//  Created by 쌩 on 3/20/24.
//

import UIKit

class ViewController: UIViewController {
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
        self.view.addSubview(button)
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            button.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
//            button.widthAnchor.constraint(equalToConstant: 300),
//            button.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    @objc func didTapAddButton() {
        print("버튼 누름")
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

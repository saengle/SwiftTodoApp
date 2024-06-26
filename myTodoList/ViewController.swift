//
//  ViewController.swift
//  myTodoList
//
//  Created by 쌩 on 3/20/24.
//

//
//
import UIKit

class ViewController: UIViewController {
    
    let todoViewModel = TodoViewModel()
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let addTodoButton: UIButton = {
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
                    self.todoViewModel.tempTodoTitle = "입력된 값이 없습니다." // alert 위에 alert 로 입력된 값이 없다고 말해주는게 맞나 ..? // alert 위 alert 가 되기는 하나 ?????
                } else {
                    self.todoViewModel.tempTodoTitle = firstTextField.text!
                }
                }
            self.didTapAlertOkButton()
            print(self.todoViewModel.tempTodoTitle)
            }
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler : nil)
       
        controller.addAction(cancel)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Mark: NavigationController 색이 왜 검게 나오지 ?? 그리고 이거 크기 못없애나 ..
        navigationController?.view.backgroundColor = .white
        
        self.addTodoButton.addTarget(self, action: #selector(didTapAddAlertButton), for: .touchUpInside)
    }
    
    private func setupUI() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(addTodoButton)
        
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .white
        self.addTodoButton.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addTodoButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            addTodoButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc func didTapAlertOkButton() {
        //Random한 아이디 생성
        let myTodo = todo(id: NSUUID().uuidString, title: "\(self.todoViewModel.tempTodoTitle)", isDone: false)
        todoViewModel.append(todo: myTodo)
                tableView.reloadData()
    }
    
    @objc func toggleSwitchDidTap(_ sender: UISwitch) {
        todoViewModel.changeIsDone(at: sender.tag)
        tableView.reloadData()
       }
    
    //체크박스 클릭시 변환 이벤트
    @objc func touchCheckBox(_ sender: UITapGestureRecognizer) {
        if let unwrappedInt = sender.view?.tag {
            todoViewModel.changeIsDone(at: unwrappedInt )
        } else {}
        tableView.reloadData()
     }
    
    // Mark: 셀 눌러서 디테일 화면으로 전환 (디테일 뷰 컨트롤러)
    @objc func touchTodoDetailPage(sender: UITapGestureRecognizer) {
        let detailPageViewController = DetailPageViewController()
//        if let unwrappedInt = sender.view?.tag
        // ;; 디테일 화면 = 디테일페이지뷰컨트롤러  로 연결한거같은데 왜 메인 스토리보드에 있는 디테일페이지뷰컨트롤러가 안나오는거지 ...
            self.navigationController?.pushViewController(detailPageViewController, animated: true)
    }
    
}
// 네비게이션 바가 검은색으로 나오고 크기를 차지하길래 ... 없애고 싶은데 어떻게 하지 ?
//extension UINavigationController {
//    open override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let height = CGFloat(0)
//        navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
//        navigationBar.isHidden = true
//    }
//}
//
//class TTNavigationBar: UINavigationBar {
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: 0)
//    }
//
//}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return todoViewModel.todoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀 생성
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        // 탭 제스쳐 생성 체크박스 이미지에 연결, 터치 동작 연결 (체크 <-> 넌체크)
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchCheckBox(_:)))
        cell.imageView?.image = todoViewModel.todoList[indexPath.row].isDone == true ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        cell.imageView?.addGestureRecognizer(imageTapGesture)
        cell.imageView?.isUserInteractionEnabled = true
        imageTapGesture.view?.tag = indexPath.row
        
        // 셀 누르면 디테일 페이지로 이동 추가
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchTodoDetailPage(sender:)))
        cell.textLabel?.text = todoViewModel.todoList[indexPath.row].title
        cell.addGestureRecognizer(cellTapGesture)
        
        //UISwitch 호출
        let switchView = UISwitch(frame: .zero)
        // switch 초기화면 버튼이 누르지 않은 채로
        switchView.setOn(todoViewModel.todoList[indexPath.row].isDone, animated: true)
        //swtichView tag 지정
        switchView.tag = indexPath.row
        //switchView addTarget 지정
        switchView.addTarget(self, action: #selector(self.toggleSwitchDidTap(_:)), for: .valueChanged)
        //cell accessoryView를 switchView로 지정
        cell.accessoryView = switchView
        
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
    var tempTodoTitle: String = ""
    
    func append(todo: todo) {
        todoList.append(todo)
    }
    
    func remove(at indexPath: IndexPath, to tableView: UITableView) {
        todoList.remove(at: indexPath.row)
    }
    
    func changeIsDone(at indexPathRow: Int) {
        todoList[indexPathRow].isDone = !todoList[indexPathRow].isDone
    }
}

struct todo {
    var id: String
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

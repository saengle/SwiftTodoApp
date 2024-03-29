//
//  DetailPageViewController.swift
//  myTodoList
//
//  Created by 쌩 on 3/26/24.
//

import Foundation
import UIKit

 class DetailPageViewController: UIViewController {
    var myTodoViewModel = TodoViewModel()
    
     @IBOutlet weak var myTestLabel: UILabel!
     override func viewDidLoad() {
        super.viewDidLoad()
         title = "테스트다"
         
    }
    
}

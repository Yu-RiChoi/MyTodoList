//
//  ViewController.swift
//  MyTodoList
//
//  Created by 최유리 on 1/8/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTodoButton(_ sender: UIButton) {
        // manual segue로 화면전환
        performSegue(withIdentifier: "showAddTodoView", sender: nil)
    }
}

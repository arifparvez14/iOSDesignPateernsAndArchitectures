//
//  ViewController.swift
//  CoordinatorDemo
//
//  Created by Muhammad Ariful Islam on 20/6/23.
//

import UIKit

class LoginVC: UIViewController, CoordinatorBoard {
    
    weak var loginChildCoordinator: LoginChildCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func firstVCTapped(_ sender: Any) {
        loginChildCoordinator?.navigateToHomeVC(with: "This is Home VC")
    }
    
    @IBAction func secondVCTapped(_ sender: Any) {
        loginChildCoordinator?.navigateToSignupVC()
    }
    
    @IBAction func thirdVCTapped(_ sender: Any) {
        loginChildCoordinator?.navigateToResetPasswardVC()
    }
}


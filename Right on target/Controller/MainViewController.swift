//
//  MainViewController.swift
//  Right on target
//
//  Created by Алексей Колыченков on 21.08.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    @IBAction func numberBtnTapped() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NumberViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func colorBtnTapped() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColorViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}

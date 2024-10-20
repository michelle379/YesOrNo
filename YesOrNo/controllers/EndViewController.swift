//
//  EndViewController.swift
//  YesOrNo
//
//  Created by 王宜婕 on 2024/10/20.
//

import UIKit

class EndViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }




}
#Preview{
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //withIdentifier內打入View名稱
    return storyboard.instantiateViewController(withIdentifier: "EndViewController")
}


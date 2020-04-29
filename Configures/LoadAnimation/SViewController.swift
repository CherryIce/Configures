//
//  SViewController.swift
//  Configures
//
//  Created by hubin on 2020/4/24.
//  Copyright © 2020 hubin. All rights reserved.
//

import UIKit

class SViewController: UIViewController,LoadingViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading()
        // Do any additional setup after loading the view.
        //self.view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            self.loadFaild(type: .nothing)
            //self.endLoading()
        }
    }
    
    
    // MARK: - LoadingViewDelegate
    /// 2.实现加载视图代理事件，返回按钮点击事件。
    func loadingBackButtonTaped() {
        navigationController?.popViewController(animated: true)
    }

    /// 3.实现加载视图代理事件，重新加载按钮点击事件。
    func reloadingButtonTaped() {
        
    }
}

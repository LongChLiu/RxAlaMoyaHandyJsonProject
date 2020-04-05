//
//  ViewController.swift
//  RxAlaMoyaHandyJsonProject
//
//  Created by 刘隆昌 on 2020/4/5.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let rxProvider = MoyaProvider<APIManager>()
        rxProvider.rx.request(.getNbaInfo(getKey: "537f7b3121a797c8d18f4c0523f3c124")).asObservable().mapResponseToObject(type: DataModel.self).subscribe{  test in
            
            print(test)
            let model = test.element
            print(model?.reason ?? String.self)
        }.disposed(by: disposeBag)
        
        
    }


}


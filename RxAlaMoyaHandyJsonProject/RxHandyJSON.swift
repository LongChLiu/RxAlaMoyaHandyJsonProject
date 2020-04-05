//
//  RxHandyJSON.swift
//  RxAlaMoyaHandyJsonProject
//
//  Created by 刘隆昌 on 2020/4/5.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON
import Moya


enum DCUError:Swift.Error {
    case ParseJSONError
    case RequestFailed
    case NoResponse
    case UnexpectedResult(resultCode:Int?,resultMsg:String?)
}

enum RequestStatus: Int {
    case requestSuccess = 200
    case requestError
}


fileprivate let Result_Code = "code"
fileprivate let Result_Msg = "reason"
fileprivate let Result_Data = "result"


public extension Observable{
    
    func mapResponseToObject<T: HandyJSON>(type:T.Type) -> Observable<T>{
        return map{ response in
            
            guard let response = response as? Moya.Response else {
                throw DCUError.NoResponse
            }
            
            guard ((200...209) ~= response.statusCode) else {
                throw DCUError.RequestFailed
            }
            
            let jsonData = try response.mapJSON() as! [String:Any]
            if let code = jsonData[Result_Msg] as? String{
                if code == "查询成功" {
                    if let model = JSONDeserializer<T>.deserializeFrom(dict: jsonData) {
                        return model
                    }
                }
            }
            
            throw DCUError.RequestFailed
        }
    }
    
    
}



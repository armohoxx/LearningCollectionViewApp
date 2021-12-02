//
//  NetworkAdapter.swift
//  tvis_app_for_ios
//
//  Created by khanathip rachprachon on 14/12/2563 BE.
//
// for me to change

import Moya
import Alamofire
import CryptoSwift

struct NetworkAdapter {
        
    static func getProvider() -> MoyaProvider<TvisAPI> {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "tvis.in.th": .disableEvaluation
        ]
        let manager = Manager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return MoyaProvider<TvisAPI>(manager: manager)
    }
    
    static func request(target: TvisAPI,
                        success successCallback: @escaping (Response) -> Void,
                        error errorCallback: @escaping (Swift.Error) -> Void){
        getProvider().request(target){(result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300{
                    //print(response.statusCode)
                    successCallback(response)
                }else{
                    let error = NSError(domain: "com.imalice.ios.error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Parsing error the response from server"])
                    errorCallback(error)
                }
            case .failure(let error):
                errorCallback(error)
            }
        }
        
    }
    
}

//
//  Api.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import Foundation
import Alamofire
import PromiseKit


typealias Completion = (MyError?)->Void

class Api {
    
    func fireRequestWithSingleResponse<T: Codable>(urlConvertible: Requestable, mappingClass: T.Type) -> Promise<T>{
        
        return Promise<T> { [weak self] seal in
            guard let self = self else {return}
            // Trigger the HTTPRequest using Alamofire
            AF.request(urlConvertible).responseJSON { response in
                self.handleResponse(response: response, mappingClass: mappingClass).get { successData in
                    seal.fulfill(successData)
                }.catch { error in
                    seal.reject(error)
                }
            }
        }
    }
    
    private func handleResponse<T: Codable>(response: AFDataResponse<Any>, mappingClass: T.Type) -> Promise<T> {
        return Promise<T> { seal in
            switch response.result {
            case .success:
                
                if (200...300).contains(response.response?.statusCode ?? 0) {
                    do {
                        guard let jsonResponse = response.data else {
                            seal.reject(MyError.unknown)
                            return
                        }
                        let responseObj = try JSONDecoder().decode(T.self, from: jsonResponse)
                        seal.fulfill(responseObj)
                    }catch {
                        print(error.localizedDescription)
                        seal.reject(error)
                    }
                } else {
                    seal.reject(parseErrorData(response: response))
                }
                
            case .failure(let error):
                print(error)
                seal.reject(parseErrorData(response: response))
            }
        }
    }
    
    private func parseErrorData(response: AFDataResponse<Any>?) -> Error{
        switch response?.response?.statusCode {
        case 400:
            return MyError.badAPIRequest
        case 401:
            return MyError.unauthorized
        case 502:
            return MyError.timeout
        case 500:
            return MyError.serverError
        default:
            return MyError.unknown
        }
    }
}

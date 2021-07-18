//
//  BaseService.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import RxSwift
import RxCocoa
import Alamofire

class BaseService {
    public func request<T: Codable>(_ endPoint: String) -> Observable<T> {
        return Observable.create { observer in
            let request = AF.request(endPoint).responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create() {
                request.cancel()
            }
        }
    }
    
    public func requestData(_ endPoint: String) -> Observable<Data> {
        return Observable.create { observer in
            let request = AF.request(endPoint).responseData { response in
                if let statusCode = response.response?.statusCode,
                   (200..<300).contains(statusCode),
                   let data = response.data {
                    observer.onNext(data)
                } else {
                    observer.onError(NSError())
                }
            }
            return Disposables.create() {
                request.cancel()
            }
        }
    }
}

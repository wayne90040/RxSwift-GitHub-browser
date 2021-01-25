//
//  ViewModel.swift
//  GitHubRepositories-MVVM
//
//  Created by Wei Lun Hsu on 2021/1/24.
//

import Foundation
import RxSwift
import Moya
import Moya_ObjectMapper

class ViewModel {
    
    public var repo: PublishSubject<[GitRepo]> = PublishSubject.init()
    public var keywords: PublishSubject<String> = PublishSubject.init()
    
    private let provider = MoyaProvider<NetworkManager>()
    private let disposeBag = DisposeBag()
    
    init() {
        keywords.asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] string in
                self?.provider.rx.request(.searchRepos(keyword: string))
                    .mapArray(GitRepo.self)
                    .subscribe(onSuccess: { repo in
                        self?.repo.onNext(repo)  // 繼續事件，ex. 在textField上輸入一個 "A" onNext事件就會傳送 "A" 給 Observer.
                    }, onError: { error in
                        self?.repo.onNext([])
                    })
                    .disposed(by: (self?.disposeBag)!)
            })
            .disposed(by: self.disposeBag)
    }
}

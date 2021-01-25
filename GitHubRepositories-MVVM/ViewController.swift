//
//  ViewController.swift
//  GitHubRepositories-MVVM
//
//  Created by Wei Lun Hsu on 2021/1/24.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    private let mainTableView: UITableView  = {
        let tableView = UITableView()
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.identifier)
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private var viewModel: ViewModel!
    private let disposeBag = DisposeBag()  // 可被清除的资源

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // 初始化 viewModel
        viewModel = ViewModel()
        // definesPresentationContext = true  // 處理 SearchTab 在 present後仍出現
        
        navigationController?.navigationBar.topItem?.titleView = searchBar
        view.addSubview(mainTableView)
        
        // SearchBar
        searchBar.rx.text.orEmpty  // orEmpty則是把text的空值給過濾掉，不會往下傳遞
            .throttle(1, scheduler: MainScheduler.instance)  // 在指定的时间内，只接受第一条和最新的数据。 适用于：输入框搜索限制发送请求。
            .distinctUntilChanged()  //  阻止 Observable 發出相同的元素，如果前後相同將不會被發出來。
            .bind(to: viewModel.keywords)  // 綁定 viewModel keywords
            .disposed(by: disposeBag)
        
        //
        viewModel.repo.asDriver(onErrorJustReturn: [])
            .drive(mainTableView.rx.items(cellIdentifier: RepoTableViewCell.identifier, cellType: RepoTableViewCell.self)) { _, repo, cell in
            
                cell.configure(with: repo)
            }
            .disposed(by: disposeBag)
        
        // TableView
        mainTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        mainTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            // Add Action
            
        }).disposed(by: disposeBag)
        
            
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTableView.frame = view.bounds
    }
}

// MARK:- UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

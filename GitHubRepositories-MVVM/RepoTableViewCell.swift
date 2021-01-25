//
//  RepoTableViewCell.swift
//  GitHubRepositories-MVVM
//
//  Created by Wei Lun Hsu on 2021/1/24.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    static let identifier = "RepoTableViewCell"
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let isPrivatedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(idLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(isPrivatedLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelHeight = contentView.height / 2
        let labelWidth = contentView.width / 2
        
        idLabel.frame = CGRect(x: 10, y: 5, width: labelWidth, height: labelHeight)
        
        let nameSize = nameLabel.sizeThatFits(contentView.frame.size)
        nameLabel.frame = CGRect(x: 10, y: idLabel.bottom , width: nameSize.width, height: labelHeight)
        
        let privateSize = isPrivatedLabel.sizeThatFits(contentView.frame.size)
        isPrivatedLabel.frame = CGRect(x: contentView.width - privateSize.width - 10 , y: 5, width: privateSize.width, height: labelHeight)
        
    }
    
    
    public func configure(with model: GitRepo) {
        let isPrivate = model.isPrivate ? "No" : "Yes"
        isPrivatedLabel.text = "Private: \(isPrivate)"
        
        if let name = model.owner.name {
            idLabel.text = "Owner: \(name)"
        }
            
        if let name = model.name {
            nameLabel.text = "Repo Name: \(name)"
        }
    }
}

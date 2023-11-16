//
//  MainViewController.swift
//  VIPER_Exam
//
//  Created by 이재열 on 2023/11/16.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

final class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var presenter: MainPresenterProtocol!
    
    private var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(DogCell.self, forCellReuseIdentifier: DogCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
        $0.contentInset = .zero
        $0.isScrollEnabled = true
        $0.backgroundColor = .systemBackground
    }
    
    init(
        presenter: MainPresenterProtocol
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.input.showDogs()
        
        setupUI()
        setupState()
        setupAction()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupState() {
        presenter.output.dogs.asDriver()
            .drive(tableView.rx.items(cellIdentifier: DogCell.identifier,
                                      cellType: DogCell.self))
        { index, dog, cell in
            cell.configure(dog)
        }
        .disposed(by: disposeBag)
    }
    
    private func setupAction() {
        
    }
}

final class DogCell: UITableViewCell {
    static let identifier = "DogCell"
    
    private var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    func configure(_ dog: Dog) {
        nameLabel.text = dog.id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SetMyMBTIViewController.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/30.
//

import UIKit
import RxSwift
import RxCocoa

class SetMyMBTIViewController: UIViewController, UICollectionViewDelegate {
  
  struct Const {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  var viewModel: SetMyMBTIViewModelType?
  var coordinator: SetMyMBTICoordinator?
  var disposeBag = DisposeBag()
  
  // MARK: - UI properties
  lazy var flowLayout = UICollectionViewFlowLayout()
    .then {
      $0.itemSize = CGSize(width: floor((Const.screenWidth -
                                          additionalSafeAreaInsets.right -
                                          additionalSafeAreaInsets.left - 6) / 4),
                           height: floor((Const.screenWidth -
                                            additionalSafeAreaInsets.right -
                                            additionalSafeAreaInsets.left - 6) / 4))
      $0.minimumInteritemSpacing = 2
      $0.minimumLineSpacing = 2
      $0.scrollDirection = .vertical
    }
  
  lazy var collectionView = UICollectionView(frame: .zero,
                                             collectionViewLayout: flowLayout)
    .then {
      $0.register(MBTISelectableCell.self,
                  forCellWithReuseIdentifier: MBTISelectableCell.identifier)
      $0.backgroundColor = .white
      $0.allowsMultipleSelection = false
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    additionalSafeAreaInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    self.title = "SetMyMBTIViewController"
    bind()
    setupUI()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  func setupUI() {
    view.backgroundColor = .white
    view.addSubview(collectionView)
  }
  
  func setupConstraints() {
    collectionView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  func bind() {
    collectionView.rx
      .setDelegate(self)
      .disposed(by: disposeBag)
    
    collectionView.rx
      .itemSelected
      .bind(onNext: { [weak self] selected in
        guard let self = self else { return }
        if let cell = self.collectionView.cellForItem(at: selected) as? MBTISelectableCell {
          cell.backgroundColor = .orange
        }
      })
      .disposed(by: disposeBag)
    
    collectionView.rx
      .itemDeselected
      .bind(onNext: { [weak self] selected in
        guard let self = self else { return }
        if let cell = self.collectionView.cellForItem(at: selected) as? MBTISelectableCell {
          cell.backgroundColor = .white
        }
      })
      .disposed(by: disposeBag)
    
    self.viewModel?.mbtiList
      .asDriver(onErrorJustReturn: [])
      .debug()
      .drive(collectionView.rx.items(cellIdentifier: MBTISelectableCell.identifier, cellType: MBTISelectableCell.self)) { index, mbti, cell in
        cell.configure(mbti: mbti)
      }
      .disposed(by: disposeBag)
    
    self.viewModel?.getMBTIList()
  }
}

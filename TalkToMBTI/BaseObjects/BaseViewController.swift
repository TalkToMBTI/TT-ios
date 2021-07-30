//
//  BaseViewController.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/30.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
  
  var viewModel: ViewModelType?
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
  }
  
  func setupConstraints() {
    
  }
  
  func bind() {
  }
}

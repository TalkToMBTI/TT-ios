//
//  MBTISelectableCell.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/31.
//

import UIKit

class MBTISelectableCell: UICollectionViewCell {
  
  static let identifier = "MBTISelectableCell"
  
  lazy var mbtiTitleLabel = UILabel()
    .then {
      $0.font = UIFont.boldSystemFont(ofSize: 18)
      $0.textColor = .black
    }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupUI()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(mbti: MBTI) {
    DispatchQueue.main.async {
      self.mbtiTitleLabel.text = mbti.name
    }
  }
  
  func setupUI() {
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.black.cgColor
    contentView.addSubview(mbtiTitleLabel)
  }
  
  func setupConstraints() {
    mbtiTitleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}

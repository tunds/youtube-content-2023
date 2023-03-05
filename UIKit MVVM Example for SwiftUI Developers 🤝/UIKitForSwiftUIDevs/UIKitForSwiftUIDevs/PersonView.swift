//
//  PersonView.swift
//  UIKitForSwiftUIDevs
//
//  Created by Tunde Adegoroye on 02/11/2022.
//

import UIKit

class PersonView: UIView {

    private lazy var subscribeBtn: UIButton = {
        
        var config = UIButton.Configuration.filled()
        config.title = "Subscribe".uppercased()
        config.baseBackgroundColor = UIColor.red
        config.baseForegroundColor = UIColor.white
        config.buttonSize = .large
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var personDetailsStackVw: UIStackView = {
        
        let vw = UIStackView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.axis = .vertical
        vw.spacing = 8
        return vw
    }()
    
    private lazy var nameLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Billy Bob"
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        return lbl
    }()
    
    private lazy var emailLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "billy.bob@gmail.com"
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        return lbl
    }()
    
    private var completion: () -> ()

    init(completion: @escaping () -> ()) {
        self.completion = completion
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, email: String) {
        nameLbl.text = name
        emailLbl.text = email
    }
}

extension PersonView {
    
    func setup() {
        
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        
        self.addSubview(personDetailsStackVw)
        
        personDetailsStackVw.addArrangedSubview(nameLbl)
        personDetailsStackVw.addArrangedSubview(emailLbl)
        personDetailsStackVw.addArrangedSubview(subscribeBtn)
                
        NSLayoutConstraint.activate([
                        
            personDetailsStackVw.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            personDetailsStackVw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            personDetailsStackVw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            personDetailsStackVw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        subscribeBtn.addTarget(self,
                               action: #selector(didTapSubscribe),
                               for: .touchUpInside)
    }
    
    @objc func didTapSubscribe(sender: UIButton) {
        completion()
    }
}

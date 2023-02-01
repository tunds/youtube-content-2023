//
//  PeopleViewController.swift
//  UIKitForSwiftUIDevs
//
//  Created by Tunde Adegoroye on 01/11/2022.
//

import UIKit
import SafariServices

class PeopleViewController: UIViewController {
    
    private lazy var cv: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 150)
        
        let vw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vw.dataSource = self
        vw.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: "PersonCollectionViewCell")
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private let vm = PeopleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Ya boi is in mem")
        setup()
        vm.delegate = self
        vm.getUsers()
    }
}

extension PeopleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        vm.people.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = vm.people[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell",
                                                      for: indexPath) as! PersonCollectionViewCell
        cell.item = item
        cell.delegate = self
        return cell
    }
}

extension PeopleViewController: PeopleViewModelDelegate {
    
    func didFinish() {
        cv.reloadData()
    }
    
    func didFail(_ error: Error) {
        print(error)
    }
}

extension PeopleViewController: PersonCollectionViewCellDelegate {
    
    func didTapSubscribe() {
         
        let vc = SFSafariViewController(url: .init(string: "https://www.youtube.com/@tundsdev")!)
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
    }
}

private extension PeopleViewController {
    
    func setup() {
        
        navigationItem.title = "People"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.backgroundColor = .white
        
        view.addSubview(cv)
  
        NSLayoutConstraint.activate([
            
            cv.topAnchor.constraint(equalTo: view.topAnchor),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func sayHello() {
        print("Hello")
    }
}

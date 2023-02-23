//
//  ValidateApp.swift
//  Imgur App
//
//  Created by Humberto Rodrigues on 23/02/23.
//

import UIKit

protocol AuthorizeDelegate: AnyObject {
    func getAuthorization()
}

class ValidateApp: UIView {
    
    private weak var delegate: AuthorizeDelegate?
    
    func delegate(delegate: AuthorizeDelegate) {
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        extrasFeatures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var lbAuthorize: UILabel = {
        let label = UILabel()
        label.text = "Status de Autorização"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20,weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy var lbStatus: UILabel = {
        let label = UILabel()
        print("Criei Label")
        label.text = "Teste"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .bold)
        label.textColor = .red
        return label
    }()
    
    lazy var btAuthorize: UIButton = {
        let bt = UIButton()
        bt.setTitle("Autorize", for: .normal)
        bt.setTitleColor(.systemGreen, for: .normal)
        bt.backgroundColor = .green
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(dispararAutorizacao), for: .touchUpInside)
        return bt
    }()
    
    @objc func dispararAutorizacao() {
        delegate?.getAuthorization()
    }
    
    func extrasFeatures() {
        self.backgroundColor = .white
        addSubview()
        setupConstrains()
    }
    
    func addSubview() {
        [lbAuthorize,lbStatus,btAuthorize].forEach({
            self.addSubview($0)
        })
    }
    
    func setupConstrains(){
        NSLayoutConstraint.activate([
            lbAuthorize.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20),
            lbAuthorize.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lbStatus.topAnchor.constraint(equalTo: self.lbAuthorize.bottomAnchor, constant: 20),
            lbStatus.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            btAuthorize.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            btAuthorize.topAnchor.constraint(equalTo: self.lbStatus.bottomAnchor, constant: 20),
            btAuthorize.heightAnchor.constraint(equalToConstant: 50),
            btAuthorize.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}

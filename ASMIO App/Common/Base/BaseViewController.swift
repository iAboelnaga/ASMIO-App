//
//  BaseViewController.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import NVActivityIndicatorView
import Toast_Swift
import SafariServices

class BaseViewController: UIViewController {
    
    var containerView:UIView!
    var shopNowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupViewModel(viewModel: BaseViewModel) {
        
        viewModel.updateLoadingStatus = {[weak self] in
            guard let self = self else {return}
            self.dismissKeyBoard()
            switch viewModel.state {
            case .loading:
                self.showLoadingView()
            case .empty, .error,.populated:
                self.dismissLoadingView()
            }
        }
        
        viewModel.updateError = { [weak self] error in
            self?.dismissKeyBoard()
            self?.dismissLoadingView()
            self?.showAlert(message: error)
        }
    }
    
    func showLoadingView(){
        if containerView == nil {
            view.isUserInteractionEnabled = false
            containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(containerView)
            NSLayoutConstraint.activate([
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            containerView.backgroundColor = .clear
            let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .ballSpinFadeLoader, color: .darkGray, padding: 0)
            containerView.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            activityIndicator.startAnimating()
            containerView.updateConstraints()
        }
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.isUserInteractionEnabled = true
            if let _ = self.containerView {
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }
    
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {[weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    func showToast(message: String) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.view.makeToast(message, point: self.view.center, title: nil, image: nil, completion: nil)
        }
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
    
    func openSafariView(url: String) {
        guard let url = URL(string: url) else {return}
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .popover
        present(safariVC, animated: true)
    }
}

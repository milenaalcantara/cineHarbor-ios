import UIKit

class ViewController: UIViewController {
    private var count = 0
    
    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "0"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var counterButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.bordered()
        configuration.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.configuration = configuration
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.setTitle("Adicionar", for: .normal)
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func tappedButton() {
        counterLabel.text = String(Int(counterLabel.text ?? "0")! + 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(counterLabel)
        view.addSubview(counterButton)
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            counterButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            counterButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20)
        ])
    }
}


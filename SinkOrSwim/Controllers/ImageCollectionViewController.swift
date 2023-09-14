//
//  ImageCollectionViewController.swift
//  SinkOrSwim
//
//  Created by Ryan Sweeney on 9/13/23.
//

class ImageCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var hideImagesLabel: UILabel!
    var hideImagesSwitch: UISwitch!

    @IBOutlet weak var toggleSwitch: UISwitch!
    let imageNames = ["Image1.jpeg", "Image2.jpeg", "Image3.jpeg", "Image4.jpeg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupHideImagesUI()
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white

        // Registering our custom cell
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        self.view.addSubview(collectionView)

        // Constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @IBAction func toggleSwitchChanged(_ sender: UISwitch) {
        collectionView.isHidden = !sender.isOn
    }
    
    // MARK: - UICollectionViewDataSource methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout methods

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 30) / 2, height: 150) // adjust as needed
    }
    
    func setupHideImagesUI() {
        // Initialize the label
        hideImagesLabel = UILabel()
        hideImagesLabel.translatesAutoresizingMaskIntoConstraints = false
        hideImagesLabel.text = "Hide Images"
        hideImagesLabel.textAlignment = .right
        
        // Initialize the switch
        hideImagesSwitch = UISwitch()
        hideImagesSwitch.translatesAutoresizingMaskIntoConstraints = false
        hideImagesSwitch.addTarget(self, action: #selector(toggleImages(_:)), for: .valueChanged)
        
        // Add them to the view
        view.addSubview(hideImagesLabel)
        view.addSubview(hideImagesSwitch)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            // Position the label to the left bottom of the view, with some margin
            hideImagesLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            hideImagesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            // Position the switch to the right of the label, with some space between them
            hideImagesSwitch.centerYAnchor.constraint(equalTo: hideImagesLabel.centerYAnchor),
            hideImagesSwitch.leadingAnchor.constraint(equalTo: hideImagesLabel.trailingAnchor, constant: 10),
            hideImagesSwitch.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    @objc func toggleImages(_ sender: UISwitch) {
        collectionView.isHidden = sender.isOn
    }
}

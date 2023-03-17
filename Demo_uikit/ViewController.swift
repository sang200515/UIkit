import UIKit

struct Item {
    let title: String
    let subtitle: String
}

class ViewController: UIViewController {

    private let items: [Item] = [
        Item(title: "Item 1", subtitle: "Subtitle 1"),
        Item(title: "Item 2", subtitle: "Subtitle 2"),
        Item(title: "Item 3", subtitle: "Subtitle 3"),
        Item(title: "Item 4", subtitle: "Subtitle 4"),
        Item(title: "Item 5", subtitle: "Subtitle 5")
    ]

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UICollectionViewListCell Demo"
        view.addSubview(collectionView)
    }

    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .firstItemInSection
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewListCell
        let item = items[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.secondaryText = item.subtitle
        cell.contentConfiguration = content
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(indexPath.row)")
    }
}

extension ViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // Implement prefetching logic here
        for indexPath in indexPaths {
            let item = items[indexPath.row]
            // Perform any necessary data loading for the item
        }
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        // Implement cancel prefetching logic here
        for indexPath in indexPaths {
            let item = items[indexPath.row]
            // Cancel any ongoing data loading for the item
        }
    }
}

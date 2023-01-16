//
//  ImageGalleryViewController.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/12/23.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    
    //    static var reuseIdentifier: String {
    //        return String(describing: self)
    //    }
    
//    var images: [ImageView] {
//        get {
//            var images = [ImageView]()
//            tempImages.forEach { item in
//                let tempImage = UIImage(named: item)
//                let imageView = ImageView()
//                imageView.backgroundImage = tempImage
//                images.append(imageView)
//            }
//            return images
//        }
//        set {
//
//        }
//    }
    
    lazy var images: [ImageView] = {
        var images = [ImageView]()
        tempImages.forEach { item in
            let tempImage = UIImage(named: item)
            let imageView = ImageView()
            imageView.backgroundImage = tempImage
            images.append(imageView)
        }
        return images
    }()
    
    var tempImages = "picTest3 picTest1 picTest4 picTest5 picTest6 picTest7 picTest8".components(separatedBy: " ")
    
    
    @IBOutlet weak var imageGalleryCollectionView: UICollectionView! {
        didSet {
            imageGalleryCollectionView.dataSource = self
            imageGalleryCollectionView.delegate = self
            imageGalleryCollectionView.dropDelegate = self
            imageGalleryCollectionView.dragDelegate = self
        }
    }
}

//MARK: - UICollectionViewDataSource

extension ImageGalleryViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifire, for: indexPath)
        guard let imageCell = cell as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        print(tempImages)
//        let tempImg = UIImage(named: tempImages[indexPath.item])
        let img = images[indexPath.item].backgroundImage ?? UIImage()
        
        imageCell.cellImageView.image = img
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ImageGalleryViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDragDelegate

extension ImageGalleryViewController: UICollectionViewDragDelegate
{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItem(at: indexPath)
    }
    
    private func dragItem(at indexPath: IndexPath) -> [UIDragItem] {
        guard let image = (imageGalleryCollectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell)?.cellImageView.image else {
            return []
        }
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: image))
        dragItem.localObject = images[indexPath.item]
        return [dragItem]
    }
}

//MARK: - UICollectionViewDropDelegate

extension ImageGalleryViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self) || session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
        return UICollectionViewDropProposal(operation: isSelf ? .move : .copy, intent: .insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        
        for item in coordinator.items {
            guard let sourceIndexPath = item.sourceIndexPath else {
                handleDropFromGlobalSource(with: item, usingCoordinator: coordinator)
                continue
            }
            guard let localImage = item.dragItem.localObject as? ImageView else { continue }
            collectionView.performBatchUpdates({
                images.remove(at: sourceIndexPath.item)
                images.insert(localImage, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            })
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
    private func handleDropFromGlobalSource(with item: UICollectionViewDropItem, usingCoordinator coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        let placeHolder = coordinator.drop(item.dragItem, to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: ImageCollectionViewCellPlaceholder.identifire))
        
        item.dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { provider, error in
            guard let image = provider as? UIImage else {
                placeHolder.deletePlaceholder()
                return
            }
            let imageView = ImageView()
            imageView.backgroundImage = image
            
            DispatchQueue.main.async {
                placeHolder.commitInsertion(dataSourceUpdates: { insertionIndexPath in
                    self.images.insert(imageView, at: insertionIndexPath.item)
                })
            }
        })
    }
}



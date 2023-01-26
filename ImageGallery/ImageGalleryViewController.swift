//
//  ImageGalleryViewController.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/12/23.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    
    var imageCells = [ImageCollectionViewCell]()
    var scaleFactor: CGFloat = 1.0
    
    func setImageFrom(url: URL, to imageCell: ImageCollectionViewCell)
    {
        imageCell.cellURL = url
        DispatchQueue.global(qos: .userInitiated).async
        {
            let urlContent = try? Data(contentsOf: url.imageURL)
            DispatchQueue.main.async {
                guard let imageData = urlContent else {
                    return
                }
                if url == imageCell.cellURL! {
                    imageCell.backgroundImageOfCell = UIImage(data: imageData)
                    imageCell.spinner.isHidden = true
                    imageCell.spinner.stopAnimating()
                }
            }
        }
    }
    
    @IBOutlet weak var imageGalleryCollectionView: UICollectionView! {
        didSet {
            imageGalleryCollectionView.dataSource = self
            imageGalleryCollectionView.delegate = self
            imageGalleryCollectionView.dropDelegate = self
            imageGalleryCollectionView.dragDelegate = self
            addImageGalleryGestureRecognizers(to: imageGalleryCollectionView)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension ImageGalleryViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifire, for: indexPath)
        guard let imageCell = cell as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        imageCell.backgroundImageOfCell = nil
        imageCell.spinner.isHidden = false
        imageCell.spinner.startAnimating()
        
        let url = imageCells[indexPath.item].cellURL!
        
        setImageFrom(url: url, to: imageCell)

        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ImageGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath)
//        performSegue(withIdentifier: "ShowImageVC", sender: cell)
    }
}

//MARK: - UICollectionViewDragDelegate

extension ImageGalleryViewController: UICollectionViewDragDelegate
{
    func collectionView(_ collectionView: UICollectionView,
                        itemsForBeginning session: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItem(at: indexPath)
    }
    
    private func dragItem(at indexPath: IndexPath) -> [UIDragItem] {
        guard let image = (imageGalleryCollectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell)?.backgroundImageOfCell else {
            return []
        }
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: image))
        dragItem.localObject = imageCells[indexPath.item]
        return [dragItem]
    }
}

//MARK: - UICollectionViewDropDelegate

extension ImageGalleryViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) || session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        dropSessionDidUpdate session: UIDropSession,
                        withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
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
            collectionView.performBatchUpdates({
                let removedImgCell = imageCells.remove(at: sourceIndexPath.item)
                imageCells.insert(removedImgCell, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            })
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
    private func handleDropFromGlobalSource(with item: UICollectionViewDropItem,
                                            usingCoordinator coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        let placeHolder = coordinator.drop(item.dragItem, to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: ImageCollectionViewCellPlaceholder.identifire))
        let newCell = ImageCollectionViewCell(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 40.0, height: 40)))
        
        imageCells.insert(newCell, at: destinationIndexPath.item)
        
        coordinator.session.loadObjects(ofClass: UIImage.self, completion: { image in
                // review option of setting image to weak (in case some one will want to delete image before it arrives )
            if let image = image.first as? UIImage {
                self.imageCells[destinationIndexPath.item].cellAspectRatio = image.size
            }
        })
        
        item.dragItem.itemProvider.loadObject(ofClass: NSURL.self, completionHandler: { provider, error in
                DispatchQueue.main.async {
                    guard let url = provider as? URL else {
                        placeHolder.deletePlaceholder()
                        return
                    }
                    placeHolder.commitInsertion(dataSourceUpdates: { insertionIndexPath in
                        self.imageCells[destinationIndexPath.item].cellURL = url
                    })
                }
        })
        
//        var dropURL: URL?
//        var dropImage: UIImage?
//
//        coordinator.session.loadObjects(ofClass: NSURL.self, completion: { nsurls in
//            if let url = nsurls.first as? URL {
//                dropURL = url
//            }
//        })
//
//        coordinator.session.loadObjects(ofClass: UIImage.self, completion: { images in
//            if let image = images.first as? UIImage {
//                dropImage = image
//            }
//        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageGalleryCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ImageGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellAspectRatio = imageCells[indexPath.item].cellAspectRatio
        let scaledSize = CGSize(width: cellAspectRatio.width * scaleFactor, height: cellAspectRatio.height * scaleFactor)
        return scaledSize
    }
}

//MARK: - Navigation

extension ImageGalleryViewController {
    
    enum ImageGallerySegue: String {
        case ShowImageVC
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let identifire = segue.identifier, let identifireCase = ImageGallerySegue(rawValue: identifire) else {
            assertionFailure("Could not map segue identifire to segue case")
            return
        }
        
        switch identifireCase {
        case .ShowImageVC:
            let cell = sender as! ImageCollectionViewCell
            let imageVC = segue.destination as! ImageVC
            imageVC.galleryImage.image = cell.backgroundImageOfCell
        }
    }
}



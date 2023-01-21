//
//  ImageGalleryViewController.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/12/23.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    

    var tempUrlsAsStrings = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPrN0rmO5TlRkVdpz4Y-ym8xB9yYUU8Fwfvg&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS82ROPGcUBOizk31m3W1OVakOo1RRlXh-yEA&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKg3ve4wM9ZNy-FPJ4S2LxASucPaH57PbfZQ&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYh0dMZq18g3xSco7n-dsyhekXVicR3Dopdg&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8LJdN1R98_jJFVPCooDoOqdD6NWP8vewcFw&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSPKRlvxP3Pch5U-3oXmCauiRDijZlCdgefw&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi9xihd0nO4aWFUK1JGMC4eRU7GFTflBA_Fw&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe8j0iVXO8RihNEwnb3lUOBrdxl_3wBn6-Hg&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaP9bvKbY45GrSc5gS_iutR9nzC9AAZBkrug&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlxFrFT5BFY0dFGKs90j-6ZZRsCtf9dZ6Z6w&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSugcLjiCtIIzwiTzN4D_oLovr-PrzWm5At-g&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBIIFPQ5s_P-6mnhOksYSP1tQN8qurk46uWQ&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN5Ex1e135k30oPb5kr9GHJQBLHRjGqtwLvA&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_MnnTBf0RKBroxkzRvU2InbCMj-Gx4LrxSQ&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiud57TpquWYu0I3E25USadwk4gcBPkUpG0A&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT23-ulZkbYTy_K0E0ygp34_KLLeCHy8HsagQ&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpRkblkHkt6Xfj8moxjx7ku1w3XLpyjYBVCQ&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL3XJYedB7Hz92MqDboX4fjQrc3HRkb1XTYQ&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPrN0rmO5TlRkVdpz4Y-ym8xB9yYUU8Fwfvg&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0F9Ll2DELpUsi2l5uV1reMwCM_gr4I6XCxA&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo23dpRAob9UGJ75gAiOzrOHFFeiYdMb_Dzg&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNP_CFttFN2gCRR7FkPV6ducxk43dBYKtzkg&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT23-ulZkbYTy_K0E0ygp34_KLLeCHy8HsagQ&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiud57TpquWYu0I3E25USadwk4gcBPkUpG0A&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_MnnTBf0RKBroxkzRvU2InbCMj-Gx4LrxSQ&usqp=CAU",
                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb-p_iGKXM5uK9wxaq6jcaR6etbJWQnQoCPA&usqp=CAU",]
    
    lazy var links: [URL] = {
        var urls = [URL]()
//        tempUrlsAsStrings.forEach { url in
//            var tempUrl = URL(string: url)
//            urls.append(tempUrl!)
//        }
        return urls
    }()
    
    var cellComponents = [CellComponent]()
    
    var imageCells = [ImageCollectionViewCell]()
    
    var originalCellSizes: [CGSize] = []
    
    private var cellSize: CGSize?
    
    private var cellAspectRatio: CGSize? {
        get {
            return cellSize ?? CGSize()
        }
        set {
            guard let cellWidth = newValue?.width, let cellHeight = newValue?.height else {
                return
            }
            let preferredCellWidth = 300.0
            var preferredCellHeight = CGSize().height
            
            let ratio = round((cellWidth / cellHeight) * 100) / 100
            preferredCellHeight = round((preferredCellWidth / ratio) * 100) / 100
            cellSize = CGSize(width: preferredCellWidth, height: preferredCellHeight)
        }
    }
   
    @IBOutlet weak var imageGalleryCollectionView: UICollectionView! {
        didSet {
            imageGalleryCollectionView.dataSource = self
            imageGalleryCollectionView.delegate = self
            imageGalleryCollectionView.dropDelegate = self
            imageGalleryCollectionView.dragDelegate = self
        }
    }
    
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
                    imageCell.cellImageView.image = UIImage(data: imageData)
                    imageCell.spinner.isHidden = true
                    imageCell.spinner.stopAnimating()
                }
            }
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
        imageCell.cellImageView.image = nil
        imageCell.spinner.isHidden = false
        imageCell.spinner.startAnimating()
        
        let url = imageCells[indexPath.item].cellURL!
        
//        let url = self.links[indexPath.item]
        setImageFrom(url: url, to: imageCell)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ImageGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
//        assert(indexPath.item < originalCellSizes.count, "originalCellSizes count should not be less then indexPath. Check if cellSize was added on drop")
//        guard indexPath.item < originalCellSizes.count else {
//            return cellAspectRatio ?? CGSize.zero
//        }
        return imageCells[indexPath.item].cellAspectRatio
//        return originalCellSizes[indexPath.item]
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
        dragItem.localObject = imageCells[indexPath.item]
        return [dragItem]
    }
}

//MARK: - UICollectionViewDropDelegate

extension ImageGalleryViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) || session.canLoadObjects(ofClass: UIImage.self)
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
            collectionView.performBatchUpdates({
                let removedImgCell = imageCells.remove(at: sourceIndexPath.item)
                imageCells.insert(removedImgCell, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            })
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
    private func handleDropFromGlobalSource(with item: UICollectionViewDropItem, usingCoordinator coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        let placeHolder = coordinator.drop(item.dragItem, to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: ImageCollectionViewCellPlaceholder.identifire))
        
        imageCells.insert(ImageCollectionViewCell(), at: destinationIndexPath.item)
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
                            // consider option of refacturing links and originalSize in one object
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
}



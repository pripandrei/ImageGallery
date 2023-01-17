//
//  ImageGalleryViewController.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/12/23.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    
//    lazy var images: [ImageView] = {
//        var images = [ImageView]()
//        tempImages.forEach { item in
//            let tempImage = UIImage(named: item)
//            let imageView = ImageView()
//            imageView.backgroundImage = tempImage
//            images.append(imageView)
//        }
//        return images
//    }()
    
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
    
    var tempImages = "picTest3 picTest1 picTest4 picTest5 picTest6 picTest7 picTest8".components(separatedBy: " ")
    
    lazy var links: [URL] = {
        var urls = [URL]()
        tempUrlsAsStrings.forEach { url in
            var tempUrl = URL(string: url)
            urls.append(tempUrl!)
        }
        return urls
    }()
    
//    var links = [URL]()
    
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
//        print(links.count)
        return links.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifire, for: indexPath)
        guard let imageCell = cell as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        imageCell.cellImageView.image = nil
        
        DispatchQueue.global(qos: .userInitiated).async {
            let url = self.links[indexPath.item]
        
            imageCell.cellURL = url
            let urlContent = try? Data(contentsOf: url.imageURL)
            
            DispatchQueue.main.async {
                guard let imageData = urlContent else {
                    return
                }
                if url == imageCell.cellURL! {
                    imageCell.cellImageView.image = UIImage(data: imageData)
                }
            }
        }
        
//        let tempImg = UIImage(named: tempImages[indexPath.item])
//        let img = images[indexPath.item].backgroundImage ?? UIImage()
//
//        imageCell.cellImageView.image = img
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
        dragItem.localObject = links[indexPath.item]
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
            guard let localURL = item.dragItem.localObject as? URL else { continue }
            collectionView.performBatchUpdates({
                links.remove(at: sourceIndexPath.item)
                links.insert(localURL, at: destinationIndexPath.item)
//                images.remove(at: sourceIndexPath.item)
//                images.insert(localImage, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            })
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
    private func handleDropFromGlobalSource(with item: UICollectionViewDropItem, usingCoordinator coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        let placeHolder = coordinator.drop(item.dragItem, to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: ImageCollectionViewCellPlaceholder.identifire))
        
        item.dragItem.itemProvider.loadObject(ofClass: NSURL.self, completionHandler: { provider, error in
                DispatchQueue.main.async {
                    guard let url = provider as? URL else {
                        placeHolder.deletePlaceholder()
                        return
                    }
                    print("URL:", url)
//                    let imageView = ImageView()
//                    imageView.cellUrl = url
//                    self.links.append(url)
//                    self.imageNumber += 1
                    placeHolder.commitInsertion(dataSourceUpdates: { insertionIndexPath in
//                        self.images.insert(imageView, at: insertionIndexPath.item)
                        self.links.insert(url, at: insertionIndexPath.item)
                    })
                }
        })
    }
}



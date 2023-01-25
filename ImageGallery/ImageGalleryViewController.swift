//
//  ImageGalleryViewController.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/12/23.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    

//    var tempUrlsAsStrings = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPrN0rmO5TlRkVdpz4Y-ym8xB9yYUU8Fwfvg&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS82ROPGcUBOizk31m3W1OVakOo1RRlXh-yEA&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKg3ve4wM9ZNy-FPJ4S2LxASucPaH57PbfZQ&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYh0dMZq18g3xSco7n-dsyhekXVicR3Dopdg&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8LJdN1R98_jJFVPCooDoOqdD6NWP8vewcFw&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSPKRlvxP3Pch5U-3oXmCauiRDijZlCdgefw&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi9xihd0nO4aWFUK1JGMC4eRU7GFTflBA_Fw&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe8j0iVXO8RihNEwnb3lUOBrdxl_3wBn6-Hg&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaP9bvKbY45GrSc5gS_iutR9nzC9AAZBkrug&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlxFrFT5BFY0dFGKs90j-6ZZRsCtf9dZ6Z6w&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSugcLjiCtIIzwiTzN4D_oLovr-PrzWm5At-g&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBIIFPQ5s_P-6mnhOksYSP1tQN8qurk46uWQ&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN5Ex1e135k30oPb5kr9GHJQBLHRjGqtwLvA&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_MnnTBf0RKBroxkzRvU2InbCMj-Gx4LrxSQ&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiud57TpquWYu0I3E25USadwk4gcBPkUpG0A&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT23-ulZkbYTy_K0E0ygp34_KLLeCHy8HsagQ&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpRkblkHkt6Xfj8moxjx7ku1w3XLpyjYBVCQ&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL3XJYedB7Hz92MqDboX4fjQrc3HRkb1XTYQ&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPrN0rmO5TlRkVdpz4Y-ym8xB9yYUU8Fwfvg&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0F9Ll2DELpUsi2l5uV1reMwCM_gr4I6XCxA&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo23dpRAob9UGJ75gAiOzrOHFFeiYdMb_Dzg&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNP_CFttFN2gCRR7FkPV6ducxk43dBYKtzkg&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT23-ulZkbYTy_K0E0ygp34_KLLeCHy8HsagQ&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiud57TpquWYu0I3E25USadwk4gcBPkUpG0A&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_MnnTBf0RKBroxkzRvU2InbCMj-Gx4LrxSQ&usqp=CAU",
//                             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb-p_iGKXM5uK9wxaq6jcaR6etbJWQnQoCPA&usqp=CAU",]
//
//    lazy var links: [URL] = {
//        var urls = [URL]()
////        tempUrlsAsStrings.forEach { url in
////            var tempUrl = URL(string: url)
////            urls.append(tempUrl!)
////        }
//        return urls
//    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    var imageCells = [ImageCollectionViewCell]()
    var scaleFactor: CGFloat = 1.0

    @IBOutlet weak var imageGalleryCollectionView: UICollectionView! {
        didSet {
            imageGalleryCollectionView.dataSource = self
            imageGalleryCollectionView.delegate = self
            imageGalleryCollectionView.dropDelegate = self
            imageGalleryCollectionView.dragDelegate = self
            addImageGalleryGestureRecognizers(to: imageGalleryCollectionView)
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
//        imageCell.cellImageView.image = nil
//        imageCell.cellImageView = UIImageView()
        imageCell.spinner.isHidden = false
        imageCell.spinner.startAnimating()
        print(imageCells[indexPath.item].cellImageView)
        let url = imageCells[indexPath.item].cellURL!
        print(imageCell.cellImageView.image)
        imageCell.cellImageView.image = imageCells[indexPath.item].cellBackgroundImg
        imageCell.spinner.isHidden = true
        imageCell.spinner.stopAnimating()
        
        let jpegData = imageCell.cellImageView.image!.jpegData(compressionQuality: 1.0)
        let jpegSize: Int = jpegData?.count ?? 0
        print("size of jpeg image in KB: %f ", Double(jpegSize) / 1024.0)
//        if imageCells[indexPath.item].cellImageView.image == nil {
//
//            setImageFrom(url: url, to: imageCell)
//        }
        
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ImageGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
        let cellFromImages = imageCells[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "ShowImageVC", sender: cellFromImages)
    }
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
        let newCell = ImageCollectionViewCell()
        
        imageCells.insert(newCell, at: destinationIndexPath.item)
        
        coordinator.session.loadObjects(ofClass: UIImage.self, completion: { image in
                // review option of setting image to weak (in case some one will want to delete image before it arrives )
            if let image = image.first as? UIImage {
                self.imageCells[destinationIndexPath.item].cellAspectRatio = image.size
                self.imageCells[destinationIndexPath.item].cellBackgroundImg = image
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
//        assert(indexPath.item < originalCellSizes.count, "originalCellSizes count should not be less then indexPath. Check if cellSize was added on drop")
//        guard indexPath.item < originalCellSizes.count else {
//            return cellAspectRatio ?? CGSize.zero
//        }
    
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
//        let index = imageGalleryCollectionView.indexPathsForSelectedItems?.first
//        let tempCel = imageGalleryCollectionView.cellForItem(at: index!) as? ImageCollectionViewCell
        switch identifireCase {
        case .ShowImageVC:
            let cell = sender as! ImageCollectionViewCell
            let imageVC = segue.destination as! ImageVC
//            imageVC.tempIMG = (tempCel?.cellBackgroundImg)!
            imageVC.galleryImage.image = cell.cellBackgroundImg
        }
    }
}



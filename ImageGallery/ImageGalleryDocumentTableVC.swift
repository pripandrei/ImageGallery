//
//  ImageGalleryDocumentTableVC.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/31/23.
//

import UIKit

struct GalleryDocument
{
    static var identifire = 0
    
    var ID: Int
    var title: String
    var documentComponent = [CellComponents()]
    
    private static func generateUniqueId() -> Int  {
        identifire += 1
        return identifire
    }
    
    init(title: String) {
        self.title = title
        self.ID = GalleryDocument.generateUniqueId()
    }
}

class ImageGalleryDocumentTableVC: UITableViewController {
    
    var indexOfpreviousSelectedRow: Int?

    var documents = [GalleryDocument]()

//    var galleryDocument = ["Item","Item 1","Item 2"]
    
    var splitViewDetailImageGalleryVC: ImageGalleryViewController? {
        return splitViewController?.viewControllers.last?.contents as? ImageGalleryViewController
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if  splitViewController?.preferredDisplayMode != .oneOverSecondary {
            splitViewController?.preferredDisplayMode = .oneOverSecondary
        }
    }
    
    @IBAction func addImageGallery(_ sender: UIBarButtonItem) {
//        galleryDocument += ["Item".madeUnique(withRespectTo: galleryDocument)]
        let title = makeUniqueTitle()
        documents.append(GalleryDocument(title: title))
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTableCell.identifire, for: indexPath) as? DocumentTableCell else {
            fatalError("Unable to dequeu reusable cell")
        }
        
        cell.id = indexPath.row
        cell.textLabel?.text = documents[indexPath.row].title
        
        return cell
    }
    
    // MARK: - Table view Delegate

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
}

// MARK: - Navigation
extension ImageGalleryDocumentTableVC {
    
    enum GalleryDcoumentSegue: String {
        case ShowImageGalleryVC
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifire = segue.identifier, let identifireCase = GalleryDcoumentSegue(rawValue: identifire) else {
            fatalError("Could not map segue identifire to segue case")
        }
        
        switch identifireCase {
        case .ShowImageGalleryVC:
            guard let imageGalleryVC = segue.destination.contents as? ImageGalleryViewController else {
                return
            }
            let cell = sender as! DocumentTableCell
            if let currentimageGalleryVC = splitViewDetailImageGalleryVC  {
                if indexOfpreviousSelectedRow == nil {
                    // By default, when first time images are dragged, they will be set to first item in tableView.
                    // Change 0 to cell.id if you desire to explicitly select item in tableView for saving images in to
                    // however, a good idea in this case will be blocking of drag before creating at least one item in table view
                    // and selecting it
                    indexOfpreviousSelectedRow = 0
                }
//                else {
                    documents[indexOfpreviousSelectedRow!].documentComponent = currentimageGalleryVC.cellComponents
                    indexOfpreviousSelectedRow = cell.id
//                }
            }
            // id will always be present here, as long as it is set in cellForRowAt function
            // so we can safely unwrap! here
            imageGalleryVC.cellComponents = documents[cell.id!].documentComponent
        }
    }
}


// MARK: - Helpers

extension ImageGalleryDocumentTableVC {
    
    private func makeUniqueTitle() -> String {
        let initialTitle = "Item"
        var possiblyUnique = initialTitle
        var uniqueNumber = 1
        
        documents.forEach { document in
            if document.title == possiblyUnique {
                possiblyUnique = initialTitle + " \(uniqueNumber)"
                uniqueNumber += 1
            }
        }
        return possiblyUnique
    }
}


// in prepareForSegue function i can access imageGalerryVC and append collected components from there in the documents array, and also there, i can check if sender as index is already in documents array, if so skipp adding, if it's not add docComppnent

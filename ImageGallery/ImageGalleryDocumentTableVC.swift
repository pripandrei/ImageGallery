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
    var title: String?
    var documentComponents = [CellComponents()]
    
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
    
    private var previousDocumentID: Int?

    private var documents = [GalleryDocument]()
    
    private var splitViewDetailImageGalleryVC: ImageGalleryViewController? {
        return splitViewController?.viewControllers.last?.contents as? ImageGalleryViewController
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if  splitViewController?.preferredDisplayMode != .oneOverSecondary {
            splitViewController?.preferredDisplayMode = .oneOverSecondary
        }
    }
    
    @IBAction func addImageGallery(_ sender: UIBarButtonItem) {
        let title = makeUniqueTitle()
        documents.append(GalleryDocument(title: title))
        tableView.reloadData()
    }
    

    // MARK: - TableViewDataSource

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
        
//        cell.id = indexPath.row
        cell.textLabel?.text = documents[indexPath.row].title
        
        return cell
    }
    
    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if let currentimageGalleryVC = splitViewDetailImageGalleryVC  {
            if previousDocumentID == nil {
                // By default, when first time images are drpped, they will be set to first item in tableView.
                // Remove this block if you desire to explicitly select item in tableView for saving images in to
                // however, a good idea in this case will be blocking of drag before creating at least one item in table view
                previousDocumentID = 1
            }
            for (index,document) in documents.enumerated() {
                if document.ID == self.previousDocumentID {
                    documents[index].documentComponents = currentimageGalleryVC.cellComponents
                }
            }
        }
        performSegue(withIdentifier: GalleryDcoumentSegue.ShowImageGalleryVC.rawValue, sender: indexPath)
    }
    
    // MARK: - Cell deletion
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            documents.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
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
            let index = (sender as! IndexPath).row
            imageGalleryVC.cellComponents = documents[index].documentComponents
            previousDocumentID = documents[index].ID
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

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

class ImageGalleryDocumentTableVC: UITableViewController,UISplitViewControllerDelegate {
    
    private var previousDocumentID: Int?

    private var documents: [[GalleryDocument]] = [[]]
    
    private var splitViewDetailImageGalleryVC: ImageGalleryViewController? {
        return splitViewController?.viewControllers.last?.contents as? ImageGalleryViewController
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if  splitViewController?.preferredDisplayMode != .secondaryOnly {
            splitViewController?.preferredDisplayMode = .secondaryOnly
        }
    }

    @IBAction func addImageGallery(_ sender: UIBarButtonItem) {
        let title = makeUniqueTitle()
        documents[0].append(GalleryDocument(title: title))
        tableView.reloadData()
    }
    
    var deletedDocuments = [GalleryDocument]()
    
    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return documents.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents[section].count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTableCell.identifire, for: indexPath) as? DocumentTableCell else {
            fatalError("Unable to dequeu reusable cell")
        }
        cell.textLabel?.text = documents[indexPath.section][indexPath.row].title
        return cell
    }
    
    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if let currentimageGalleryVC = splitViewDetailImageGalleryVC, indexPath.section == 0 {
            if previousDocumentID == nil {
                // By default, when first time images are dropped, they will be set to first item in tableView.
                // Remove this block if you desire to explicitly select item in tableView for saving images in to
                // however, a good idea in this case will be blocking of drag before creating at least one item in table view
                previousDocumentID = 1
            }
            for (index,document) in documents[0].enumerated() {
                if document.ID == self.previousDocumentID {
                    documents[0][index].documentComponents = currentimageGalleryVC.cellComponents
                }
            }
            performSegue(withIdentifier: GalleryDcoumentSegue.ShowImageGalleryVC.rawValue, sender: indexPath)
        }
    }
    
    // MARK: - Cell deletion
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, complitionHandler in
            guard let self = self else { return }
            
            let removedDocument = self.documents[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            self.handleDeletion(of: removedDocument, at: indexPath)
            tableView.reloadData()
            complitionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        if indexPath.section == 1 {
            let recoverAction = UIContextualAction(style: .normal, title: "Recover", handler: { [weak self] _, _, complitionHandler in
                guard let self = self else { return }
                
                let recoveredDocument = self.documents[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
//                recoveredDocument.title = self.makeUniqueTitle()
//                self.documents[0].insert(recoveredDocument, at: recoveredDocument.ID - 1)
                self.documents[0].append(recoveredDocument)
                
                // TODO: incoroprat this is a more elegant way
                if indexPath.section == 1, self.documents[1].count == 0 {
                    self.documents.remove(at: 1)
                }
                tableView.reloadData()
                complitionHandler(true)
            })
            recoverAction.backgroundColor = .green
            
            let configuration = UISwipeActionsConfiguration(actions: [recoverAction])
            return configuration
        }
            return UISwipeActionsConfiguration(actions: [])
    }
    
    
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let removedDocument = documents[indexPath.section].remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//            handleDeletion(of: removedDocument, at: indexPath)
//            tableView.reloadData()
//        }
//    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Recently Deleted"
        }
        return ""
    }
    
    private func handleDeletion(of document: GalleryDocument, at indexPath: IndexPath) {
        if indexPath.section == 0 {
            if documents.count == 1 {
                documents.append([document])
            } else {
                documents[1].append(document)
            }
        }
        if indexPath.section == 1, documents[1].count == 0 {
            documents.remove(at: 1)
        }
    }
    
}

//extension Array where Self == [GalleryDocument] {
//    mutating func customRemove(at index: Int) -> Element {
//        let removedElement = self.remove(at: index)
//
//        if self.count == 0 {
//            remove(at: 1)
//        }
//        return removedElement
//    }
//}

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
            let rowIndex = (sender as! IndexPath).row
            let sectionIndex = (sender as! IndexPath).section
            imageGalleryVC.cellComponents = documents[sectionIndex][rowIndex].documentComponents
            previousDocumentID = documents[sectionIndex][rowIndex].ID
        }
    }
}

// MARK: - Helpers

extension String {
    func madeUnique(withRespectTo otherStrings: [String]) -> String {
        var possiblyUnique = self
        var uniqueNumber = 1
        
        
        while otherStrings.contains(possiblyUnique) {
            possiblyUnique = self + " \(uniqueNumber)"
            uniqueNumber += 1
        }
        return possiblyUnique
    }
}

extension ImageGalleryDocumentTableVC {
    
    private func makeUniqueTitle() -> String {
        let initialTitle = "Item"
        var possiblyUnique = initialTitle
        var uniqueNumber = 1
        var combinedDocs: [GalleryDocument]?
        
        combinedDocs = documents.count > 1 ? documents[0] + documents[1] : documents[0]
        while combinedDocs!.contains(where: { $0.title == possiblyUnique}) {
            possiblyUnique = initialTitle + " \(uniqueNumber)"
            uniqueNumber += 1
        }
        
//        let sortedDocs = combinedDocs != nil ? combinedDocs!.sorted(by: { $0.title!.extractNumber() < $1.title!.extractNumber() }) : documents[0].sorted(by: { $0.title!.extractNumber() < $1.title!.extractNumber() })
////        let sortedDocs = documents[0].sorted(by: { $0.ID < $1.ID })
//
////        if let last = sortedDocs.last?.ID {
////            possiblyUnique = "Item \(last)"
////        }
//
//        for document in sortedDocs {
////            document in
//            if document.title == possiblyUnique {
//                possiblyUnique = initialTitle + " \(uniqueNumber)"
//                uniqueNumber += 1
//            } else {
//                break
//            }
//        }
//
//        repeat {
       //            uniqueNumber += 1
       //            possiblyUnique = initialTitle + " \(uniqueNumber)"
       //            duplicateTitle = documents[0].contains(where: { $0.title == possiblyUnique })
       //        } while duplicateTitle == true

               // We sort this array couse at some point a doc with a title can be deleted and then added again
       //        // which will go to the end and not to the index it was before deletion
       //        var combined: [GalleryDocument]?
       //        if documents.count > 1 {
       //            combined = documents[0] + documents[1]
       //        }
       //        combined = documents.count > 1 ? documents[0] + documents[1] : nil
       //        combined = combined != nil ? combined!.sorted(by: { $0.ID < $1.ID }) : documents[0].sorted(by: { $0.ID < $1.ID })
//        possiblyUnique = "\(sortedDocs.last!.ID + 1)"
//        for document in sortedDocs {
//            if document.ID >= uniqueNumber {
//                possiblyUnique = "Item \(document.ID + 1)"
//                uniqueNumber += 1
//            }
//        }
    
        return possiblyUnique
    }
}

extension String {
    func extractNumber() -> Int {
        guard let number = Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) else {
           return 0
        }
        return number
    }
}


//let initialTitle = "Item"
//var possiblyUnique = initialTitle
//if let id = documents[0].last?.ID {
//    possiblyUnique = initialTitle + " \(id)"
//}


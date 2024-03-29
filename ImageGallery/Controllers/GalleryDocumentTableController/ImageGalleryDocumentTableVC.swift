//
//  ImageGalleryDocumentTableVC.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/31/23.
//

import UIKit

class ImageGalleryDocumentTableVC: UITableViewController,UISplitViewControllerDelegate {
    
    private let defaults = UserDefaults(suiteName: "com.eiedeesehighiokkkjhu76iujh3ru.com")!
    
    private var previousDocumentID: Int?

    private var documents: [[GalleryDocument]] = [[]]
    
    private var indexPathsForSelectedRows: [IndexPath]?
    
    private var splitViewDetailImageGalleryVC: ImageGalleryViewController? {
        return splitViewController?.viewControllers.last?.contents as? ImageGalleryViewController
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if  splitViewController?.preferredDisplayMode != .secondaryOnly {
            splitViewController?.preferredDisplayMode = .secondaryOnly
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
        
        if let savedDocument = defaults.object(forKey: Keys.document) as? Data {
            if let loadedDocument = try? decoder.decode([[GalleryDocument]].self, from: savedDocument) {
                documents = loadedDocument
            }
        }
    }
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    
    @IBAction func addImageGallery(_ sender: UIBarButtonItem) {
        let title = makeUniqueTitle()
        documents[0].append(GalleryDocument(title: title))
        tableView.reloadData()
        
        if let encoded = try? encoder.encode(documents) {
            defaults.setValue(encoded, forKey: Keys.document)
        }
    }
    
    var deletedDocuments = [GalleryDocument]()
    
    private var indexPathOfCellToBeEdited: IndexPath?
    
    
    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return documents.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents[section].count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == indexPathOfCellToBeEdited {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextEditingCell.identifire, for: indexPath) as? TextFieldTableViewCell else {
                fatalError("Unable to dequeu reusable TextEditingCell")
            }
            cell.textField.text = documents[0][indexPath.row].title
            
            cell.resignationHandler = { [weak self, unowned cell] in
                if let text = cell.textField.text {
                    self?.documents[0][indexPath.row].title = text
                }
                self?.indexPathOfCellToBeEdited = nil
                self?.tableView.reloadData()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTableCell.identifire, for: indexPath) as? DocumentTableCell else {
                fatalError("Unable to dequeu reusable DocumentTableCell")
            }
            
            cell.imageGalleryDocumentTableVC = self
            cell.textLabel?.text = documents[indexPath.section][indexPath.row].title
            tableView.selectRow(at: indexPathsForSelectedRows?.first, animated: false, scrollPosition: .none)
            return cell
        }
    }

    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let textFieldCell = cell as? TextFieldTableViewCell {
            textFieldCell.textField.becomeFirstResponder()
        }
    }
    
    // Keeps selected row after editing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if !editing {
            indexPathsForSelectedRows?.forEach { tableView.selectRow(at: $0, animated: true, scrollPosition: .none) }
        }
    }
    
    // MARK: - Gestures
    
    @objc func handleSingleCellTap() {
        print("tapped once")
        
        guard let indexPath = tableView.indexPathsForSelectedRows?.first else {
            return
        }
        indexPathsForSelectedRows = [indexPath]
        
        if let currentimageGalleryVC = splitViewDetailImageGalleryVC, indexPath.section == 0 {
            if previousDocumentID == nil {
                // By default, when first time images are dropped, they will be set to first item in tableView.
                // Remove this block if you desire to explicitly select item in tableView for saving images in to
                // however, a good idea in this case will be blocking of drag&drop before creating at least one item in table view
                previousDocumentID = 1
            }
            for (index,document) in documents[0].enumerated() {
                if document.ID == self.previousDocumentID {
                    documents[0][index].documentComponents = currentimageGalleryVC.cellComponents
                }
            }
        }
        performSegue(withIdentifier: GalleryDcoumentSegue.ShowImageGalleryVC.rawValue, sender: nil)
    }
    
    @objc func handleDoubleCellTap() {
        print("tapped twice")
        indexPathOfCellToBeEdited = tableView.indexPathsForSelectedRows?.first
        tableView.reloadData()
    }
    
    // MARK: - Cell deletion
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, complitionHandler in
            guard let self = self else { return }
            
            let removedDocument = self.documents[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            self.handleDeletion(of: removedDocument, at: indexPath)
            
            // Handles row selection after deletion
            self.indexPathsForSelectedRows?.forEach { index in
                if indexPath.row == index.row {
                    self.indexPathsForSelectedRows = nil
                } else {
                    self.indexPathsForSelectedRows![0] = IndexPath(item: indexPath.row > index.row ? index.row : index.row - 1, section: indexPath.section)
                }
            }
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
                self.documents[0].append(recoveredDocument)
                
                // TODO: incoroprat this in a more elegant way
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
        } else if documents[1].count == 0 {
            documents.remove(at: 1)
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
            if let row = tableView.indexPathsForSelectedRows?.first?.row,
               let section = tableView.indexPathsForSelectedRows?.first?.section {
                imageGalleryVC.cellComponents = documents[section][row].documentComponents
                previousDocumentID = documents[section][row].ID
            }
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
        return possiblyUnique
    }
}

// MARK: - User default keys

struct Keys {
    static let document = "document"
}

//extension String {
//    func extractNumber() -> Int {
//        guard let number = Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) else {
//           return 0
//        }
//        return number
//    }
//}


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

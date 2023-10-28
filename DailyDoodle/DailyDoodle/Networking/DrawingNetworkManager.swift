//
//  DrawingNetworkManager.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/27/23.
//

import FirebaseFirestore
import FirebaseAuth
import SwiftUI

struct FireBaseDrawingConstants {
    static let drawingsCollectionPath = "Drawing"
    
    static let color = "color"
    static let width = "width"
    static let x = "x"
    static let y = "y"
    static let points = "points"
    static let lines = "lines"
    static let identifier = "id"
}

class DrawingNetworkManager {
    static let shared = DrawingNetworkManager()
    
    private let db = Firestore.firestore()
    
    func saveDrawing(drawing: Drawing) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let drawingCollection = db.collection(FireBaseUserConstants.usersCollectionPath).document(userID).collection(FireBaseDrawingConstants.drawingsCollectionPath)
        let newDrawingDocument = drawingCollection.document()
        let drawingDictionary = drawingToDictionary(drawing: drawing)
        
        newDrawingDocument.setData(drawingDictionary) { error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                print("Drawing Data Saved!")
            }
        }
    }
    
    func retrieveDrawingsWith(drawingIDs: [String], completionHandler: @escaping ([Drawing]?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {completionHandler(nil); return }
        let drawingCollection = db.collection(FireBaseUserConstants.usersCollectionPath).document(userID).collection(FireBaseDrawingConstants.drawingsCollectionPath)
        
        drawingCollection.whereField(FieldPath.documentID(), in: drawingIDs).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting user data: \(error.localizedDescription)")
                completionHandler(nil)
                return
            } else {
                var drawings: [Drawing] = []
                guard let documents = querySnapshot?.documents else { completionHandler(nil); return }
                for document in documents{
                    let data = document.data()
                    guard let drawing = self.dictionaryToDrawing(dictionary: data) else { continue }
                    drawings.append(drawing)
                }
                completionHandler(drawings)
                return
            }
        }
    }
    
    private func drawingToDictionary(drawing: Drawing) -> [String: Any] {
        var linesArray = [[String: Any]]()
        for line in drawing.lines {
            var lineDict = [String: Any]()
            lineDict[FireBaseDrawingConstants.color] = line.color.description
            lineDict[FireBaseDrawingConstants.width] = line.width
            var pointsArray = [[String: Any]]()
            for point in line.points {
                let pointDict: [String: Any] = [
                    FireBaseDrawingConstants.x: point.x,
                    FireBaseDrawingConstants.y: point.y
                ]
                pointsArray.append(pointDict)
            }
            lineDict[FireBaseDrawingConstants.points] = pointsArray
            linesArray.append(lineDict)
        }
        return [FireBaseDrawingConstants.identifier: drawing.id.uuidString, FireBaseDrawingConstants.lines: linesArray]
    }
    
    private func dictionaryToDrawing(dictionary: [String: Any]) -> Drawing? {
        var lines = [Line]()
        guard let identifier = dictionary[FireBaseDrawingConstants.identifier] as? String,
              let lineDictionary = dictionary[FireBaseDrawingConstants.lines] as? [[String: Any]] else { return nil }
        for lineEntry in lineDictionary {
            guard let colorDescription = lineEntry[FireBaseDrawingConstants.color] as? String,
                  let pointsArray = lineEntry[FireBaseDrawingConstants.points] as? [[String: Any]],
                  let width = lineEntry[FireBaseDrawingConstants.width] as? CGFloat else { continue }
            let color = Color(colorDescription)
            var points = [CGPoint]()
            for pointData in pointsArray {
                guard let x = pointData[FireBaseDrawingConstants.x] as? Double,
                      let y = pointData[FireBaseDrawingConstants.y] as? Double else { continue }
                let point = CGPoint(x: x, y: y)
                points.append(point)
            }
            let line = Line(color: color, points: points, width: width)
        }
        guard let uuid = UUID(uuidString: identifier) else { return nil }
        return Drawing(id: uuid, lines: lines)
    }
}

//
//  MetronomeData.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/6/11.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import Foundation


enum TempoMarkings: String, CaseIterable {
    case Prestississimo
//    case Prestissimo
//    case Prestissimetto
//    case Allegrissimo
    case Presto
    case Vivace
//    case AllegroAssai = "Allegro Assai"
    case Allegro
//    case AllegroModerato = "Allegro Moderato"
    case Allegretto
    case Moderato
    case Andantino
    case Andante
//    case Adagietto
    case Adagio
//    case Grave
//    case Larghetto
    case Lento
    case Largo
//    case Lentissimo
//    case Larghissimo
    static let tempoArray = TempoMarkings.allCases.map { $0.rawValue }
}

class MetronomeDataController {
//    static let tempoArray = TempoMarkings.allCases.map { $0.rawValue }
    static var tempoStatus: TempoMarkings = .Andante
    static var currentBPM: Int = 70
    static let topNum = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    static let bottomNum = [1, 2, 4, 8, 16]
    static var currentTimeSig = [4, 4]

    
    static func speedConverter() {
        switch MetronomeDataController.tempoStatus {
        case .Prestississimo:
            MetronomeDataController.currentBPM = 200
        case .Presto:
            MetronomeDataController.currentBPM = 180
        case .Vivace:
            MetronomeDataController.currentBPM = 156
        case .Allegro:
            MetronomeDataController.currentBPM = 130
        case .Allegretto:
            MetronomeDataController.currentBPM = 104
        case .Moderato:
            MetronomeDataController.currentBPM = 90
        case .Andantino:
            MetronomeDataController.currentBPM = 76
        case .Andante:
            MetronomeDataController.currentBPM = 70
        case .Adagio:
            MetronomeDataController.currentBPM = 54
        case .Lento:
            MetronomeDataController.currentBPM = 50
        case .Largo:
            MetronomeDataController.currentBPM = 43
        }
    }
    
    func markingConverter() {
        switch MetronomeDataController.currentBPM {
        case 200...260:
            MetronomeDataController.tempoStatus = .Prestississimo
        case 169...199:
            MetronomeDataController.tempoStatus = .Presto
        case 155...168:
            MetronomeDataController.tempoStatus = .Vivace
        case 118...143:
            MetronomeDataController.tempoStatus = .Allegro
        case 98...117:
            MetronomeDataController.tempoStatus = .Allegretto
        case 84...97:
            MetronomeDataController.tempoStatus = .Moderato
        case 74...83:
            MetronomeDataController.tempoStatus = .Andantino
        case 63...73:
            MetronomeDataController.tempoStatus = .Andante
        case 53...62:
            MetronomeDataController.tempoStatus = .Adagio
        case 47...52:
            MetronomeDataController.tempoStatus = .Lento
        case 30...46:
            MetronomeDataController.tempoStatus = .Largo
        default:
            MetronomeDataController.tempoStatus = .Allegro
        }
    }
    
}


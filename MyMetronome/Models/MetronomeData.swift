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
    static let tempoMarkingsArray = TempoMarkings.allCases.map { $0.rawValue }
}

struct MetronomeDataController {
//    static let tempoArray = TempoMarkings.allCases.map { $0.rawValue }
    static var currentTempoMarking: TempoMarkings = .Andante
    static var currentBPM: Int = 70
    static let topNum = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    static let bottomNum = [1, 2, 4, 8, 16]
    static var currentTimeSig = [4, 4]

    
    static func speedConverter() {
        switch MetronomeDataController.currentTempoMarking {
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
    
    static func markingConverter() {
        switch MetronomeDataController.currentBPM {
        case 200...260:
            MetronomeDataController.currentTempoMarking = .Prestississimo
        case 169...199:
            MetronomeDataController.currentTempoMarking = .Presto
        case 155...168:
            MetronomeDataController.currentTempoMarking = .Vivace
        case 118...143:
            MetronomeDataController.currentTempoMarking = .Allegro
        case 98...117:
            MetronomeDataController.currentTempoMarking = .Allegretto
        case 84...97:
            MetronomeDataController.currentTempoMarking = .Moderato
        case 74...83:
            MetronomeDataController.currentTempoMarking = .Andantino
        case 63...73:
            MetronomeDataController.currentTempoMarking = .Andante
        case 53...62:
            MetronomeDataController.currentTempoMarking = .Adagio
        case 47...52:
            MetronomeDataController.currentTempoMarking = .Lento
        case 30...46:
            MetronomeDataController.currentTempoMarking = .Largo
        default:
            MetronomeDataController.currentTempoMarking = .Allegro
        }
    }
    
}


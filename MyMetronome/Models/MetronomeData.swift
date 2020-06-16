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
    static var tempoStatus: TempoMarkings = .Andante
    static var currentSpeed: Int = 70

    
    static func speedConverter() {
        switch MetronomeDataController.tempoStatus {
        case .Prestississimo:
            MetronomeDataController.currentSpeed = 200
        case .Presto:
            MetronomeDataController.currentSpeed = 180
        case .Vivace:
            MetronomeDataController.currentSpeed = 156
        case .Allegro:
            MetronomeDataController.currentSpeed = 130
        case .Allegretto:
            MetronomeDataController.currentSpeed = 104
        case .Moderato:
            MetronomeDataController.currentSpeed = 90
        case .Andantino:
            MetronomeDataController.currentSpeed = 76
        case .Andante:
            MetronomeDataController.currentSpeed = 70
        case .Adagio:
            MetronomeDataController.currentSpeed = 54
        case .Lento:
            MetronomeDataController.currentSpeed = 50
        case .Largo:
            MetronomeDataController.currentSpeed = 43
        }
    }
    
    func markingConverter() {
        switch MetronomeDataController.currentSpeed {
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


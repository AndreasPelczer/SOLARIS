//
//  RandomOracle.swift
//  SOLARA
//
//  Created by Andreas Pelczer on 09.02.26.
//


import Foundation

struct RandomOracle {
    func randomPopup() -> String {
        SolaraPhrases.popups.randomElement() ?? "Ich fühle: Es ist… irgendwas."
    }

    func hardNo() -> String {
        SolaraPhrases.hardNoReasons.randomElement() ?? "Nein."
    }
}

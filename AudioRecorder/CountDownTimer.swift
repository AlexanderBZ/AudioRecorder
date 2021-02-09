//
//  CountDownTimer.swift
//  AudioRecorder
//
//  Created by Alexander Zwerner on 1/28/21.
//

import SwiftUI

class CountDownTimer: ObservableObject {

    @Published var counter: CGFloat = 10

    let interval = 0.25

    var timer: Timer?

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { _ in
            self.counter -= 0.25

            if self.counter <= 0 {
            self.timer?.invalidate()
            self.timer = nil
          }
        })
    }

    func stop() {
        self.timer?.invalidate()
    }
}

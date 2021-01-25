//
//  TestScheduler.swift
//  SignIn
//
//  Created by Aaron Connolly on 1/11/21.
//

import Combine

final class TestScheduler<SchedulerTimeType, SchedulerOptions>:
    Scheduler where SchedulerTimeType: Strideable,
                    SchedulerTimeType.Stride: SchedulerTimeIntervalConvertible {
    var now: SchedulerTimeType
    
    var minimumTolerance: SchedulerTimeType.Stride = 0
    
    private var scheduled: [(action: () -> Void, date: SchedulerTimeType)] = []
    
    init(now: SchedulerTimeType) {
        self.now = now
    }
    
    func advance(by stride: SchedulerTimeType.Stride = .zero) {
        self.now = self.now.advanced(by: stride)
        for (action, date) in self.scheduled {
            // only executes items that went into the past after striding forward time
            if date <= self.now {
                action()
            }
        }
        
        self.scheduled.removeAll(where: { $0.date <= self.now })
    }
    
    // Schedule some work to be done as soon as possible
    func schedule(
        options _: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) {
        self.scheduled.append((action, self.now))
    }
    
    // Schedule some work to be done after some delay
    func schedule(
        after date: SchedulerTimeType,
        tolerance _: SchedulerTimeType.Stride,
        options _: SchedulerOptions?,
        _ action: @escaping () -> Void) {
        self.scheduled.append((action, date))
    }
    
    // Scheudule some work on a repeating interval
    func schedule(
        after date: SchedulerTimeType,
        interval: SchedulerTimeType.Stride,
        tolerance _: SchedulerTimeType.Stride,
        options _: SchedulerOptions?,
        _ action: @escaping () -> Void) -> Cancellable {
        return AnyCancellable {}
    }
}

import Dispatch

extension DispatchQueue {
    static var testScheduler:  TestScheduler<SchedulerTimeType, SchedulerOptions> {
        TestScheduler(now: .init(.init(uptimeNanoseconds: 1)))
    }
}

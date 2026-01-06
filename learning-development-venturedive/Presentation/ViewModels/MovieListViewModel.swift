//
//  MovieListViewModel.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import Foundation
import Combine

public extension DispatchQueue {
    func eraseToAnyScheduler() -> AnySchedulerOf<DispatchQueue> {
        AnySchedulerOf(self)
    }
}

public struct AnySchedulerOf<S: Scheduler>: Scheduler {
    public typealias SchedulerTimeType = S.SchedulerTimeType
    public typealias SchedulerOptions = S.SchedulerOptions

    private let _now: () -> S.SchedulerTimeType
    private let _minimumTolerance: () -> S.SchedulerTimeType.Stride
    private let _schedule: (S.SchedulerTimeType, S.SchedulerTimeType.Stride?, @escaping () -> Void) -> Void
    private let _scheduleAfter: (S.SchedulerTimeType, S.SchedulerTimeType.Stride, @escaping () -> Void) -> Void
    private let _scheduleInterval: (S.SchedulerTimeType, S.SchedulerTimeType.Stride, S.SchedulerTimeType.Stride, @escaping () -> Void) -> Cancellable

    private let base: S

    public init(_ base: S) {
        self.base = base
        _now = { base.now }
        _minimumTolerance = { base.minimumTolerance }
        _schedule = { date, _, action in base.schedule(after: date, tolerance: base.minimumTolerance, options: nil, action) }
        _scheduleAfter = { date, tolerance, action in base.schedule(after: date, tolerance: tolerance, options: nil, action) }
        _scheduleInterval = { date, interval, tolerance, action in base.schedule(after: date, interval: interval, tolerance: tolerance, options: nil, action) }
    }

    public var now: S.SchedulerTimeType { _now() }
    public var minimumTolerance: S.SchedulerTimeType.Stride { _minimumTolerance() }

    public func schedule(options: S.SchedulerOptions?, _ action: @escaping () -> Void) {
        base.schedule(options: options, action)
    }

    public func schedule(after date: S.SchedulerTimeType, tolerance: S.SchedulerTimeType.Stride, options: S.SchedulerOptions?, _ action: @escaping () -> Void) {
        _scheduleAfter(date, tolerance, action)
    }

    public func schedule(after date: S.SchedulerTimeType, interval: S.SchedulerTimeType.Stride, tolerance: S.SchedulerTimeType.Stride, options: S.SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
        _scheduleInterval(date, interval, tolerance, action)
    }
}

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var query: String = ""
    @Published private(set) var state: State = .idle
    @Published private(set) var items: [Film] = []
    @Published private(set) var filtered: [Film] = []

    enum State: Equatable {
        case idle
        case loading
        case loaded
        case error(String)
    }

    private let getFilms: GetFilmsUseCase
    private var cancellables: Set<AnyCancellable> = []

    // New injectable scheduler and debounce
    private let scheduler: AnySchedulerOf<DispatchQueue>
    private let debounce: DispatchQueue.SchedulerTimeType.Stride

    // Keep existing init by adding defaulted params so call sites don’t change.
    init(
        getFilms: GetFilmsUseCase,
        scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler(),
        debounce: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(400)
    ) {
        self.getFilms = getFilms
        self.scheduler = scheduler
        self.debounce = debounce
        bindSearch()
    }

    func onAppear() {
        Task { await load() }
    }

    func load() async {
        state = .loading
        do {
            let films = try await getFilms.execute()
            self.items = films
            self.state = .loaded
            applyFilter()
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }

    private func bindSearch() {
        $query
            .debounce(for: debounce, scheduler: scheduler)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.applyFilter()
            }
            .store(in: &cancellables)
    }

    private func applyFilter() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            filtered = items
            return
        }
        let lower = trimmed.lowercased()
        filtered = items.filter { film in
            film.title.lowercased().contains(lower) ||
            film.originalTitle.lowercased().contains(lower) ||
            film.director.lowercased().contains(lower)
        }
    }
}

//
//  VersionViewReactor.swift
//  Zero
//
//  Created by Jairo Eli de Leon on 7/3/17.
//  Copyright © 2017 Jairo Eli de León. All rights reserved.
//

import ReactorKit
import RxSwift

final class VersionViewReactor: Reactor {
  enum Action {
    case checkForUpdates
  }

  enum Mutation {
    case setLoading(Bool)
    case setLatestVersion(String?)
  }

  struct State {
    var isLoading: Bool = false
    var currentVersion: String = Bundle.main.version ?? "0.0.0"
    var latestVersion: String?
  }

  let provider: ServiceProviderType
  let initialState = State()

  init(provider: ServiceProviderType) {
    self.provider = provider
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .checkForUpdates:
      let startLoading: Observable<Mutation> = .just(.setLoading(true))
      let clearLatestVersion: Observable<Mutation> = .just(.setLatestVersion(nil))
      let setLatestVersion: Observable<Mutation> = self.provider.appStoreService.latestVersion()
        .asObservable()
        .map { $0 ?? "⚠️" }
        .map(Mutation.setLatestVersion)
      let stopLoading: Observable<Mutation> = .just(.setLoading(false))
      return Observable.concat([startLoading, clearLatestVersion, setLatestVersion, stopLoading])
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case let .setLoading(isLoading):
      state.isLoading = isLoading
      return state

    case let .setLatestVersion(latestVersion):
      state.latestVersion = latestVersion
      return state
    }
  }
}

// MigrationMocks.swift
// Copyright (C) 2020 Presidenza del Consiglio dei Ministri.
// Please refer to the AUTHORS file for more information.
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

// swiftlint:disable superfluous_disable_command force_try implicitly_unwrapped_optional force_unwrapping force_cast

import Foundation
import Katana
@testable import StorePersistence

struct MockStateA: State, Codable, Equatable {
  var aVariable: Int = 0
}

struct MockStateC: State, Codable, Equatable {
  var aVariable: Int = 0
}

class MockMigrationManager<S: Codable & State>: PersistStoreMigrationManager<S> {
  var migrations: [(MigrationID, MigrationHandler)] = []
  var errorHandler: (_ error: Error, _ state: RawState, _ context: DecodingErrorContext) -> ErrorHandlingType = { _, _, _ in
    .abort
  }

  override func registerMigrations(migrator: PersistStoreMigrator) {
    self.migrations.forEach {
      migrator.registerMigration(named: $0.0, handler: $0.1)
    }
  }
}

//
//  Result+.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-02-01.
//

import Foundation

extension Result where Success == Void {
  /// A success, without passing `Void` explicitly as a the `Success` value.
  @_transparent
  public static var success: Result<Success, Failure> {
    return .success(())
  }
}

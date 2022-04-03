/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import RocketLaunches

class RocketLaunchesTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

//  func testGetAllCapsules() async throws {
//    let all = try await SpaceXAPI.getAllCapsules()
//    for item in all {
//      print("capsule is \(item)")
//    }
//  }
//
//  func testGetAllCores() async {
//    do {
//      let all = try await SpaceXAPI.getAllCores()
//      for item in all {
//        print("core is \(item.id)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllCrew() async {
//    do {
//      let all = try await SpaceXAPI.getAllCrew()
//      for item in all {
//        print("crew is \(item.name!)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllDragons() async throws {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    // Any test you write for XCTest can be annotated as throws and async.
//    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    do {
//      let allDragons = try await SpaceXAPI.getAllDragons()
//      for dragon in allDragons {
//        print("dragon is \(dragon.name)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }

  func testGetAllLaunches() async throws {
    do {
      let all = try await SpaceXAPI.getAllLaunches()
      for item in all {
        print("launch is \(item.name)")
      }
    } catch {
      print("error \(error)")
    }
  }

//  func testGetAllLaunchPads() async throws {
//    do {
//      let all = try await SpaceXAPI.getAllLaunchPads()
//      for item in all {
//        print("launchpad is \(item.name)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllPayload() async throws {
//    do {
//      let all = try await SpaceXAPI.getAllPayloads()
//      for item in all {
//        print("payload is \(item.name!)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllRocket() async throws {
//    do {
//      let all = try await SpaceXAPI.getAllRockets()
//      for item in all {
//        print("rocket is \(item.name)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
//
//  func testGetAllShips() async throws {
//    do {
//      let all = try await SpaceXAPI.getAllShips()
//      for item in all {
//        print("ship is \(item.name)")
//      }
//    } catch {
//      print("error \(error)")
//    }
//  }
}

import XCTest
@testable import PlaylistKata

final class PlaylistKataTests: XCTestCase {

	let track1 = Track(id: 0, title: "Track1", duration: 1)
	let track2 = Track(id: 1, title: "Track2", duration: 1)
	let track3 = Track(id: 3, title: "Track3", duration: 1)

	let user = User(id: 0, username: "user", isPro: false)
	let proUser = User(id: 0, username: "proUser", isPro: true)

	func test_playlistTotalDuration() {
		let sut = Playlist(tracks: [track1, track2, track3], user: user)

		XCTAssertEqual(sut.totalDuration, 3)
	}

	func test_tracksCount() {
		let sut = Playlist(tracks: [track1, track2, track3], user: user)

		XCTAssertEqual(sut.tracks.count, 3)
	}

	func test_addTrackToPlaylist() {
		var sut = Playlist(tracks: [], user: user)
		XCTAssertEqual(sut.tracksCount, 0)
		try! sut.add(track: track1)

		XCTAssertEqual(sut.tracksCount, 1)
	}

	func test_addTuplicateTrackToPlaylist() {
		var sut = Playlist(tracks: [track1, track2, track3], user: user)

		XCTAssertThrowsError(try sut.add(track: track1)) { error in
			XCTAssertEqual(error as? PlaylistErrorCode, PlaylistErrorCode.duplicateTrack)
		}
	}

	func test_maximumTracksCountReachedForRegularUser() {
		let tracks = createMaxNumberTracks(for: user)
		var sut = Playlist(tracks: tracks, user: user)
		XCTAssertThrowsError(try sut.add(track: track1)) { error in
			XCTAssertEqual(error as? PlaylistErrorCode, PlaylistErrorCode.maximumNumberReached)
		}
	}

	func test_maximumTracksCountReachedForProUser() {
		let tracks = createMaxNumberTracks(for: proUser)
		var sut = Playlist(tracks: tracks, user: proUser)
		XCTAssertThrowsError(try sut.add(track: track1)) { error in
			XCTAssertEqual(error as? PlaylistErrorCode, PlaylistErrorCode.maximumNumberReached)
		}
	}

	func test_removeTrackFromPlaylistWhenPlaylistIsEmpty() {
		var sut = Playlist(tracks: [track1], user: user)
		sut.deleteTrack(with: track1.id)

		XCTAssertFalse(sut.tracks.contains(where: { $0.id == track1.id }))
	}

	private func createMaxNumberTracks(for user: User) -> [Track] {
		var i = 0
		var tracks = [Track]()
		while i < user.maxTracksCountInPlaylist {
			let track = Track(id: i, title: "Track \(i)", duration: 1)
			tracks.append(track)
			i += 1
		}
		return tracks
	}
}


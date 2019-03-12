import XCTest
@testable import PlaylistKata

final class PlaylistKataTests: XCTestCase {

	let track1 = Track(id: 0, title: "Track1", duration: 1)
	let track2 = Track(id: 1, title: "Track2", duration: 1)
	let track3 = Track(id: 3, title: "Track3", duration: 1)

	let maxTrackCountInPlaylist = 2

	func test_playlistTotalDuration() {
		let sut = Playlist(tracks: [track1, track2, track3])

		XCTAssertEqual(sut.totalDuration, 3)
	}

	func test_tracksCount() {
		let sut = Playlist(tracks: [track1, track2, track3])

		XCTAssertEqual(sut.tracks.count, 3)
	}

	func test_addTrackToPlaylist() {
		var sut = Playlist(tracks: [])
		XCTAssertEqual(sut.tracksCount, 0)
		sut.add(track: track1)

		XCTAssertEqual(sut.tracksCount, 1)
	}

	func test_addTuplicateTrackToPlaylist() {
		var sut = Playlist(tracks: [track1, track2, track3])
		XCTAssertEqual(sut.tracks.count, 3)
		sut.add(track: track2)

		XCTAssertEqual(sut.tracksCount, 3)
	}

	func test_maximumTracksCountReachedForProUser() {
		var sut = Playlist(tracks: [track1, track2])
		sut.add(track: track3)

		XCTAssert(sut.tracksCount == maxTrackCountInPlaylist, "You excideed maximum number")
	}

	func test_maximumTracksCountReachedForRegularUser() {
		var sut = Playlist(tracks: [track1, track2])
		sut.add(track: track3)

		XCTAssert(sut.tracksCount == maxTrackCountInPlaylist, "You excideed maximum number")
	}

	func test_removeTrackFromPlaylistWhenPlaylistIsEmpty() {
		var sut = Playlist(tracks: [track1])
		sut.deleteTrack(with: track1.id)

		XCTAssertFalse(sut.tracks.contains(where: { $0.id == track1.id }))
	}
}

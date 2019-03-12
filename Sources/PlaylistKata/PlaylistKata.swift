
struct PlaylistKata {

}

enum PlaylistErrors: Int {
	case duplicateTrack = 100
	case maximumNumberReached = 101
}

enum PlaylistMaxTracksCount: Int {
	case proUser = 200
	case user = 100
}

struct Track {
	var id: Int
	var title: String
	var duration: Double
}

struct User {
	var id: Int
	var username: String
	var isPro: Bool
	var playlists: [Playlist]
}

struct Playlist {
	private(set) var tracks: [Track]

	var tracksCount: Int {
		return tracks.count
	}

	var totalDuration: Double {
		return tracks.reduce(0, {$0 + $1.duration} )
	}

	//todo make this with throw which will log error codes
	mutating func add(track: Track) {

		// how mock this enum to test with less numbers?

		if tracks.count == PlaylistMaxTracksCount.user.rawValue {
			return
		}
		guard tracks.contains(where: {$0.id == track.id }) else {
			tracks.append(track)
			return
		}
	}

	mutating func deleteTrack(with id: Int) {
		tracks.removeAll(where: { $0.id == id })
	}
}

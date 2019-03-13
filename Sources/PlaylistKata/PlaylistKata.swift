
enum PlaylistErrorCode: Int, Error  {
	case duplicateTrack = 100
	case maximumNumberReached = 101

	var description: String {
		switch self {
		case .duplicateTrack:
			return ("ErrorCode \(self.rawValue): Track already is in playlist")
		case .maximumNumberReached:
			return ("ErrorCode \(self.rawValue): You reached maximum tracks limit")
		}
	}
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
	var maxTracksCountInPlaylist: Int {
		return isPro ? 200 : 100
	}
}

struct Playlist {
	private(set) var tracks: [Track]
	let user: User

	var tracksCount: Int {
		return tracks.count
	}

	var totalDuration: Double {
		return tracks.reduce(0, {$0 + $1.duration} )
	}

	mutating func add(track: Track) throws {
		if tracksCount == user.maxTracksCountInPlaylist {
			print(PlaylistErrorCode.maximumNumberReached.description)
			throw PlaylistErrorCode.maximumNumberReached
		}
		if tracks.contains(where: {$0.id == track.id }) {
			print(PlaylistErrorCode.duplicateTrack.description)
			throw PlaylistErrorCode.duplicateTrack
		}
		tracks.append(track)
	}

	mutating func deleteTrack(with id: Int) {
		tracks.removeAll(where: { $0.id == id })
	}
}

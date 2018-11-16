//
//  MMPlayerItem.swift
//  MMPlayerView
//
//  Created by Millman on 2018/11/16.
//

import UIKit
import AVFoundation

protocol MMPlayerItemProtocol: class {
    func status(change: AVPlayerItem.Status)
    func isPlaybackKeepUp(isKeepUp: Bool)
    func isPlaybackEmpty(isEmpty: Bool)
}

class MMPlayerItem: AVPlayerItem {
    var statusObservation: NSKeyValueObservation?
    var keepUpObservation: NSKeyValueObservation?
    var emptyObservation: NSKeyValueObservation?

    weak var delegate: MMPlayerItemProtocol?
    convenience init(asset: AVAsset, delegate: MMPlayerItemProtocol?) {
        self.init(asset: asset, automaticallyLoadedAssetKeys: nil)
        self.delegate = delegate
      
        statusObservation = self.observe(\.status, changeHandler: { (item, _) in
            self.delegate?.status(change: item.status)

        })
        keepUpObservation = self.observe(\.isPlaybackLikelyToKeepUp, changeHandler: { (item, change) in
            self.delegate?.isPlaybackKeepUp(isKeepUp: item.isPlaybackLikelyToKeepUp)
        })
        emptyObservation = self.observe(\.isPlaybackBufferEmpty, changeHandler: { (item, change) in
            self.delegate?.isPlaybackEmpty(isEmpty: item.isPlaybackBufferEmpty)
        })
    }
    
    deinit {
        print("MMPlayerItem deinit")
    }
}

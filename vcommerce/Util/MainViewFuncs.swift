//
//  MainViewFuncs.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/31.
//

import Foundation

func getURL(_ page : Int) -> String {
    var play_url =  "https://bit.ly/swswift"
    if page == 1 {
        play_url = "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8"
    } else if page == 2 {
        play_url = "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8"
    } else if page == 3 {
        play_url = "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8"
    }
    return play_url
}

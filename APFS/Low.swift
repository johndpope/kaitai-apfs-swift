//
//  Low.swift
//  SwiftKaitai
//
//  Created by Pope, John on 7/25/18.
//  Copyright © 2018 UXKit. All rights reserved.
//

import Foundation
//""" low level api methods to apfs """
//
//def get_nxsb_objects(nxsb):
//""" get entries of the container superblock """
//
//# get omap in container superblock

//
//# iterate omap
//return object_map_root.body.entries
//
//def get_apsb_objects(apsb):
//""" get entries of the volume superblock """
//
//object_map = apsb.body.omap_oid.target
//if object_map.hdr.type == 2 or object_map.hdr.type == 3:
//object_map_root = object_map
//else:
//object_map_root = object_map.body.root.target
//
//# iterate omap
//return object_map_root.body.entries


func getNxsbObjects(nxsb:ContainerSuperblock){//ContainerSuperblock???
    let objectMap = nxsb.omap_oid?.target
    print("objectMap:",objectMap.debugDescription)
//    if objectMap.hdr.type == 2 or object_map.hdr.type == 3:
//    object_map_root = object_map
//    else:
//    object_map_root = object_map.body.root.target
}

func getApsbObjects(apsb:ContainerSuperblock){
    
}

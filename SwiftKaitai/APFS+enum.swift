
//
//  APFSHelper.swift
//  SwiftKaitai
//
//  Created by Pope, John on 7/24/18.
//  Copyright © 2018 UXKit. All rights reserved.
//

import Foundation

extension Data {
    var bytes : [UInt8]{
        return [UInt8](self)
    }
}
//[bytes] to Data

extension Array where Element == UInt8 {
    var data : Data{
        return Data(bytes:(self))
    }
}


//extension Apfs{
    enum objType: Int {
        case obj_type_container_superblock = 1
        case obj_type_rootnode = 2
        case obj_type_node = 3
        case obj_type_space_manager = 5
        case obj_type_spaceman_internal_pool = 7
        case obj_type_btree = 11
        case obj_type_checkpoint = 12
        case obj_type_volume_superblock = 13
        case obj_type_reaper = 17
        case obj_type_18_unknown = 18
        case obj_type_32_unknown = 32
    }
    
    enum objSubtype: Int {
        
        case obj_subtype_empty = 0
        case obj_subtype_history = 9
        case obj_subtype_omap = 11
        case obj_subtype_files = 14
        case obj_subtype_extents = 15
        case obj_subtype_unknown = 16
    }
    enum tree_type: uint64 {
        case tree_type_om_tree = 0
        case tree_type_fs_tree = 1
    }
    
    enum features:Int,CustomStringConvertible{
        case features_case_insensitive = 1
        case features_unknown_type4 = 4
        case features_case_sensitive = 8
        
        public var description: String {
            switch self {
            case .features_case_insensitive:   return "case_insensitive"
            case .features_unknown_type4:   return "unknown_type4"
            case .features_case_sensitive:    return "case_sensitive"
            }
        }
    }
    
    
    enum encryption_types:Int,CustomStringConvertible {
        case enc_type_NotEncrypted = 1
        case enc_type_unknown2 = 2
        case enc_type_unknown4 = 4
        case enc_type_unknown8 = 8
        public var description: String {
            switch self {
            case .enc_type_NotEncrypted:   return "NotEncrypted"
            case .enc_type_unknown2:   return "unknown_2"
            case .enc_type_unknown4:    return "unknown_4"
            case .enc_type_unknown8:    return "unknown_8"
            }
            
        }
    }
    
    
    enum kind:uint,CustomStringConvertible{
        case  kind_omap = 0x0
        case  kind_lookup = 0x2
        case  kind_inode = 0x3
        case  kind_xattr = 0x4
        case  kind_sibling = 0x5
        case  kind_extent_refcount = 0x6
        case  kind_extent = 0x8
        case  kind_drec = 0x9
        case  kind_sibling_map = 0xc
        case  kind_unknown_d = 0xd
        
        public var description: String {
            switch self {
            case .kind_omap: return "kind_omap (0)"
            case .kind_lookup: return "kind_lookup (2)"
            case .kind_inode: return "kind_inode (3)"
            case .kind_xattr: return "kind_xattr (4)"
            case .kind_sibling: return "kind_sibling (5)"
            case .kind_extent_refcount: return "kind_extent_refcount (6)"
            case .kind_extent:  return "kind_extent (8)"
            case .kind_drec: return "kind_drec (9)"
            case .kind_sibling_map: return "kind_sibling_map (12)"
            default: return "Unknown"
            }
            
        }
    }
    
    
    
    enum  xfield_type:Int {
        case xfield_type_name = 516
        case xfield_type_size = 8200
        case xfield_type_document_id = 8707
        case xfield_type_device_node = 8718
        case xfield_type_sparse_size = 10253
        // Undiscoverd xfield_types,
        //   Dstream
        //   Dir_Stats_key
        //   Uuid
        //   Sparse_bytes
    }
    
    enum item_type:Int{
        case item_type_named_pipe = 1
        case item_type_character_special = 2
        case item_type_directory = 4
        case item_type_block_special = 6
        case item_type_regular = 8
        case item_type_symbolic_link = 10
        case item_type_socket = 12
        case item_type_whiteout = 14
    }
    
    enum ea_type:Int {
        case  ea_type_generic = 2
        case  ea_type_symlink = 6
    }
//}


//
//  Context.swift
//  QWUI
//
//  Created by Emilio Espinosa on 5/13/16.
//  Copyright © 2016 Emilio Espinosa. All rights reserved.
//

import XMod

// QWUContext class
// Description: Cairo context object. This object is responsible for holding the color and masks that will
// be applied to the surface.

public class QWUContext {
    
    let sfc: QWUSurface
    var cr: OpaquePointer
    
    init(target: QWUSurface) {
        let ptr = cairo_create(target.sfc)
        assert(ptr != nil, "Context is nil")
        
        cr = ptr!
        sfc = target
    }
    
    func destroy() {
        cairo_destroy(cr)
    }
    
    func status() -> Status {
        return Status(rawValue: cairo_status(cr).rawValue)!
    }
    
    func save() {
        cairo_save(cr)
    }
    
    func restore() {
        cairo_restore(cr)
    }
    
    func pushGroup(content: Content? = nil) {
        if let cont = content {
            cairo_push_group_with_content(cr, cairo_content_t(rawValue: cont.rawValue))
        } else {
            cairo_push_group(cr)
        }
    }
    
    func popGroup() -> QWUPattern {
        return QWUPattern(cairo_pop_group(cr))
    }
    
    func popGroupToSource() {
        cairo_pop_group_to_source(cr)
    }
    
    func setSourceColor(_ color: QWUColor) {
        cairo_set_source_rgba(cr, color.redVal, color.greenVal, color.blueVal, color.alpha)
    }
    
    func setSource(_ source: QWUPattern) {
        cairo_set_source(cr, source.patternPtr)
    }
    
    func paint() {
        cairo_paint(cr)
    }
}
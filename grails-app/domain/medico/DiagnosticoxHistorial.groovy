package medico

import audita.Auditable

class DiagnosticoxHistorial implements Auditable {

    Diagnostico diagnostico
    Historial historial
    String descripcion

    static mapping = {
        table 'ctdg'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'ctdg__id'
        id generator: 'identity'
        version false
        columns {
            diagnostico column: 'diag__id'
            historial column: 'hscl__id'
            descripcion column: 'ctdgdscr'
        }
    }

    static constraints = {
        diagnostico(blank: false, nullable: false)
        historial(blank: false, nullable: false)
        descripcion(size: 0..255, blank: true, nullable: true)
    }
}

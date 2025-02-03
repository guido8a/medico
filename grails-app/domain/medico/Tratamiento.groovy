package medico

import audita.Auditable

class Tratamiento implements Auditable{

    Historial historial
    Medicina medicina
    String descripcion
    int cantidad = 0
    int orden

    static mapping = {
        table 'trtm'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'trtm__id'
        id generator: 'identity'
        version false
        columns {
            historial column: 'hscl__id'
            medicina column: 'mdcn__id'
            descripcion column: 'trtmdscr'
            cantidad column: 'trtmcntd'
            orden column: 'trtmordn'
        }
    }

    static constraints = {
        historial(blank: false, nullable: false)
        medicina(blank: true, nullable: true)
        descripcion(size: 0..255, blank: false, nullable: false)
        cantidad(blank: true, nullable: true)
        orden(blank: true, nullable: true)
    }
}

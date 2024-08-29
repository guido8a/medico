package medico

import audita.Auditable

class Diagnostico implements Auditable{

    String codigo
    String descripcion

    static mapping = {
        table 'diag'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'diag__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'diagcdgo'
            descripcion column: 'diagdscr'
        }
    }

    static constraints = {
        codigo(size: 0..7, blank: false, nullable: false)
        descripcion(size: 0..255, blank: false, nullable: false)
    }
}

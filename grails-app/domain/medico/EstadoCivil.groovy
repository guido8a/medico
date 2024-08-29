package medico

import audita.Auditable

class EstadoCivil implements Auditable{

    String descripcion

    static mapping = {
        table 'edcv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'edcv__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'edcvdscr'
        }
    }

    static constraints = {
        descripcion(blank: false, nullable: false)
    }
}

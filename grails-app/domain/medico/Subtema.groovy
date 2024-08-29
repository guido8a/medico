package medico

import audita.Auditable

class Subtema implements Auditable{

    static auditable = true
    Tema tema
    String nombre

    static mapping = {
        table 'sbtm'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'sbtm__id'
            tema column: 'tema__id'
            nombre column: 'sbtmnmbr'
        }
    }

    static constraints = {
        tema(blank: false, nullable: false)
        nombre(blank: false, nullable: false, size: 3..63)
    }


}

package seguridad

import audita.Auditable

class TipoMedico implements Auditable{

    String codigo
    String descripcion

    static auditable = true

    static mapping = {
        table 'tpmd'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'

        columns {
            id column: 'tpmd__id'
            codigo column: 'tpmdcdgo'
            descripcion column: 'tpmddscr'
        }
    }

    static constraints = {
        codigo(blank: false, nullable: false, size: 0..4)
        descripcion(blank: false, nullable: false, size: 0..63)
    }
}

package medico

import audita.Auditable
import seguridad.Empresa

class Diagnostico implements Auditable{

    Empresa empresa
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
            empresa column: 'empr__id'
        }
    }

    static constraints = {
        empresa(blank: false, nullable: false)
        codigo(size: 0..7, blank: false, nullable: false)
        descripcion(size: 0..255, blank: false, nullable: false)
    }
}

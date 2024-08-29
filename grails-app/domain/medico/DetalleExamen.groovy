package medico

import audita.Auditable

class DetalleExamen implements Auditable {

    ExamenComplementario examenComplementario
    Examen examen

    static mapping = {
        table 'dtex'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dtex__id'
            examenComplementario column: 'excm__id'
            examen column: 'exam__id'
        }
    }

    static constraints = {
        examenComplementario(blank: false, nullable: false)
        examen(blank: false, nullable: false)
    }
}

package medico

class ExamenComplementario {

    Examen examen
    Historial historial
    Date fecha
    String path
    String observaciones

    static mapping = {
        table 'excm'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'excm__id'
            examen column: 'exam__id'
            historial column: 'hscl__id'
            fecha column: 'excmfcha'
            path column: 'excmpath'
            observaciones column: 'excmobsr'
        }
    }


    static constraints = {
        examen(blank: false, nullable: false)
        historial(blank: false, nullable: false)
        fecha(blank: true, nullable: true)
        path(blank: true, nullable: true, size: 0..255)
        observaciones(blank: true, nullable: true, size: 0..255)
    }
}

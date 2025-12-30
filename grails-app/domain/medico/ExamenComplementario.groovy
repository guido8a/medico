package medico

import audita.Auditable

class ExamenComplementario implements Auditable {

    TipoExamen tipoExamen
    Historial historial
    Date fecha
    String path
    String observaciones
    String datosClinicos
    String datosTipoExamen

    static mapping = {
        table 'excm'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'excm__id'
            tipoExamen column: 'tpex__id'
            historial column: 'hscl__id'
            fecha column: 'excmfcha'
            path column: 'excmpath'
            observaciones column: 'excmobsr'
            datosClinicos column: 'excmdtcl'
            datosTipoExamen column: 'excmdtte'
        }
    }

    static constraints = {
        tipoExamen(blank: false, nullable: false)
        historial(blank: false, nullable: false)
        fecha(blank: true, nullable: true)
        path(blank: true, nullable: true, size: 0..255)
        observaciones(blank: true, nullable: true, size: 0..511)
        datosClinicos(blank: true, nullable: true, size: 0..511)
        datosTipoExamen(blank: true, nullable: true, size: 0..511)
    }
}

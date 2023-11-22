package medico

class Tratamiento {

    Historial historial
    Medicina medicina
    String descripcion
    int cantidad = 0

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
        }
    }

    static constraints = {
        historial(blank: false, nullable: false)
        medicina(blank: true, nullable: true)
        descripcion(size: 0..255, blank: false, nullable: false)
        cantidad(blank: true, nullable: true)
    }
}

package medico

import seguridad.Empresa

class Documento {

    Empresa empresa
    String descripcion
    String clave
    String resumen
    String ruta

    static auditable = true

    static mapping = {
        table 'dcmt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dcmt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dcmt__id'
            empresa column: 'empr__id'
            descripcion column: 'dcmtdscr'
            clave column: 'dcmtclve'
            resumen column: 'dcmtrsmn'
            ruta column: 'dcmtruta'
        }
    }

    static constraints = {
        empresa(blank: false, nullable: false, attributes: [mensaje: 'Consultorio'])
        descripcion(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Descripción del documento'])
        clave(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Palabras clave'])
        resumen(size: 1..1024, blank: true, nullable: true, attributes: [mensaje: 'Resumen'])
        ruta(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Ruta del documento'])
    }
}

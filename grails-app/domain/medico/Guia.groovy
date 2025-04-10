package medico

class Guia {

    Base base
    String ruta

    static auditable = true

    static mapping = {
        table 'guia'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'guia__id'
        id generator: 'identity'
        version false

        columns {
            id column: 'guia__id'
            base column: 'base__id'
            ruta column: 'guiaruta'
        }
    }

    static constraints = {
         base(blank: false, nullable: false)
         ruta(blank: false, nullable: false, size: 0..255)
    }

}

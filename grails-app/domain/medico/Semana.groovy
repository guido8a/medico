package medico

import audita.Auditable

class Semana implements Auditable{

    int numero
    Date fechaInicio
    Date fechaFin

    static auditable = true

    static mapping = {
        table 'smna'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'smna__id'
            numero column: 'smnanmro'
            fechaInicio column: 'smnafcin'
            fechaFin column: 'smnafcfn'
        }
    }
    static constraints = {
        numero(blank: false, nullable: false)
        fechaInicio(blank: false, nullable: false)
        fechaFin(blank: false, nullable: false)
    }

}
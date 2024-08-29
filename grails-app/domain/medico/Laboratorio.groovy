package medico

import audita.Auditable

class Laboratorio implements Auditable{
    static auditable = true
    String nombre

    static mapping = {
        table 'labt'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'labt__id'
            nombre column: 'labtnmbr'
        }
    }

    static constraints = {
        nombre(blank: false, size: 3..63)
    }

    String toString() {
        "${this.nombre}"
    }

}
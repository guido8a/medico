package medico

class Medicina {

    Medicina padre
    Laboratorio laboratorio
    String tipo
    String descripcion
    String codigo
    String forma
    String estado
    String observaciones
    String concentracion
    String tipoMedicamento


    static mapping = {
        table 'mdcn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mdcn__id'
        id generator: 'identity'
        version false
        columns {
            padre column: 'mdcnpdre'
            tipo column: 'mdcntipo'
            descripcion column: 'mdcndscr'
            codigo column: 'mdcncdgo'
            forma column: 'mdcnfrma'
            estado column: 'mdcnetdo'
            observaciones column: 'mdcnobsr'
            concentracion column: 'mdcncnct'
            tipoMedicamento column: 'mdcntpmd'
            laboratorio column: 'labt__id'
        }
    }


    static constraints = {
        padre(blank: true, nullable: true)
        tipo(size:0..4,blank: true, nullable: true)
        descripcion(size:0..255,blank: false, nullable: false)
        codigo(size:0..15,blank: false, nullable: false)
        forma(size:0..255,blank: true, nullable: true)
        estado(size:0..1,blank: true, nullable: true)
        observaciones(size:0..255,blank: true, nullable: true)
        concentracion(size:0..255,blank: true, nullable: true)
        tipoMedicamento(blank: true, nullable: true)
        laboratorio(blank: true, nullable: true)

    }
}

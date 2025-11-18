package sri

class Egreso {

    static auditable = true
    Proveedor proveedor
    TipoGasto tipoGasto
    Date fecha
    double valor
    String estado
    String descripcion
    String factura
    String registrado = 'N'

    static mapping = {
        table 'egrs'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'egrs__id'
            proveedor column: 'prve__id'
            tipoGasto column: 'tpgs__id'
            fecha column: 'egrsfcha'
            valor column: 'egrsvlor'
            estado column: 'egrsetdo'
            descripcion column: 'egrsdscr'
            factura column: 'egrsfctr'
            registrado column: 'egrsrgst'
        }
    }

    static constraints = {
        descripcion(blank: true, nullable: true)
        factura(blank: true, nullable: true)
        registrado(blank: true, nullable: true)
    }
}

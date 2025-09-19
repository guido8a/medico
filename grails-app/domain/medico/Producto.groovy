package medico

import seguridad.Empresa
import seguridad.Persona
import sri.TipoIva

class Producto {

    Persona persona
    TipoIva tipoIva
    Marca marca
    Subgrupo subgrupo
    Empresa empresa
    String numero
    String texto
    String estado
    Date fecha
    Date fechaModificacion
    Double precioUnitario
    String destacado

    static mapping = {
        table 'prod'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prod__id'
        id generator: 'identity'
        version false
        columns {
            persona column: 'prsn__id'
            tipoIva column: 'tpiv__id'
            marca column: 'mrca__id'
            subgrupo column: 'sbgr__id'
            empresa column: 'empr__id'
            numero column: 'prodnmro'
            texto column: 'prodtxto'
            estado column: 'prodetdo'
            fecha column: 'prodfcha'
            fechaModificacion column: 'prodfcmd'
            destacado column: 'proddstc'
            precioUnitario column: 'prodpcun'
        }
    }

    static constraints = {
        persona(blank: false, nullable: false)
        subgrupo(blank: false, nullable: false)
        tipoIva(blank: true, nullable: true)
        marca(blank: true, nullable: true)
        empresa(blank: true, nullable: true)
        numero(blank: true, nullable: true, attributes: [title: 'código'])
        texto(size: 0..255, blank: true, nullable: true, attributes: [title: 'texto'])
        estado(blank: true, nullable: true, attributes: [title: 'estado'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha creacion'])
        fechaModificacion(blank: true, nullable: true, attributes: [title: 'fecha modificacion'])
        destacado(blank: true, nullable: true, attributes: [title: 'destacado'])
        precioUnitario(blank: true, nullable: true, attributes: [title: 'unidad'])
    }

}

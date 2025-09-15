package seguridad

import audita.Auditable
import geografia.Canton

class Empresa implements Auditable{

    TipoEmpresa tipoEmpresa
    TipoIdentificacion tipoIdentificacion
    Canton canton
    String nombre
    String ruc
    String direccion
    String telefono
    Date fechaInicio
    Date fechaFin
    String mail
    String sigla
    String objeto
    String observaciones
    int numero = 0
    String establecimientos
    String tipoEmision
    String ambiente
    String razonSocial
    String contribuyenteEspecial
    String obligadaContabilidad
    String firma
    String clave
    String logo

    int numeroComprobanteDiario = 0
    int numeroComprobanteEgreso = 0
    int numeroComprobanteIngreso = 0
    String prefijoDiario
    String prefijoEgreso
    String prefijoIngreso

    static mapping = {
        table 'empr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'empr__id'
        id generator: 'identity'
        version false
        columns {
            tipoEmpresa column: 'tpem__id'
            tipoIdentificacion column: 'tpid__id'
            canton column: 'cntn__id'
            nombre column: 'emprnmbr'
            ruc column: 'empr_ruc'
            direccion column: 'emprdire'
            telefono column: 'emprtelf'
            fechaInicio column: 'emprfcin'
            fechaFin column: 'emprfcfn'
            mail column: 'emprmail'
            sigla column: 'emprsgla'
            objeto column: 'emprobjt'
            observaciones column: 'emprobsr'
            numero column: 'emprnmro'
            establecimientos column: 'emprestb'
            tipoEmision column: 'emprtpem'
            ambiente column: 'emprambt'
            razonSocial column: 'emprrzsc'
            contribuyenteEspecial column: 'emprctes'
            obligadaContabilidad column: 'emprcont'
            firma column: 'emprfrma'
            clave column: 'emprclve'
            logo column: 'emprlogo'
            numeroComprobanteDiario column: 'emprncmd'
            numeroComprobanteEgreso column: 'emprncme'
            numeroComprobanteIngreso column: 'emprncmi'
            prefijoDiario column: 'emprprdr'
            prefijoEgreso column: 'emprpreg'
            prefijoIngreso column: 'emprprin'
        }
    }
    static constraints = {
        tipoEmpresa(blank: true, nullable: true, attributes: [title: 'Tipo de Empresa'])
        tipoIdentificacion(blank: true, nullable: true)
        canton(blank: true, nullable: true)
        ruc(size:0..13,blank: false, nullable: false)
        nombre(size: 0..63, blank: false, nullable: false)
        sigla(size: 0..8, blank: false, nullable: false)
        objeto(blank: true, nullable: true)
        mail(size: 0..63, blank: true, nullable: true)
        direccion(size: 0..255,  blank: true, nullable: true)
        telefono(size: 0..63, blank: true, nullable: true)
        fechaInicio(blank: true, nullable: true)
        fechaFin(blank: true, nullable: true)
        observaciones(size: 0..255, blank: true, nullable: true)
        logo(size: 0..255, blank: true, nullable: true)
        numero(blank: true, nullable: true, size: 1..20)
        establecimientos(blank: true, nullable: true, maxSize: 63)
        tipoEmision(blank: true, nullable: true, maxSize: 1, inList: ['F', 'E'])
        obligadaContabilidad(blank: true, nullable: true, maxSize: 1)
        contribuyenteEspecial(blank: true, nullable: true)
        razonSocial(blank: true, nullable: true)
        ambiente(blank: true, nullable: true)
        firma(blank: true, nullable: true)
        clave(blank: true, nullable: true)
        numeroComprobanteDiario(blank: true, nullable: true, size: 1..20)
        numeroComprobanteIngreso(blank: true, nullable: true, size: 1..20)
        numeroComprobanteEgreso(blank: true, nullable: true, size: 1..20)
        prefijoDiario(blank: true, nullable: true, size: 1..20)
        prefijoEgreso(blank: true, nullable: true, size: 1..20)
        prefijoIngreso(blank: true, nullable: true, size: 1..20)
    }

    String toString() {
        return this.nombre
    }
}

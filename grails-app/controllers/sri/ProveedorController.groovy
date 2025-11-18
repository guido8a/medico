package sri

import seguridad.Empresa
import seguridad.Persona

class ProveedorController {

    def dbConnectionService

    def list(){
        println("parmas " + params)
        def empresa = Empresa.get(params.id)
        return [empresa: empresa, tipo: params.tipo]
    }

    def tablaProveedor_ajax(){

        def empresa = Empresa.get(params.empresa)

        def listaItems = ['prve_ruc', 'prvenmbr']
        def bsca
        def sqlTx = ""

        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select = "select * from prve "
        def txwh = " where prve__id  is not null and " +
                " $bsca ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} order by prvenmbr ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        println("-- " + sqlTx)

        return [datos: datos]
    }

    def form_ajax(){

        def empresa = Empresa.get(session.empresa.id)

        def proveedorInstance = new Proveedor(params)
        if (params.id) {
            proveedorInstance = Proveedor.get(params.id)
            if (!proveedorInstance) {
                notFound_ajax()
                return
            }
        }


        def countries = [] as SortedSet

        Locale.availableLocales*.displayCountry.each {
            if (it) {
                countries << it
            }
        }

        def soloLectura = false

        if(params.edi){
            soloLectura = params.edi
        }

        def tipoIdentificacion = TipoIdentificacion.withCriteria {
            ne("codigo","T")

        }

        return [proveedorInstance: proveedorInstance, paises: countries, lectura: soloLectura, tipoIdentificacion: tipoIdentificacion, empresa: empresa]
    }

    def ruc_ajax(){
        def proveedorInstance
        def lectura
        def longitud
        if(params.id){
            lectura = true
            proveedorInstance = Proveedor.get(params.id)
        }else{
            lectura = false
        }

        if(params.tipo == '2'){
            longitud = 10
        }else{
            longitud = 13
        }

        return[proveedorInstance: proveedorInstance, lectura: lectura, longitud: longitud.toInteger()]
    }

    def tipoPersona_ajax () {
        def lista
        def proveedorInstance
        if(params.id){
            proveedorInstance = Proveedor.get(params.id)
        }

        if(params.tipo == '2' || params.tipo == '3'){
            lista = TipoPersona.withCriteria {
                ne("codigo","J")
            }
        }else{
            lista = TipoPersona.list()
        }

        return[lista: lista, proveedorInstance: proveedorInstance]
    }

    def validarCedula_ajax() {
        println("params " + params)
        params.ruc = params.ruc.toString().trim()
        if (params.id) {
            def prov = Proveedor.get(params.id)
            if (prov.ruc.trim() == params.ruc.trim()) {
                render true
                return
            } else {
                render Proveedor.countByRuc(params.ruc) == 0
                return
            }
        } else {
            render Proveedor.countByEmpresaAndRuc(session.empresa, params.ruc) == 0
            return
        }
    }
    def save_ajax(){
        println("params " + params)

        def usuario = Persona.get(session.usuario?.id)
        def empresa = usuario.empresa

        params.empresa = empresa
        params.pais = Pais.get(params."pais.id")

        def proveedor

        if(params.id){
            proveedor = Proveedor.get(params.id)
        }else{
            proveedor = new Proveedor()
            proveedor.fecha = new Date()
        }

        proveedor.properties = params

        if(!proveedor.save(flush:true)){
            println("error al guardar el proveedor " + proveedor.errors)
            render "no_Error al guardar el proveedor"
        }else{
            render "ok_Guardado correctamente"
        }

    }

    def show_ajax() {
        if (params.id) {
            def proveedorInstance = Proveedor.get(params.id)
            if (!proveedorInstance) {
                notFound_ajax()
                return
            }
            return [proveedorInstance: proveedorInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def delete_ajax(){
        def proveedor = Proveedor.get(params.id)

        try{
            proveedor.delete(flush:true)
            render "ok_Borrado correctamente"
        }catch(e){
            println("error al borrar el proveedor " + proveedor.errors)
            render "no_Error al borrar el proveedor"
        }

    }
}

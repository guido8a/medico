package seguridad

import geografia.Canton
import geografia.Provincia

class EmpresaController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def dbConnectionService

    def list(){

    }

    def form_ajax(){
        println("id " + params)
        def empresa
        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        return [empresa: empresa]
    }

    def tablaEmpresas_ajax(){

        def listaItems = ['empr_ruc', 'emprnmbr']
        def bsca
        def sqlTx = ""

        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select = "select * from empr "
        def txwh = " where empr__id  is not null and " +
                " $bsca ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} order by emprnmbr ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def canton_ajax () {
        def empresa
        def provincia = Provincia.get(params.provincia)
        def cantones = Canton.findAllByProvincia(provincia).sort{it.nombre}

        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = null
        }

        return [empresa: empresa, cantones: cantones]
    }


    def validarRuc_ajax() {
        println ("params vruc " + params)
        params.ruc = params.ruc.toString().trim()
        def ruc = false
        def empresa

        if(params.id){
            empresa = Empresa.get(params.id)
            ruc = Empresa.findAllByRucAndIdNotEqual(params.ruc, empresa.id)
        }else{
            ruc = Empresa.findAllByRuc(params.ruc)
        }

        render ruc

//        if(ruc){
//            render false
//        }else{
//            render true
//        }
    }//validador unique

    def saveEmpresa_ajax() {
        def empresa
        def ruc = false

        if(params.id){
            empresa = Empresa.get(params.id)
            ruc = Empresa.findAllByRucAndIdNotEqual(params.ruc, empresa.id)
        }else{
            ruc = Empresa.findAllByRuc(params.ruc)
            empresa = new Empresa()
            empresa.fechaInicio = new Date()
        }

        if(ruc){
            render "err_El RUC ya se encuentra ingresado"
            return false
        }else{
            empresa.properties = params

            if(!empresa.save(flush: true)){
                println("error al crear la empresa " + empresa.errors)
                render "no_Error al crear la empresa"
            }else{
                render "ok_Empresa guardada correctamente"
            }
        }
    }

    def borrarEmpresa_ajax(){
        def empresa = Empresa.get(params.id)

        try{
            empresa.delete(flush: true)
            render "ok_Empresa borrada correctamente"
        }catch(e){
                println("error al borrar la empresa"  + empresa.errors)
            render "no_Error al borrar la empresa"
        }
    }

    def show_ajax () {
        def empresa = Empresa.get(params.id)
        return [empresa: empresa]
    }

}

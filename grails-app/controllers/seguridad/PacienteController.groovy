package seguridad

import geografia.Canton
import geografia.Parroquia
import geografia.Provincia

class PacienteController {

    def dbConnectionService

    def list () {
        def empresa

        if(params.id){
            empresa = Empresa.get(params.id)
        }

        return [empresa: empresa]
    }

    def tablaPacientes_ajax () {
        def empresa

        if(params.empresa != '0'){
            empresa = Empresa.get(params.empresa)
        }else{
            empresa = null
        }

        def listaItems = ['pcntcdla', 'pcntapll', 'pcntnmbr']
        def bsca
        def sqlTx = ""
        def bscaEmp = empresa ? " and empr__id = ${empresa?.id}" : " "

        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select = "select * from pcnt "
        def txwh = " where pcnt__id  is not null and " +
                " $bsca ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} ${bscaEmp} order by pcntapll ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]

    }

    def form_ajax () {
        def paciente

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            paciente = new Paciente()
        }

        return[paciente: paciente]
    }

    def savePaciente_ajax () {

        println("params " + params)

        def paciente

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            paciente = new Paciente()
            paciente.fechaInicio = new Date()
        }

       if(params.fechaNacimiento){
           params.fechaNacimiento = new Date().parse("dd-MM-yyyy", params.fechaNacimiento)
       }

        paciente.properties = params

        if(params.activo == '0'){
            paciente.fechaFin = new Date()
        }else{
            paciente.fechaFin = null
        }

        if(!paciente.save(flush: true)){
            println("error al guardar el paciente " + paciente.errors)
            render"no_Error al guardar el paciente"
        }else{
            render "ok_Paciente guardado correctamente"
        }
    }

    def canton_ajax () {
        def paciente
        def provincia = Provincia.get(params.provincia)
        def cantones = Canton.findAllByProvincia(provincia).sort{it.nombre}

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            paciente = null
        }

        return [paciente: paciente, cantones: cantones]
    }

    def parroquia_ajax () {
        def paciente
        def canton = Canton.get(params.canton)
        def parroquias = Parroquia.findAllByCanton(canton).sort{it.nombre}

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            paciente = null
        }

        return [paciente: paciente, parroquias: parroquias]
    }

    def borrarPaciente_ajax(){
        def paciente = Paciente.get(params.id)

        try{
            paciente.delete(flush: true)
            render "ok_Paciente borrado correctamente"
        }catch(e){
            render "no_No se pudo borrar el paciente"
        }
    }

    def show_ajax(){
        def paciente = Paciente.get(params.id)
        return[paciente:paciente]
    }

    def datos() {
        def paciente
        if(params.id){
            paciente = Paciente.get(params.id)

        }else{
            paciente = new Paciente()
        }
        return[paciente:paciente]
    }

    def antecedentes_ajax(){
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]
    }

    def cambiarEstado_ajax(){
        def paciente = Paciente.get(params.id)

        if(paciente.activo == 1){
            paciente.activo = 0
        }else{
            paciente.activo = 1
        }

        if(!paciente.save(flush: true)){
            render "no"
            println("error al cambiar el estado " + paciente.errors)
        }else{
            render "ok"
        }
    }


}

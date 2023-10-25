package medico

import seguridad.Paciente

class HistorialController {

    def dbConnectionService

    def list(){
        def paciente = Paciente.get(params.id)
        return[paciente:paciente]
    }

    def cita(){
        def paciente = Paciente.get(params.paciente)
        def historial
        if(params.id){
            historial = Historial.get(params.id)
        }else{
            historial = new Historial()
        }
        return[paciente:paciente, historial: historial]
    }

    def tablaCitas_ajax(){
        def paciente = Paciente.get(params.id)
        def citas = Historial.findAllByPaciente(paciente).sort{it.fecha}
        return[paciente: paciente, citas: citas]
    }

    def saveCita_ajax(){
        def historial

        if(params.id){
            historial = Historial.get(params.id)
        }else{
            historial = new Historial()
            historial.diagnostico = Diagnostico.get(4438);
        }

        if(params.fecha){
            params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        }

        if(params.proximaCita){
            params.proximaCita = new Date().parse("dd-MM-yyyy", params.proximaCita)
        }

        historial.properties = params

        if(!historial.save(flush: true)){
            println("error al guardar la cita " + paciente.errors)
            render"no_Error al guardar la cita"
        }else{
            render "ok_Cita guardada correctamente_${historial?.id}"
        }
    }

    def diagnostico_ajax(){
        def historial = Historial.get(params.id)
        return[historial: historial]
    }

    def buscarDiagnostico_ajax(){

    }

    def tablaBuscarDiagnostico_ajax(){
        def listaItems = ['diagdscr', 'diagcdgo']
        def bsca
        def sqlTx = ""

        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select = "select * from diag "
        def txwh = " where diag__id is not null and " +
                " $bsca ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} order by diagdscr limit 100 ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def saveDiagnostico_ajax(){
        def historial = Historial.get(params.id)
        def diagnostico = Diagnostico.get(params.diagnostico)

        historial.diagnostico = diagnostico

        if(!historial.save(flush:true)){
            println("error al guardar el diagnostico " + historial.errors )
            render "no_Error al guardar el diagnostico"
        }else{
            render "ok_Diagnóstico guardado correctamente"
        }
    }


}

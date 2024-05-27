package medico

class TratamientoController {

    def dbConnectionService

    def tratamiento_ajax() {
        def historial = Historial.get(params.cita)
        return [historial: historial]
    }

    def tablaTratamiento_ajax(){
        def historial = Historial.get(params.id)
        def tratamientos = Tratamiento.findAllByHistorial(historial)
        return [historial: historial, tratamientos: tratamientos]
    }

    def form_ajax(){
        def tratamiento
        def historial = Historial.get(params.cita)

        if(params.id){
            tratamiento = Tratamiento.get(params.id)
        }else{
            tratamiento = new Tratamiento()
        }

        return[tratamiento: tratamiento, historial: historial]
    }

    def buscarMedicina_ajax() {

    }

    def tablaMedicina_ajax(){
        def listaItems = ['mdcnnmbr', 'mdcndscr', 'mdcncdgo']
        def bsca
        def sqlTx = ""

        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select = "select * from mdcn "
        def txwh = " where mdcn__id is not null and " +
                " $bsca ilike '%${params.criterio}%' "
        def tpo = " and mdcntpmd ilike '%${params.tipoMedicina}%' "
        sqlTx = "${select} ${txwh} ${tpo} order by mdcndscr limit 100 ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def saveTratamiento_ajax(){
        def tratamiento
        if(params.id){
            tratamiento = Tratamiento.get(params.id)
        }else{
            tratamiento = new Tratamiento()
        }

        if(!params.cantidad || params.cantidad == ''){
            params.cantidad = 0
        }

        tratamiento.properties = params

        if(!tratamiento.save(flush:true)){
            println("error al guardar el tratamiento "+ tratamiento.errors)
            render "no_Error al guardar el tratamiento"
        }else{
            render "ok_Tratamiento guardado correctamente"
        }
    }

    def borrarTratamiento_ajax(){
        def tratamiento = Tratamiento.get(params.id)

        if(tratamiento){
            try{
                tratamiento.delete(flush:true)
                render "ok_Tratamiento borrado correctamente"
            }catch(e){
                println("error al borrar el tratamiento " + tratamiento.errors)
                render "no_Error al borrar el tratamiento"
            }
        }else{
            render "no_No se encontró el tratamiento"
        }
    }

    def saveTextoTratamiento_ajax(){
        def cita = Historial.get(params.id)

        if(cita){
            cita.tratamiento = params.tratamiento

            if(!cita.save(flush: true)){
                render "no_Error al guardar el tratamiento"
            }else{
                render "ok_Tratamiento guardado correctamente"
            }

        }else{
            render "no_Error al guardar el tratamiento"
        }
    }


}

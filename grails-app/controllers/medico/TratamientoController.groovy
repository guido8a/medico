package medico

class TratamientoController {

    def dbConnectionService

    def tratamiento_ajax() {
        def historial = Historial.get(params.cita)
        return [historial: historial]
    }

    def tablaTratamiento_ajax(){
        def historial = Historial.get(params.id)
        def tratamientos = Tratamiento.findAllByHistorial(historial).sort{it.orden}
        return [historial: historial, tratamientos: tratamientos]
    }

    def form_ajax(){
        def tratamiento
        def historial = Historial.get(params.cita)
        def tratamientos = Tratamiento.findAllByHistorial(historial)
        def maximo = tratamientos?.orden?.max() ?: 0

        if(params.id){
            tratamiento = Tratamiento.get(params.id)
        }else{
            tratamiento = new Tratamiento()
        }

        return[tratamiento: tratamiento, historial: historial, maximo: maximo]
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

        if(bsca == 'mdcnnmbr' && params.tipoMedicina == 'G') {
            bsca = 'mdcndscr'
        }

//        def select = "select * from mdcn "
//        def txwh = " where mdcn__id  is not null and " +
//                " (mdcndscr ilike '%${params.criterio}%' or mdcnnmbr ilike '%${params.criterio}%') "

        def select = "select m.mdcn__id, m.mdcnpdre, m.mdcntipo, m.mdcndscr, m.mdcncdgo, m.mdcnfrma, m.mdcncnct, " +
                "m.mdcnetdo, m.mdcnobsr, m.mdcntpmd, m.labt__id, m.mdcncntd, p.mdcndscr pdredscr, p.mdcncdgo pdrecdgo " +
                "from mdcn m left join mdcn p on p.mdcn__id = m.mdcnpdre "
        def txwh = " where m.mdcn__id is not null and " +
                " (m.mdcndscr ilike '%${params.criterio}%' or m.mdcnnmbr ilike '%${params.criterio}%') "

//        def tpo = " and mdcntpmd ilike '%${params.tipoMedicina}%' "
//        sqlTx = "${select} ${txwh} ${tpo} order by mdcndscr limit 100".toString()
        sqlTx = "${select} ${txwh} order by mdcndscr limit 50".toString()
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

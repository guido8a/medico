package medico


class MedicinaController {

    def dbConnectionService

    def list(){

    }

    def form_ajax(){
        def medicina

        if(params.id){
            medicina = Medicina.get(params.id)
        }else{
            medicina = new Medicina()
        }

        return [medicina: medicina]
    }


    def tablaMedicinas_ajax(){
        def listaItems = ['m.mdcnnmbr', 'm.mdcndscr', 'm.mdcncdgo']
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

        def select = "select m.mdcn__id, m.mdcnpdre, m.mdcntipo, m.mdcndscr, m.mdcncdgo, m.mdcnfrma, m.mdcncnct, " +
                "m.mdcnetdo, m.mdcnobsr, m.mdcntpmd, m.labt__id, m.mdcncntd, p.mdcndscr pdredscr, p.mdcncdgo pdrecdgo " +
                "from mdcn m left join mdcn p on p.mdcn__id = m.mdcnpdre "
        def txwh = " where m.mdcn__id is not null and " +
                " (m.mdcndscr ilike '%${params.criterio}%' or m.mdcnnmbr ilike '%${params.criterio}%') "

        sqlTx = "${select} ${txwh} order by m.mdcndscr limit 100".toString()
//        println "sql: $sqlTx"
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)
        cn.close()

        [datos: datos]

    }

    def saveMedicina_ajax() {
        println("params " + params)

        def medicina
//        def existe = Medicina.findAllByDescripcionIlikeAndFormaAndConcentracion(params.descripcion, params.forma, params.concentracion)
        def existe = Medicina.findAllByDescripcionIlikeAndConcentracionIlike(params.descripcion, params.concentracion)

        if(params.tipoMedicamento == 'C'){
            params.laboratorio = params.laboratorio
        }else{
            params.laboratorio = null
        }

        if(params.tipoMedicamento == 'C'){
            if(!params.nombrePadre){
                render "err_Seleccione un medicamento genérico padre"
                return
            }
        }

        if(params.id){
            medicina = Medicina.get(params.id)
            println "existe_id: ${existe} == ${medicina?.id}"


            if(existe.size() >=1){
                if(existe.contains(medicina)){

                }else{
                    render "err_Ya existe una medicina con ese nombre y concentración"
                    return
                }
            }


//            if(existe?.id != medicina?.id){
//                render "err_Ya existe una medicina con ese nombre"
//                return
//            }
        }else{
            if(existe.size() >= 1){
                render "err_Ya existe una medicina con ese nombre y concentración"
                return
            }

            medicina = new Medicina()
        }

        medicina.properties = params

        if(!medicina.save(flush: true)){
            println("error al guardar la medicina " + medicina.errors)
            render "no_Error al guardar la medicina"
        }else{
            render "ok_Medicina guardada correctamente"
        }
    }

    def buscarPadre_ajax (){

    }

    def tablaPadres_ajax(){
//        def listaItems = ['mdcndscr', 'mdcncdgo', 'mdcntipo']
//        def bsca
//        def sqlTx = ""
//
//        if(params.buscarPor){
//            bsca = listaItems[params.buscarPor?.toInteger()-1]
//        }else{
//            bsca = listaItems[0]
//        }
//
//        def select = "select * from mdcn "
//        def txwh = " where mdcn__id  is not null and mdcnpdre is null and mdcntpmd = 'G' and " +
//                " $bsca ilike '%${params.criterio}%' "
//        sqlTx = "${select} ${txwh} order by mdcndscr ".toString()
//        def cn = dbConnectionService.getConnection()
//        def datos = cn.rows(sqlTx)
//
//        [datos: datos]


        def sqlTx = ""

        def select = "select * from mdcn "
        def txwh = " where mdcntpmd = 'G' and " +
                " (mdcndscr ilike '%${params.criterio}%' or mdcncdgo ilike '%${params.criterio}%') "
        sqlTx = "${select} ${txwh} order by mdcndscr limit 100".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def show_ajax () {
        def medicina = Medicina.get(params.id)
        return[medicina:medicina]
    }

    def buscarCodigo_ajax() {

        def tipo = params.tipo
        def ultimoCodigo = Medicina.findAllByTipoMedicamento(tipo)?.ultimo?.max() + 1
        def texto = params.tipo == 'G' ? 'GEN-' : 'COM-'
        def codigo = texto + ultimoCodigo

        render  "ok_${codigo}_${ultimoCodigo}"
    }

    def verificarBorrado_ajax(){
        def medicina = Medicina.get(params.id)

        if(medicina?.padre){
            render "no"
        }else{
            render "ok"
        }

    }

    def otrasMedicinas_ajax(){
        def medicina = Medicina.get(params.id)
        println("med " + medicina)

        def hermanos = Medicina.findAllByPadreAndIdNotEqual(medicina.padre, medicina?.id).sort{it.codigo}
        def generica = medicina.padre
        def todas = hermanos ? (hermanos + generica) : generica

        println("todas " + todas)

        return [todas: todas]
    }

    def borrarMedicina_ajax(){
        println "borrar: $params"
        def medicina = Medicina.get(params.id)

        def usado
        try{
            medicina.delete(flush:true)
            render "ok_Borrado correctamente"
        }catch(e){
            usado = Medicina.countByPadre(medicina)
            if(usado){
                println("error al borrar la medicina " + medicina.errors)
                render "no_Error al borrar la medicina, es medicina genérica (${params.id})"
                return
            }
            usado = Tratamiento.findByMedicina(medicina)
            if(usado){
                println("error al borrar la medicina " + medicina.errors)
                render "no_Error al borrar la medicina, está en tratamiento (${params.id})"
            }
        }
    }


    def reemplazarYBorrarMedicina_ajax(){

        println("parmas " + params)

        def medicina = Medicina.get(params.id)
        def medicinaReemplazo = Medicina.get(params.reemplazo)
        def hijos = Medicina.findAllByPadre(medicina)
        def existeTratamiento = Tratamiento.findAllByMedicina(medicina)

        if(hijos){
            render "no_Error al borrar la medicina, posee medicinas derivadas"
        }else {
            if (existeTratamiento) {
                existeTratamiento.each {
                    it.medicina = medicinaReemplazo
                    it.save(flush: true)
                }
            }

            try{
                medicina.delete(flush: true)
                render "ok_Borrado correctamente"
            }catch(e){
                println("error al borrar la medicina " + medicina.errors)
                render "no_Error al borrar la medicina "
            }

        }
    }

}

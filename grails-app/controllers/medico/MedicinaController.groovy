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

        def select = "select * from mdcn "
        def txwh = " where mdcn__id  is not null and " +
                " $bsca ilike '%${params.criterio}%' "
        def tpo = " and mdcntpmd ilike '%${params.tipoMedicina}%' "
        sqlTx = "${select} ${txwh} ${tpo} order by mdcndscr limit 100".toString()
        println "sql: $sqlTx"
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def saveMedicina_ajax() {
        def medicina

        if(params.tipoMedicamento == 'C'){
            params.laboratorio = params.laboratorio
        }else{
            params.laboratorio = null
        }

        if(params.id){
            medicina = Medicina.get(params.id)
        }else{
            medicina = new Medicina()
        }

        medicina.properties = params
        println "medicina: ${medicina.forma} --> ${medicina.concentracion}"

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
        def listaItems = ['mdcndscr', 'mdcncdgo', 'mdcntipo']
        def bsca
        def sqlTx = ""

        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select = "select * from mdcn "
        def txwh = " where mdcn__id  is not null and mdcnpdre is null and " +
                " $bsca ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} order by mdcndscr ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def show_ajax () {
        def medicina = Medicina.get(params.id)
        return[medicina:medicina]
    }

}

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

        def listaItems = ['mdcndscr', 'mdcncdgo', 'mdcntipo']
        def bsca
        def sqlTx = ""

        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select = "select * from mdcn "
        def txwh = " where mdcn__id  is not null and " +
                " $bsca ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} order by mdcndscr ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def saveMedicina_ajax() {
        def medicina

        if(params.id){
            medicina = Medicina.get(params.id)
        }else{
            medicina = new Medicina()
        }

        medicina.properties = params
        medicina.padre = null

        if(!medicina.save(flush: true)){
            println("error al guardar la medicina " + medicina.errors)
            render "no_Error al guardar la medicina"
        }else{
            render "ok_Medicina guardada correctamente"
        }
    }

}

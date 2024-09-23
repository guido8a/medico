package medico


class DiagnosticoController {

    def dbConnectionService

   def list(){

   }

    def tablaDiagnostico_ajax(){
        println "buscar: $params"
        def sqlTx
        def select = "select * from diag d "
        def txwh = " where d.diag__id  is not null and " +
                "(d.diagdscr ilike '%${params.criterio}%' or d.diagcdgo ilike '%${params.criterio}%') "
        sqlTx = "${select} ${txwh} order by diagcdgo limit 100".toString()
        println "sql: $sqlTx"
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def form_ajax(){
        def diagnostico
        def codigo
        def cn = dbConnectionService.getConnection()
        def sql = "select coalesce(max(substr(diagcdgo,4,7)::int + 1),1) nmro from diag where diagcdgo ilike 'int%'"
        def nmro = cn.rows(sql.toString())[0].nmro

        if(params.id){
            diagnostico = Diagnostico.get(params.id)
        }else{
            diagnostico = new Diagnostico()
            codigo = 'INT' + completa(nmro, 3)
            diagnostico.codigo = codigo
            println "código: $codigo"
        }

        return [diagnostico: diagnostico]
    }

    def saveDiagnostico_ajax(){
        def diagnostico

        if(params.id){
            diagnostico = Diagnostico.get(params.id)
        }else{
            diagnostico = new Diagnostico()
        }

        diagnostico.properties = params

        if(!diagnostico.save(flush: true)){
            render "no_Error al guardar el diagnóstico"
        }else{
            render "ok_Diagnóstico guardado correctamente"
        }
    }

    def borrarDiagnostico_ajax(){
        def diagnostico = Diagnostico.get(params.id)

        if(!diagnostico){
            render "no_No existe el diagnóstico"
        }else{
            try{
                diagnostico.delete(flush:true)
                render "ok_Diagnóstico borrado correctamente"
            }catch(e){
                println("error al borrar el diagnóstico " + diagnostico.errors)
                render "no_Error al borrar el diagnóstico"
            }
        }
    }

    def completa(txto, nmro) {
        def respuesta = ""
        respuesta = '0' * (nmro.toInteger() - txto.toString().size().toInteger() ) + txto
        println "resp: $respuesta"
        return respuesta
    }

}

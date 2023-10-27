package medico

import apli.DbConnectionService
import geografia.Canton
import geografia.Parroquia
import geografia.Provincia
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
            params.diagnostico = Diagnostico.get(4438);
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

    def arbolCitas() {
        def paciente = Paciente.get(params.id)
        return[paciente:paciente]
    }

    def loadTreePart_ajax() {
        render(makeTreeNode(params))
    }

    def makeTreeNode(params) {
        println "makeTreeNode.. $params"
        def paciente = Paciente.get(params.paciente)
        def cn = dbConnectionService.getConnection()
        def id = params.id
        def tipo = ""
        def liId = ""
        def ico = ""
        def sql = ""
        println "Paciente: $paciente"
        def titulo = "Paciente: ${paciente.nombre} ${paciente.apellido}"

        if(id.contains("_")) {
            id = params.id.split("_")[1]
            tipo = params.id.split("_")[0]
        }

        if (!params.order) {
            params.order = "asc"
        }

        String tree = "", clase = "", rel = ""
        def padre
        def hijos = []

//        println "---> id: $id, tipo: $tipo, es #: ${id == '#'}"

        if (id == "#") {
            //root
//            def hh = Provincia.countByZonaIsNull()
            def hh = Provincia.count()
            if (hh > 0) {
                clase = "hasChildren jstree-closed"
            }

            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' data-level='0' >" +
                    "<a href='#' class='label_arbol'><strong>$titulo</strong></a>" +
                    "</li>"
        } else {
//            println "---- no es raiz... procesa: $tipo"

            if(id == 'root'){
                //hijos = Provincia.findAll().sort{it.nombre}
                hijos = [['nombre': 'Uno']]
                sql = "select hscl.diag__id id, diagdscr nombre from hscl, diag where diag.diag__id = hscl.diag__id " +
                        "group by hscl.diag__id, diagdscr"
                println "sql: $sql"
                hijos = cn.rows(sql.toString())
                println "hijos: ${hijos}"
                def data = ""
                ico = ", \"icon\":\"fa fa-parking text-success\""
                hijos.each { hijo ->
//                println "procesa ${hijo.nombre}"
                    //clase = Canton.findByProvincia(hijo) ? "jstree-closed hasChildren" : "jstree-closed"
                    clase = "jstree-closed hasChildren"

                    tree += "<li id='prov_" + hijo.id + "' class='" + clase + "' ${data} data-jstree='{\"type\":\"${"principal"}\" ${ico}}' >"
                    tree += "<a href='#' class='label_arbol'>" + hijo?.nombre + "</a>"
                    tree += "</li>"
                }
            }else{
                switch(tipo) {
                    case "prov":
                        //hijos = Canton.findAllByProvincia(Provincia.get(id), [sort: params.sort])
                        sql = "select hscl.hscl__id id, hsclfcha, hsclmotv nombre from hscl where diag__id = $id " +
                                "order by hsclfcha desc"
                        println "sql: $sql"
                        hijos = cn.rows(sql.toString())

                        liId = "cntn_"
//                    println "tipo: $tipo, ${hijos.size()}"
                        ico = ", \"icon\":\"fa fa-copyright text-info\""
                        hijos.each { h ->
//                        println "procesa $h"
//                            clase = Parroquia.findByCanton(h)? "jstree-closed hasChildren" : ""
                            clase = "jstree-closed "
                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"canton"}\" ${ico}}'>"
                            tree += "<a href='#' class='label_arbol'>" + h.hsclfcha + (h.nombre ? " - ${h.nombre} "  : '') + "</a>"
                            tree += "</li>"
                        }
                        break
/*                    case "cntn":
                        hijos = Parroquia.findAllByCanton(Canton.get(id), [sort: params.sort])
                        liId = "parr_"
                        ico = ", \"icon\":\"fa fa-registered text-danger\""
                        hijos.each { h ->
                            clase = ""
                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"parroquia"}\" ${ico}}'>"
                            tree += "<a href='#' class='label_arbol'>" + h.nombre + "</a>"
                            tree += "</li>"
                        }
                        break
*/
                }
            }



        }

//        println "arbol: $tree"
        return tree
    }



}

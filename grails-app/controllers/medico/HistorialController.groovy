package medico

import apli.DbConnectionService
import geografia.Canton
import geografia.Parroquia
import geografia.Provincia
import seguridad.Empresa
import seguridad.Paciente
import seguridad.Persona

import javax.imageio.ImageIO

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
        return[paciente:paciente, historial: historial, tipo: params.tipo]
    }

    def tablaCitas_ajax(){
        def paciente = Paciente.get(params.id)
        def citas = Historial.findAllByPaciente(paciente).sort{it.fecha}
        return[paciente: paciente, citas: citas]
    }

    def saveCita_ajax(){

        def paciente = Paciente.get(params.paciente)
        def historial
//        def consultorio = Persona.get(params.persona)?.empresa
        def consultorio = paciente.empresa
        def numeroActual = consultorio?.numero

        if(params.id){
            historial = Historial.get(params.id)
        }else{
            historial = new Historial()
            historial.numero = numeroActual + 1
            params.diagnostico = Diagnostico.get(4438);
        }

        if(params.fecha){
            params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        }

        if(params.hora){
            params.hora = params.hora.replaceAll("\\.", ":")
        }

        if(params.proximaCita){
            params.proximaCita = new Date().parse("dd-MM-yyyy", params.proximaCita)
        }

        historial.properties = params

        if(!historial.save(flush: true)){
            println("error al guardar la cita " + historial.errors)
            render"no_Error al guardar la cita"
        }else{
            if(!params.id){
                consultorio.numero = numeroActual + 1
                consultorio.save(flush:true)
            }
            render "ok_Cita guardada correctamente_${historial?.id}"
        }
    }

    def diagnostico_ajax(){
        def historial = Historial.get(params.id)
        return[historial: historial]
    }

    def buscarDiagnostico_ajax(){
        def cita = Historial.get(params.cita)
        return [cita: cita]
    }

    def tablaBuscarDiagnostico_ajax(){
        def listaItems = ['diagdscr', 'diagcdgo']
        def bsca
        def sqlTx = ""
        def cita = Historial.get(params.cita)

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

        [datos: datos, cita: cita]
    }

    def saveDiagnostico_ajax(){
        def historial = Historial.get(params.cita)
        def diagnostico = Diagnostico.get(params.diagnostico)
        def registro

        def existe = DiagnosticoxHistorial.findAllByHistorialAndDiagnostico(historial, diagnostico)

        if(existe){
            render "no_El diagnóstico seleccionado ya fue ingresado"
            return false
        }else{
            registro = new DiagnosticoxHistorial()
            registro.historial = historial
            registro.diagnostico = diagnostico
            registro.descripcion = ''

            if(!registro.save(flush:true)){
                println("error al guardar el diagnostico " + registro.errors )
                render "no_Error al guardar el diagnóstico"
            }else{
                render "ok_Diagnóstico guardado correctamente"
            }
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
//                ico = ", \"icon\":\"fa fa-parking text-success\""
                ico = ", \"icon\":\"fa fa-scroll text-success\""
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
                    case "cntn":
//                        hijos = Parroquia.findAllByCanton(Canton.get(id), [sort: params.sort])
                        hijos = ExamenFisico.findByHistorial(Historial.get(id))
                        liId = "parr_"
                        ico = ", \"icon\":\"fa fa-registered text-danger\""
                        hijos.each { h ->
                            clase = ""
                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"parroquia"}\" ${ico}}'>"
                            tree += "<a href='#' class='label_arbol'>" + "Examen Físico: " + h.fecha.format("dd-MM-yyyy") + "</a>"
                            tree += "</li>"
                        }
                        break

                }
            }



        }

//        println "arbol: $tree"
        return tree
    }

    def examenes_ajax(){
        def historial = Historial.get(params.cita)
        def examenes = ExamenComplementario.findAllByHistorial(historial)
        return [historial: historial, examenes: examenes]
    }

    def formExamenes_ajax(){
        def historial = Historial.get(params.cita)
        def examen
        if(params.id){
            examen = ExamenComplementario.get(params.id)
        }else{
            examen = new ExamenComplementario()
        }
        return [examen: examen, historial: historial]
    }

    def saveExamen_ajax(){
//        println("params save examen" + params)

        def examenesChequeados = []

        params.each{
//            println("k " + it.key + "--- " + it.value)
            if(it.value == 'on'){
                println("ck " + it.key)
                def s = it.key.split("_")[1]
                examenesChequeados += s
            }
        }

        if(examenesChequeados.size() > 0){
            def historial = Historial.get(params.historial)
            def examen
            if (params.id) {
                examen = ExamenComplementario.get(params.id)
            }//es edit
            else {
                examen = new ExamenComplementario()
            } //es create

            if(params.fechaExamen){
                params.fecha = new Date().parse("dd-MM-yyyy", params.fechaExamen)
            }

            examen.properties = params

            if (!examen.save(flush: true)) {
                println("Error al guardar el examen" +  examen.errors)
                render "no_Error al guardar el examen"
            }else{

                if(examenesChequeados.size() > 0){

                    def examenesExistentes = DetalleExamen.findAllByExamenComplementario(examen)

                    if(examenesExistentes.size() > 0) {
                        examenesExistentes.each{
                            it.delete(flush:true)
                        }
                    }

                    examenesChequeados.each{
                        def registroExamen = Examen.get(it)
                        def nuevoExamen = new DetalleExamen()
                        nuevoExamen.examen = registroExamen
                        nuevoExamen.examenComplementario = examen

                        if(!nuevoExamen.save(flush:true)){
                            println("error al guardar el examen " + nuevoExamen.errors)
                            render "no_Error al guardar el examen"
                        }else{
                            render "ok_Examen guardado correctamente"
                        }
                    }
                }else{
                    render "ok_Examen guardado correctamente"
                }
            }
        }else{
            render "err_No se ha seleccionado nigún examen"
        }
    }

    def formDocExamenes_ajax(){
        def examen = ExamenComplementario.get(params.id)
        return[examen: examen, tipo: params.tipo]
    }

    def uploadFileExamen() {
//        println "upload "+params

        def acceptedExt = ["jpg", "png", "jpeg", "pdf"]

        def examen = ExamenComplementario.get(params.id)
        def historial = examen.historial
        def path = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.id}/citas/cita_" +
                historial?.id  + "/"
        new File(path).mkdirs()

        def f = request.getFile('file')  //archivo = name del input type file
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }
            if (acceptedExt.contains(ext.toLowerCase())) {
                fileName = fileName + "-" + examen?.id + "." + ext
                def pathFile = path + fileName
                def file = new File(pathFile)
                println "subiendo archivo: $fileName"

                f.transferTo(file)

                def old = examen.path
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.id}/citas/cita_" +
                            historial?.id  + "/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                examen.path = fileName
                examen.save(flush: true)

            } else {
                render "no_Seleccione un archivo JPG, JPEG, PNG, PDF"
                return
            }
        } else {
            render "no_Seleccione un archivo JPG, JPEG, PNG, PDF"
            return
        }

        render "ok_Subido correctamente"
    }

    def tablaExamenes_ajax(){
        def historial = Historial.get(params.id)
        def examenes = ExamenComplementario.findAllByHistorial(historial, [sort: "id"])
        return [historial: historial, examenes: examenes]
    }

    def borrarExamen_ajax(){
        def examen = ExamenComplementario.get(params.id)
        def historial = examen.historial

        if(examen){
            try{

                def detalles = DetalleExamen.findAllByExamenComplementario(examen)

                if(detalles.size() > 0){
                    detalles.each {
                        it.delete(flush:true)
                    }
                }

                def old = examen.path
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.id}/citas/cita_" +
                            historial?.id  + "/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                examen.delete(flush:true)
                render "ok_Examen borrado correctamente"
            }catch(e){
                println("error al borrar el examen " + examen.errors + e)
                render "no_Error al borrar el examen"
            }
        }else{
            render "no_No se encontró el examen"
        }
    }

    def borrarDocExamen_ajax(){
        def examen = ExamenComplementario.get(params.id)
        def historial = examen.historial

        if(examen){
            try{

                def old = examen.path
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.id}/citas/cita_" +
                            historial?.id  + "/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                examen.path = null
                examen.save(flush:true)
                render "ok_Documento borrado correctamente"

            }catch(e){
                println("error al borrar el examen " + examen.errors)
                render "no_Error al borrar el documento"
            }
        }else{
            render "no_No se encontró el examen"
        }
    }

    def downloadFile() {
        def examen = ExamenComplementario.get(params.id)
        def historial = examen.historial
        def path = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.id}/citas/cita_" +
                historial?.id  + "/" + examen.path

        def file = new File(path)
        if (file.exists()) {
            def b = file.getBytes()

            def ext = examen.path.split("\\.")
            ext = ext[ext.size() - 1]

            response.setContentType(ext == 'pdf' ? "application/pdf" : "image/" + ext)
            response.setHeader("Content-disposition", "attachment; filename=" + examen.path)
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        } else {
            flash.clase = "alert-error"
            flash.message = "No se encontró el archivo " + " '" + examen.path + "'"
            redirect(action: "errores")
        }
    }

    def getImage() {
        def examen = ExamenComplementario.get(params.id)
        def nombreArchivo = examen?.path?.split("\\.")[0]
        def extensionArchivo = examen?.path?.split("\\.")[1]

        byte[] imageInBytes = im(nombreArchivo, extensionArchivo , examen?.id)
        response.with{
            setHeader('Content-length', imageInBytes.length.toString())
            contentType = "image/${extensionArchivo}" // or the appropriate image content type
            outputStream << imageInBytes
            outputStream.flush()
        }
    }

    byte[] im(nombre,ext,examenId) {
        def examen = ExamenComplementario.get(examenId)
        def historial = examen.historial
        ByteArrayOutputStream baos = new ByteArrayOutputStream()
//        ImageIO.write(ImageIO.read(new File("/var/medico/empresa/emp_${pcnt?.empresa?.id}/paciente/pac_" + pcnt?.id + "/" + nombre + "." + ext)), ext.toString(), baos)
        ImageIO.write(ImageIO.read(new File("/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.id}/citas/cita_" + historial?.id  + "/" + nombre + "." + ext)), ext.toString(), baos)
        baos.toByteArray()
    }


    def tablaDiagnostico_ajax(){
        def historial = Historial.get(params.cita)
        def diagnosticos = DiagnosticoxHistorial.findAllByHistorial(historial)
        return [diagnosticos: diagnosticos]
    }

    def borrarDiagnostico_ajax(){
        def diagnostico = DiagnosticoxHistorial.get(params.id)

        if(diagnostico){

            try{
                diagnostico.delete(flush: true)
                render "ok_Borrado correctamente"
            }catch(e){
                println("error al borrar " + diagnostico.errors)
                render "no_Error al borrar"
            }

        }else{
            render "no_No se encontró el registro"
        }
    }

    def observacionesDiagnostico_ajax(){
        def diagnostico = DiagnosticoxHistorial.get(params.id)
        return [diagnostico: diagnostico]
    }


    def saveObservaciones_ajax(){
        def diagnostico = DiagnosticoxHistorial.get(params.id)

        if(diagnostico){

            diagnostico.descripcion = params.observaciones

            if(!diagnostico.save(flush:true)){
                println("Error al guardar " + diagnostico.errors)
                render "no_Error al guardar"
            }else{
                render "ok_Guardado correctamente"
            }

        }else{
            render "no_Error al guardar las observaciones"
        }
    }

    def cita_ajax(){
        def paciente = Paciente.get(params.paciente)
        def cita
        def hora = new Date().format('HH:mm')

        if(params.id){
            cita = Historial.get(params.id)
        }else{
            cita = new Historial()
        }

        return [historial: cita, paciente: paciente, hora: hora]
    }

    def comentario_ajax(){
        def cita = Historial.get(params.id)
        return[cita: cita]
    }

    def formComentario_ajax(){
        def cita= Historial.get(params.id)
        return [cita: cita]
    }

    def saveComentario_ajax(){
        def cita = Historial.get(params.id)

        cita.comentarioFinal = params.comentarioFinal

        if(!cita.save(flush:true)){
            println("error al guardar el comentario final " + cita.errors)
            render "no_Error al guardar el comentario final"
        }else{
            render "ok_Guardado correctamente"
        }
    }

    def interconsulta_ajax(){

        def cita

        if(params.id){
            cita = Historial.get(params.id)
        }else{
            cita = new Historial()
        }

        return [cita: cita]
    }

    def saveInterconsulta_ajax (){
        def cita

        if(params.id){
            cita = Historial.get(params.id)
        }else{
            cita = new Historial()
        }

        cita.properties = params

        if(!cita.save(flush:true)){
            println("Error al guardar " + cita.errors)
            render "no_Error al guardar"
        }else{
            render "ok_Guardado correctamente"
        }
    }

    def comboExterno_ajax(){
        def cita = Historial.get(params.id)
        return [cita: cita]
    }

}

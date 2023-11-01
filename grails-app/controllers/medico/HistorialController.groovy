package medico

import apli.DbConnectionService
import geografia.Canton
import geografia.Parroquia
import geografia.Provincia
import seguridad.Paciente

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
        println("params save examen" + params)
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

//        /***************** file upload ************************************************/
//
//
//
//            def path = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.id}/citas/cita_" + historial?.id  + "/"
//            new File(path).mkdirs()
//            def f = request.getFile('file')  //archivo = name del input type file
//
//        if(!f && examen?.path){
//
//        }else{
//            if (f && !f.empty) {
//                def fileName = f.getOriginalFilename() //nombre original del archivo
//
//                def accepted = ["jpg", 'png', "jpeg", "pdf"]
//                def ext = ''
//
//                def parts = fileName.split("\\.")
//                fileName = ""
//                parts.eachWithIndex { obj, i ->
//                    if (i < parts.size() - 1) {
//                        fileName += obj
//                    } else {
//                        ext = obj
//                    }
//                }
//
//                ext = ext.toLowerCase()
//                if (!accepted.contains(ext)) {
//                    render "err_El archivo tiene que ser de tipo jpg, png, jpeg o pdf"
//                    return
//                }
//
//                fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")
//                def archivo = fileName
//                fileName = fileName + "." + ext
//
//                def i = 0
//                def pathFile = path + File.separatorChar + fileName
//                def src = new File(pathFile)
//
//                while (src.exists()) { // verifica si existe un archivo con el mismo nombre
//                    fileName = archivo + "_" + i + "." + ext
//                    pathFile = path + File.separatorChar + fileName
//                    src = new File(pathFile)
//                    i++
//                }
//
//                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
//                examen.path = fileName
//            }
////            else{
////                render "err_Error al guardar el documento. No se ha cargado ningún archivo!"
////                return
////            }
////        }
//
//            /***************** file upload ************************************************/
//


        if (!examen.save(flush: true)) {
            println("Error al guardar el examen" +  examen.errors)
            render "no_Error al guardar el examen"
        }else{
            render "ok_Examen guardado correctamente"
        }
    }

    def formDocExamenes_ajax(){
        def examen = ExamenComplementario.get(params.id)
        return[examen: examen]
    }

    def uploadFileExamen() {
//        println "upload "+params

        def acceptedExt = ["jpg", "png", "jpeg", "pdf"]

        def examen = ExamenComplementario.get(params.id)
        def historial = examen.historial
        def path = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.cedula}/citas/cita_" + historial?.id  + "/"
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
                fileName = fileName + "." + ext
                def pathFile = path + fileName
                def file = new File(pathFile)
                println "subiendo archivo: $fileName"

                f.transferTo(file)

                def old = examen.path
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.cedula}/citas/cita_" + historial?.id  + "/" + old
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
        def examenes = ExamenComplementario.findAllByHistorial(historial)
        return [historial: historial, examenes: examenes]
    }

    def borrarExamen_ajax(){
        def examen = ExamenComplementario.get(params.id)
        def historial = examen.historial

        if(examen){
            try{

                def old = examen.path
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.cedula}/citas/cita_" + historial?.id  + "/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                examen.delete(flush:true)
                render "ok_Examen borrado correctamente"

            }catch(e){
                println("error al borrar el examen " + examen.errors)
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
                    def oldPath = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.cedula}/citas/cita_" + historial?.id  + "/" + old
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
        def path = "/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.cedula}/citas/cita_" + historial?.id  + "/" + examen.path

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
        ImageIO.write(ImageIO.read(new File("/var/medico/empresa/emp_${historial?.paciente?.empresa?.id}/paciente/pac_${historial?.paciente?.cedula}/citas/cita_" + historial?.id  + "/" + nombre + "." + ext)), ext.toString(), baos)
        baos.toByteArray()
    }

}

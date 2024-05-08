package medico

import seguridad.Persona


class DocumentoController {

    def dbConnectionService

    def biblioteca(){
        def usuario = Persona.get(session.usuario.id)
        return [usuario: usuario]
    }


    def tablaBiblioteca_ajax(){

        def usuario = Persona.get(session.usuario.id)

        def bsca
        def sqlTx = ""

        def select = "select * from dcmt "
        def txwh = " where empr__id  = '${usuario.empresa.id}' and " +
                " (dcmtdscr ilike '%${params.criterio}%' or " +
                " dcmtclve ilike '%${params.criterio}%') "
        sqlTx = "${select} ${txwh} order by dcmtdscr limit 100".toString()
        println "sql: $sqlTx"
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]

    }

    def form_ajax(){

        def documentoInstance
        def empresa = Persona.get(session.usuario.id)?.empresa?.id

        if(params.id){
            documentoInstance = Documento.get(params.id)
        }else{
            documentoInstance = new Documento()
        }

        return [documentoInstance: documentoInstance, empresa: empresa]
    }


    def saveDocumento_ajax(){
        def documento

        if(params.id){
            documento = Documento.get(params.id)
        }else{
            documento = new Documento()
        }

        documento.properties = params

        if(!documento.save(flush:true)){
            println("error al guardar el documento")
            render "no_Error al guardar el documento"
        }else{
            render "ok_Documento guardado correctamente"
        }
    }

    def formCargarDocumento_ajax(){
        def documento = Documento.get(params.id)
        return[documento: documento]
    }

    def uploadFileDocumento() {
//        println "upload "+params

        def acceptedExt = ["jpg", "png", "jpeg", "pdf", "doc", "xlsx", "xls"]

        def documento = Documento.get(params.id)
        def empresa = documento.empresa.id
        def path = "/var/medico/empresa/emp_${empresa}/biblioteca/documento_${documento?.id}/"
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

                def old = documento?.ruta
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${empresa}/biblioteca/documento_${documento?.id}/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                documento?.ruta = fileName
                documento.save(flush: true)

            } else {
                render "no_Seleccione un archivo JPG, JPEG, PNG, PDF, DOC, XLS, XLSX"
                return
            }
        } else {
            render "no_Seleccione un archivo JPG, JPEG, PNG, PDF, DOC, XLS, XLSX"
            return
        }

        render "ok_Subido correctamente"
    }

    def downloadFile() {
        def documento = Documento.get(params.id)
        def empresa = documento.empresa.id
        def path = "/var/medico/empresa/emp_${empresa}/biblioteca/documento_${documento?.id}/" + documento.ruta

        def file = new File(path)
        if (file.exists()) {
            def b = file.getBytes()

            def ext = documento.ruta.split("\\.")
            ext = ext[ext.size() - 1]

            response.setContentType(ext == 'pdf' ? "application/pdf" : "image/" + ext)
            response.setHeader("Content-disposition", "attachment; filename=" + documento.ruta)
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        } else {
            flash.clase = "alert-error"
            flash.message = "No se encontró el archivo " + " '" + documento.ruta + "'"
            redirect(action: "errores")
        }
    }

    def borrarDocumentoBiblioteca_ajax(){
        def documento = Documento.get(params.id)
        def empresa = documento.empresa.id

        if(documento){
            try{

                def old = documento.ruta
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${empresa}/biblioteca/documento_${documento?.id}/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                documento.ruta = null
                documento.save(flush:true)
                render "ok_Documento borrado correctamente"

            }catch(e){
                println("error al borrar el documento " + documento.errors)
                render "no_Error al borrar el documento"
            }
        }else{
            render "no_No se encontró el documento"
        }
    }

    def borrarDocumento_ajax(){

        def documento = Documento.get(params.id)
        def empresa = documento.empresa.id

        if(documento){

            if(documento?.ruta){
                def old = documento.ruta
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${empresa}/biblioteca/documento_${documento?.id}/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                documento.ruta = null
                if(!documento.save(flush:true)){
                    render "no_Error al borrar"
                }else{
                    borrar(documento?.id)
                }

            }else{
                borrar(documento?.id)
            }

        }else{
            render "no_No se encontró el documento"
        }

    }

    def borrar(id){

        def documento = Documento.get(id)

        try{
            documento.delete(flush:true)
            render "ok_Borrado correctamente"
        }catch(e){
            println("error al borrar " + documento.errors)
            render "no_Error al borrar"
        }

    }

//    def imprimir(){
//        def documento = Documento.get(4)
//        def empresa = documento.empresa.id
//        def old = documento.ruta
//        def oldPath = "/var/medico/empresa/emp_${empresa}/biblioteca/documento_${documento?.id}/" + old
//        render (
//                file: new File( oldPath ),
//                fileName:"test.pdf",
//                contentType:"application/pdf"
//        )
//    }

    def downloadMyFile(){
        def documento = Documento.get(4)
        def empresa = documento.empresa.id
        def old = documento.ruta
        def oldPath = "/var/medico/empresa/emp_${empresa}/biblioteca/documento_${documento?.id}/" + old
        def file = new File(oldPath)
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "filename=${file.getName()}")
        response.outputStream << file.newInputStream()
    }


}

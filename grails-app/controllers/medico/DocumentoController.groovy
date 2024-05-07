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
                " dcmtdscr ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} order by dcmtdscr limit 100".toString()
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
                render "no_Seleccione un archivo JPG, JPEG, PNG, PDF, DOC, XLS, XLSX"
                return
            }
        } else {
            render "no_Seleccione un archivo JPG, JPEG, PNG, PDF, DOC, XLS, XLSX"
            return
        }

        render "ok_Subido correctamente"
    }


}

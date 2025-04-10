package medico

import seguridad.Persona

class GuiaController {

   def documentos_ajax(){
      println("id " + params)
      def base = Base.get(params.id)
      return [base: base]
   }

   def tablaDocumentos_ajax(){
      def base = Base.get(params.id)
      def guias = Guia.findAllByBase(base).sort{it.id}

      return [guias: guias]
   }

   def uploadDocumento() {

      def acceptedExt = ["jpg", "png", "jpeg", "pdf", "doc", "xlsx", "xls"]

      def base = Base.get(params.id)
      def usuario = Persona.get(session.usuario.id)
      def empresa = usuario.empresa.id

      def path = "/var/medico/empresa/emp_${empresa}/guias/guia_${base?.id}/"
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
            fileName = fileName + "." + ext.toLowerCase()
            def pathFile = path + fileName
            def file = new File(pathFile)
            println "subiendo archivo: $fileName"

            f.transferTo(file)

            def documento = new Guia()
            documento.base = base
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

   def borrarDocumento_ajax(){
      def guia = Guia.get(params.id)
      def base = guia.base
      def usuario = Persona.get(session.usuario.id)
      def empresa = usuario.empresa.id

      if(guia){
         try{

            def old = guia.ruta
            if (old && old.trim() != "") {
               def oldPath = "/var/medico/empresa/emp_${empresa}/guias/guia_${base?.id}/" + old
               def oldFile = new File(oldPath)
               if (oldFile.exists()) {
                  oldFile.delete()
               }
            }

            guia.delete(flush:true)
            render "ok_Documento borrado correctamente"

         }catch(e){
            println("error al borrar el documento " + guia.errors)
            render "no_Error al borrar el documento"
         }
      }else{
         render "no_No se encontró el documento"
      }
   }

   def downloadFile() {
      def guia = Guia.get(params.id)
      def base = guia.base
      def usuario = Persona.get(session.usuario.id)
      def empresa = usuario.empresa.id

      def path = "/var/medico/empresa/emp_${empresa}/guias/guia_${base?.id}/" + guia.ruta

      def file = new File(path)
      if (file.exists()) {
         def b = file.getBytes()

         def ext = guia.ruta.split("\\.")
         ext = ext[ext.size() - 1]

         response.setContentType(ext == 'pdf' ? "application/pdf" : "image/" + ext)
         response.setHeader("Content-disposition", "attachment; filename=" + guia.ruta)
         response.setContentLength(b.length)
         response.getOutputStream().write(b)
      } else {
         flash.clase = "alert-error"
         flash.message = "No se encontró el archivo " + " '" + guia.ruta + "'"
         redirect(action: "errores")
      }
   }
}

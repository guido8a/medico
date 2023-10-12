package seguridad

import geografia.Canton
import geografia.Parroquia
import geografia.Provincia

import javax.imageio.ImageIO

class PacienteController {

    def dbConnectionService

    def list () {
        def empresa

        if(params.id){
            empresa = Empresa.get(params.id)
        }

        return [empresa: empresa]
    }

    def tablaPacientes_ajax () {
        def empresa

        if(params.empresa != '0'){
            empresa = Empresa.get(params.empresa)
        }else{
            empresa = null
        }

        def listaItems = ['pcntcdla', 'pcntapll', 'pcntnmbr']
        def bsca
        def sqlTx = ""
        def bscaEmp = empresa ? " and empr__id = ${empresa?.id}" : " "

        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select = "select * from pcnt "
        def txwh = " where pcnt__id  is not null and " +
                " $bsca ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} ${bscaEmp} order by pcntapll ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]

    }

    def form_ajax () {
        def paciente

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            paciente = new Paciente()
        }

        return[paciente: paciente]
    }

    def savePaciente_ajax () {

        println("params " + params)

        def paciente

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            paciente = new Paciente()
            paciente.fechaInicio = new Date()
        }

       if(params.fechaNacimiento){
           params.fechaNacimiento = new Date().parse("dd-MM-yyyy", params.fechaNacimiento)
       }

        paciente.properties = params

        if(params.activo == '0'){
            paciente.fechaFin = new Date()
        }else{
            paciente.fechaFin = null
        }

        if(!paciente.save(flush: true)){
            println("error al guardar el paciente " + paciente.errors)
            render"no_Error al guardar el paciente"
        }else{
            render "ok_Paciente guardado correctamente"
        }
    }

    def canton_ajax () {
        def paciente
        def provincia = Provincia.get(params.provincia)
        def cantones = Canton.findAllByProvincia(provincia).sort{it.nombre}

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            paciente = null
        }

        return [paciente: paciente, cantones: cantones]
    }

    def parroquia_ajax () {
        def paciente
        def canton = Canton.get(params.canton)
        def parroquias = Parroquia.findAllByCanton(canton).sort{it.nombre}

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            paciente = null
        }

        return [paciente: paciente, parroquias: parroquias]
    }

    def borrarPaciente_ajax(){
        def paciente = Paciente.get(params.id)

        try{
            paciente.delete(flush: true)
            render "ok_Paciente borrado correctamente"
        }catch(e){
            render "no_No se pudo borrar el paciente"
        }
    }

    def show_ajax(){
        def paciente = Paciente.get(params.id)
        return[paciente:paciente]
    }

    def datos() {
        def paciente
        if(params.id){
            paciente = Paciente.get(params.id)

        }else{
            paciente = new Paciente()
        }
        return[paciente:paciente]
    }

    def antecedentes_ajax(){
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]
    }

    def cambiarEstado_ajax(){
        def paciente = Paciente.get(params.id)

        if(paciente.activo == 1){
            paciente.activo = 0
        }else{
            paciente.activo = 1
        }

        if(!paciente.save(flush: true)){
            render "no"
            println("error al cambiar el estado " + paciente.errors)
        }else{
            render "ok"
        }
    }

    def foto_ajax(){
        def paciente = Paciente.get(params.id)
        return[paciente: paciente]

    }

    def uploadFile() {
//        println "upload "+params

        def acceptedExt = ["jpg", "png", "jpeg"]

        def paciente = Paciente.get(params.id)
        def path = "/var/medico/paciente/pac_" + paciente.cedula + "/"
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

                def old = paciente.foto
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/paciente/pac_" + paciente.cedula + "/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                paciente.foto = fileName
                paciente.save(flush: true)

            } else {
                flash.clase = "alert-error"
                flash.message = "Error: Los formatos permitidos son: JPG, JPEG, PNG"
            }
        } else {
            flash.clase = "alert-error"
            flash.message = "Error: Seleccione un archivo JPG, JPEG, PNG"
        }

        redirect(action: "datos", params:[id: paciente?.id])
        return
    }

    def getImage() {
        def paciente = Paciente.get(params.id)

        def nombreArchivo = paciente?.foto?.split("\\.")[0]
        def extensionArchivo = paciente?.foto?.split("\\.")[1]

        byte[] imageInBytes = im(nombreArchivo, extensionArchivo , paciente?.cedula)
        response.with{
            setHeader('Content-length', imageInBytes.length.toString())
            contentType = "image/${extensionArchivo}" // or the appropriate image content type
            outputStream << imageInBytes
            outputStream.flush()
        }
    }

    byte[] im(nombre,ext,paciente) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream()
        ImageIO.write(ImageIO.read(new File("/var/medico/paciente/pac_" + paciente + "/" + nombre + "." + ext)), ext.toString(), baos)
        baos.toByteArray()
    }

    def borrarFoto_ajax() {
        def paciente = Paciente.get(params.id)
        def path = "/var/medico/paciente/pac_" + paciente.cedula + "/${paciente.foto}"

        try{
            paciente.foto = null
            paciente.save(flush: true)
            def file = new File(path).delete()
            render "ok"
        }catch(e){
            println("error al borrar la foto " + e)
            render "no"
        }
    }



}

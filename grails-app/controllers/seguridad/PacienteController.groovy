package seguridad

import geografia.Canton
import geografia.Parroquia
import geografia.Provincia
import medico.Diagnostico
import medico.DiagnosticoxHistorial
import medico.Examen
import medico.ExamenComplementario
import medico.ExamenFisico
import medico.Historial
import medico.Tratamiento

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

        def select = "select pcnt__id, pcntcdla, pcntapll, pcntnmbr, " +
                "replace( replace(replace(age(now()::date, pcntfcna)::text, 'years', 'años'), 'mons','meses'), 'days', 'dias') edad, " +
                "grsndscr, pcntmail, pcntantc from pcnt, grsn "
        def txwh = " where grsn.grsn__id = pcnt.grsn__id and " +
                " $bsca ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} ${bscaEmp} order by pcntapll ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)
        println datos
        
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

//        println("params " + params)

        def paciente

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            paciente = new Paciente()
            paciente.fechaInicio = new Date()
            paciente.activo = 1
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
            render "ok_Paciente guardado correctamente_${paciente?.id}"
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
        return[paciente:paciente, tipo: params.tipo]
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
        def path = "/var/medico/empresa/emp_${paciente?.empresa?.id}/paciente/pac_" + paciente.id + "/"
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
                    def oldPath = "/var/medico/empresa/emp_${paciente?.empresa?.id}/paciente/pac_" + paciente.id + "/" + old
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

        byte[] imageInBytes = im(nombreArchivo, extensionArchivo , paciente?.id)
        response.with{
            setHeader('Content-length', imageInBytes.length.toString())
            contentType = "image/${extensionArchivo}" // or the appropriate image content type
            outputStream << imageInBytes
            outputStream.flush()
        }
    }

    byte[] im(nombre,ext,paciente) {
        def pcnt = Paciente.get(paciente)
        ByteArrayOutputStream baos = new ByteArrayOutputStream()
        ImageIO.write(ImageIO.read(new File("/var/medico/empresa/emp_${pcnt?.empresa?.id}/paciente/pac_" + pcnt?.id + "/" + nombre + "." + ext)), ext.toString(), baos)
        baos.toByteArray()
    }

    def borrarFoto_ajax() {
        def paciente = Paciente.get(params.id)
        def path = "/var/medico/empresa/emp_${paciente?.empresa?.id}/paciente/pac_" + paciente.id + "/${paciente.foto}"

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

    def buscarCitas () {
        def listaCitas = [1: 'Fecha', 2: 'Motivo', 3: 'Diagnóstico']
        return  [listaCitas: listaCitas, pcnt: params.pcnt]
    }

    def tablaCitas(){
        println("tablaCitas " + params)
        def cn = dbConnectionService.getConnection()
        def datos
        def sqlTx = ""
//        def listaItems = ['hsclfcha::text', 'hsclmotv', 'diagdscr']
        def listaItems = ['hsclfcha::text', 'hsclmotv']
        def bsca
        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }

        def select = "select hscl__id, hscl.pcnt__id, hsclfcha, hsclmotv, hsclobsr from hscl " +
                "where pcnt__id = ${params.pcnt} "
        def txwh = " and $bsca ilike '%${params.criterio}%'"
        sqlTx = "${select} ${txwh} order by hsclfcha limit 30 ".toString()

        println "sql: $sqlTx"
        datos = cn.rows(sqlTx)
        [data: datos, tipo: params.tipo]
    }

    def citas (){
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]
    }

    def historial(){
        def paciente = Paciente.get(params.id)
        def cita = Historial.findAllByPacienteAndMotivoNotIlike(paciente, "Ingresar el motivo....",[sort: 'fecha', order: 'desc'])
        def diagnosticos = DiagnosticoxHistorial.findAllByHistorial(cita)
        def tratamientos = Tratamiento.findAllByHistorial(cita)
        def citas = Historial.findAllByPacienteAndEstadoNotEqual(paciente, 'N', [sort: 'fecha', order: 'desc'])
        def citaPendiente = cita? cita.first() : []
        return [paciente: paciente, cita: citaPendiente, diagnosticos: diagnosticos, tratamientos: tratamientos, citas: citas, cita_actual: params.cita]
    }

    def tablaTodasCitas_ajax(){
        def paciente = Paciente.get(params.id)
//        def citas = Historial.findAllByPaciente(paciente, [sort: 'fecha', order: 'desc'])
        def citas = Historial.findAllByPacienteAndEstado(paciente, "R",[sort: 'fecha', order: 'desc'])
        return [citas: citas]
    }

    def examenFisico_ajax(){
        def cita = Historial.get(params.id)
        def examen = ExamenFisico.findByHistorial(cita)
        return[examen: examen]
    }

    def tablaAntecedentes_ajax() {
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]
    }

    def ultimaCita_ajax() {
        def cita = Historial.get(params.id)
        def paciente = Paciente.get(params.paciente)
        def diagnosticos = DiagnosticoxHistorial.findAllByHistorial(cita)
        def tratamientos = Tratamiento.findAllByHistorial(cita)
        return [cita: cita, diagnosticos: diagnosticos, tratamientos: tratamientos, paciente: paciente]
    }

    def examenLaboratorio_ajax(){
        def cita = Historial.get(params.id)
        def examenes = ExamenComplementario.findAllByHistorial(cita)
        return[examenes: examenes]
    }

    def tablaDatos_ajax(){
        def paciente = Paciente.get(params.id)
        return[paciente: paciente]
    }

    def datos_ajax(){
        def paciente = Paciente.get(params.id)
        return[paciente: paciente]
    }

    def comboCitas_ajax() {
        def paciente = Paciente.get(params.id)
        def citas = Historial.findAllByPacienteAndEstadoNotEqual(paciente, 'N', [sort: 'fecha', order: 'desc'])
        def cita = Historial.get(params.cita)
        return [citas: citas, cita: cita]
    }

}

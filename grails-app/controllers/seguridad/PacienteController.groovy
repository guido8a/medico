package seguridad

import geografia.Canton
import geografia.Parroquia
import geografia.Provincia
import medico.Diagnostico
import medico.DiagnosticoxHistorial
import medico.Examen
import medico.ExamenComplementario
import medico.ExamenFisico
import medico.GrupoExamen
import medico.Historial
import medico.Medicina
import medico.TipoExamen
import medico.Tratamiento
import sri.DocumentoEmpresa
import sri.Establecimiento

import javax.imageio.ImageIO

class PacienteController {

    def dbConnectionService

    def list() {
        println "list: $params"
        def usuario = Persona.get(session.usuario.id)
        def consultorio = usuario.empresa
        def empresa
        if (params.id) {
            empresa = Empresa.get(params.id)
        }
        def pacientes = Paciente.countByEmpresa(consultorio)

        return [empresa: empresa, pacientes: pacientes, criterio: Paciente.get(params.id)?.apellido]
    }

    def tablaPacientes_ajax() {
        println "tablaPacientes_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa

        def listaItems = ['pcntcdla', 'pcntapll', 'pcntnmbr']
        def bsca
        def sqlTx = ""
        def bscaEmp = empresa ? " and empr__id = ${empresa?.id}" : " "

        if (params.buscarPor) {
            bsca = listaItems[params.buscarPor?.toInteger() - 1]
        } else {
            bsca = listaItems[0]
        }

        def select = "select pcnt__id, pcntcdla, pcntapll, pcntpath, pcntnmbr, " +
                "replace( replace( replace(replace(age(now()::date, pcntfcna)::text, 'year', 'año'), 'mons','meses'), " +
                "'day', 'dia'), 'mon', 'mes') edad, " +
                "grsndscr, pcntmail, pcntantc from pcnt, grsn "

        def criterio = params.criterio
//        def txwh = " where grsn.grsn__id = pcnt.grsn__id and " +
//                " $bsca ilike '%${params.criterio}%' "
        def txwh = ""
        try {
            criterio = params.criterio.toInteger()
            txwh = " where grsn.grsn__id = pcnt.grsn__id and " +
                    "pcntcdla ilike '%${params.criterio}%'"
        } catch (e) {
            txwh = " where grsn.grsn__id = pcnt.grsn__id and " +
                    "(pcntnmbr ilike '%${criterio}%' or pcntapll ilike '%${criterio}%')"
        }
        sqlTx = "${select} ${txwh} ${bscaEmp} order by pcntapll limit 25".toString()
        println "sql: ${sqlTx}"
        def datos = cn.rows(sqlTx)
//        println datos

        [datos: datos, buscarPor: params.buscarPor]

    }

    def form_ajax() {
        def paciente

        if (params.id) {
            paciente = Paciente.get(params.id)
        } else {
            paciente = new Paciente()
        }

        return [paciente: paciente]
    }

    def savePaciente_ajax() {

        println("params " + params)
        def error = 0
        def paciente
        def existeCedula

        if(params.cedula){
            existeCedula = Paciente.findByCedula(params.cedula)
            println "existe_id: ${existeCedula?.id}"
        }

        if(params.id){
            paciente = Paciente.get(params.id)
        }else{
            if(existeCedula){
                render "err_Ya existe un paciente con esta cédula"
                return
            }

            def persona = Persona.get(session.usuario.id)
            def consultorio = persona.empresa

            paciente = new Paciente()
            paciente.fechaInicio = new Date()
            paciente.empresa = consultorio
            paciente.activo = 1
        }

        if (params.fechaNacimiento) {
            params.fechaNacimiento = new Date().parse("dd-MM-yyyy", params.fechaNacimiento)
        }

        paciente.properties = params

        if (params.activo == '0') {
            paciente.fechaFin = new Date()
        } else {
            paciente.fechaFin = null
        }

//        if (error == 1) {
//            render "no_El número de historia clínica ya se encuentra asignado "
//        } else {
        if (!paciente.save(flush: true)) {
            println("error al guardar el paciente " + paciente.errors)
            render "no_Error al guardar el paciente"
        } else {
            render "ok_Paciente guardado correctamente_${paciente?.id}"
        }
//        }
    }

    def canton_ajax() {
        def paciente
        def provincia = Provincia.get(params.provincia)
        def cantones = Canton.findAllByProvincia(provincia).sort { it.nombre }

        if (params.id) {
            paciente = Paciente.get(params.id)
        } else {
            paciente = null
        }

        return [paciente: paciente, cantones: cantones]
    }

    def parroquia_ajax() {
        def paciente
        def canton = Canton.get(params.canton)
        def parroquias = Parroquia.findAllByCanton(canton).sort { it.nombre }

        if (params.id) {
            paciente = Paciente.get(params.id)
        } else {
            paciente = null
        }

        return [paciente: paciente, parroquias: parroquias]
    }

    def borrarPaciente_ajax() {
        def paciente = Paciente.get(params.id)

        try {
            paciente.delete(flush: true)
            render "ok_Paciente borrado correctamente"
        } catch (e) {
            render "no_No se pudo borrar el paciente"
        }
    }

    def show_ajax() {
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]
    }

    def datos() {
        def paciente
        if (params.id) {
            paciente = Paciente.get(params.id)

        } else {
            paciente = new Paciente()
        }
        return [paciente: paciente, tipo: params.tipo]
    }

    def antecedentes_ajax() {
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]
    }

    def cambiarEstado_ajax() {
        def paciente = Paciente.get(params.id)

        if (paciente.activo == 1) {
            paciente.activo = 0
        } else {
            paciente.activo = 1
        }

        if (!paciente.save(flush: true)) {
            render "no"
            println("error al cambiar el estado " + paciente.errors)
        } else {
            render "ok"
        }
    }

    def foto_ajax() {
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]

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
                render  "no_Seleccione un archivo JPG, JPEG, PNG"
                return
            }
        } else {
            render  "no_Seleccione un archivo JPG, JPEG, PNG"
            return
        }

        render "ok_Imagen guardada correctamente"
    }

    def getImage() {
        def paciente = Paciente.get(params.id)

        def nombreArchivo = paciente?.foto?.split("\\.")[0]
        def extensionArchivo = paciente?.foto?.split("\\.")[1]

        byte[] imageInBytes = im(nombreArchivo, extensionArchivo, paciente?.id)
        response.with {
            setHeader('Content-length', imageInBytes.length.toString())
            contentType = "image/${extensionArchivo}" // or the appropriate image content type
            outputStream << imageInBytes
            outputStream.flush()
        }
    }

    byte[] im(nombre, ext, paciente) {
        def pcnt = Paciente.get(paciente)
        ByteArrayOutputStream baos = new ByteArrayOutputStream()
        ImageIO.write(ImageIO.read(new File("/var/medico/empresa/emp_${pcnt?.empresa?.id}/paciente/pac_" + pcnt?.id + "/" + nombre + "." + ext)), ext.toString(), baos)
        baos.toByteArray()
    }

    def borrarFoto_ajax() {
        def paciente = Paciente.get(params.id)
        def path = "/var/medico/empresa/emp_${paciente?.empresa?.id}/paciente/pac_" + paciente.id + "/${paciente.foto}"

        try {
            paciente.foto = null
            paciente.save(flush: true)
            def file = new File(path).delete()
            render "ok"
        } catch (e) {
            println("error al borrar la foto " + e)
            render "no"
        }
    }

    def buscarCitas() {
        def listaCitas = [1: 'Fecha', 2: 'Motivo', 3: 'Diagnóstico']
        return [listaCitas: listaCitas, pcnt: params.pcnt]
    }

    def tablaCitas() {
        println("tablaCitas " + params)
        def cn = dbConnectionService.getConnection()
        def datos
        def sqlTx = ""
//        def listaItems = ['hsclfcha::text', 'hsclmotv', 'diagdscr']
        def listaItems = ['hsclfcha::text', 'hsclmotv']
        def bsca
        if (params.buscarPor) {
            bsca = listaItems[params.buscarPor?.toInteger() - 1]
        } else {
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

    def citas() {
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]
    }

    def historial() {
        println "historial: $params"
        def paciente = Paciente.get(params.id)
        def cita = Historial.findAllByPacienteAndEstado(paciente, "A", [sort: 'fecha', order: 'desc'])
        def diagnosticos = cita ? DiagnosticoxHistorial.findAllByHistorial(cita) : []
        def tratamientos = Tratamiento.findAllByHistorial(cita)
        def citas = Historial.findAllByPacienteAndEstadoNotEqual(paciente, 'N', [sort: 'fecha', order: 'desc'])
        def citaPendiente = cita ? cita.first() : []
        println "cita_anterior: ${params.cita}"
        def citaActual = params.citaActual
        return [paciente: paciente, cita: citaPendiente, diagnosticos: diagnosticos, tratamientos: tratamientos,
                citas: citas, cita_actual: params.cita]
    }

    def tablaTodasCitas_ajax() {
        def paciente = Paciente.get(params.id)
        def citas = Historial.findAllByPacienteAndEstado(paciente, "R", [sort: 'fecha', order: 'desc'])
        return [citas: citas]
    }

    def examenFisico_ajax() {
        def cita = Historial.get(params.id)
        def examen = ExamenFisico.findByHistorial(cita)
        def paciente = Paciente.get(params.paciente)
        def edad = (new Date() - paciente.fechaNacimiento)/365.25
        return [examen: examen, paciente: paciente, cita: cita, edad: edad]
    }

    def tablaAntecedentes_ajax() {
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]
    }

    def ultimaCita_ajax() {
        def cita = Historial.get(params.id)
        def paciente = Paciente.get(params.paciente)
        def diagnosticos = DiagnosticoxHistorial.findAllByHistorial(cita).sort { it.diagnostico.codigo }
        def tratamientos = Tratamiento.findAllByHistorial(cita).sort{it.orden}
        return [cita: cita, diagnosticos: diagnosticos, tratamientos: tratamientos, paciente: paciente]
    }

    def examenLaboratorio_ajax() {
        def cita = Historial.get(params.id)
        def grupoExamen = GrupoExamen.get(6)
        def tipoExamen = TipoExamen.findAllByGrupoExamen(grupoExamen)
        def examenes = ExamenComplementario.findAllByHistorialAndTipoExamenNotInList(cita, tipoExamen, [sort: "id"])

        return [examenes: examenes, cita: cita]
    }

    def tablaDatos_ajax() {
        def paciente = Paciente.get(params.id)
        def edad = calculaEdad( new Date().format('yyyy-MM-dd'), paciente?.fechaNacimiento.format('yyyy-MM-dd'))
        return [paciente: paciente, edad: edad]
    }

    def datos_ajax() {
        def paciente

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa

        def pacientes = Paciente.findAllByEmpresa(empresa)
        def numeroActual = pacientes?.numeroHistorial?.max()

        if (params.id) {
            paciente = Paciente.get(params.id)
        } else {
            paciente = new Paciente()
        }

        return [paciente: paciente, numeroSiguiente: (numeroActual ? (numeroActual?.toInteger() + 1) : 1)]
    }

    def comboCitas_ajax() {
        println "comboCitas_ajax: $params"
        def paciente = Paciente.get(params.id)
        def citas = Historial.findAllByPacienteAndEstadoNotEqual(paciente, 'N', [sort: 'fecha', order: 'desc'])
        def cita = Historial.get(params.cita)
        if(params.cita_anterior) {
            cita = Historial.get(params.cita_anterior)
        }
        return [citas: citas, cita: cita]
    }

    def cambiarEstadoCita_ajax() {
        def cita = Historial.get(params.id)

        cita.estado = 'N'

        if (!cita.save(flush: true)) {
            println("Error al cambiar de estado la cita " + cita.errors)
            render "no_Error al dar de baja la cita"
        } else {
            render "ok_Guardado correctamente"
        }
    }

    def botones_ajax() {
        def cita = Historial.get(params.id)
        def paciente = Paciente.get(params.paciente)
        def dianosticos = DiagnosticoxHistorial.findAllByHistorial(cita)
        def tratamientos = Tratamiento.findAllByHistorial(cita)
        return [cita: cita, paciente: paciente, diagnosticos: dianosticos, tratamientos: tratamientos]
    }

    def finalizarCita_ajax() {
        def cita = Historial.get(params.id)

        cita.estado = 'R'

        if (!cita.save(flush: true)) {
            println("Error al cambiar de estado la cita " + cita.errors)
            render "no_Error al dar de baja la cita"
        } else {
            render "ok_Guardado correctamente"
        }
    }

    def estado_ajax() {
        def cita = Historial.get(params.id)
        return [cita: cita]
    }

    def edad_ajax() {
        def fcha = ""
        def resultado = ""
        if(params.fecha){
            fcha = new Date().parse("dd-MM-yyyy", params.fecha).format('yyyy-MM-dd')
            resultado = calculaEdad(new Date().format('yyyy-MM-dd'), fcha)
        }
        render resultado
    }

    def calculaEdad(fcha, fcna) {
        def cn = dbConnectionService.getConnection()
        def sql = "select replace( replace( replace(replace( age('${fcha}'::date, '${fcna}'::date)::text, 'year', 'año'), 'mons','meses'), " +
                "'day', 'dia'), 'mon', 'mes') edad "
        println "sql: $sql"
        def edad = cn.rows( sql.toString() )[0]?.edad

        return edad
    }

    def cargarCitasAnteriores_ajax(){
        def paciente = Paciente.get(params.id)
        return [paciente: paciente]
    }

    def uploadCitasAnteriores(){
        println "upload " + params

        def acceptedExt = ["pdf"]

        def paciente = Paciente.get(params.id)
        def path = "/var/medico/empresa/emp_${paciente?.empresa?.id}/paciente/pac_${paciente?.id}/"
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

                def old = paciente.path
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${paciente?.empresa?.id}/paciente/pac_${paciente?.id}/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                paciente.path = fileName
                paciente.save(flush: true)

            } else {
                render "no_Seleccione un archivo PDF"
                return
            }
        } else {
            render "no_Seleccione un archivo PDF"
            return
        }

        render "ok_Subido correctamente"
    }

    def borrarDocCitasAnteriores_ajax(){
        def paciente = Paciente.get(params.id)

        if(paciente?.path){
            try{

                def old = paciente.path
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_${paciente?.empresa?.id}/paciente/pac_${paciente?.id}/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                paciente.path = null
                paciente.save(flush:true)
                render "ok_Documento borrado correctamente"

            }catch(e){
                println("error al borrar el examen " + examen.errors)
                render "no_Error al borrar el documento"
            }
        }else{
            render "no_No se encontró el documento"
        }
    }

    def downloadDocumentoCitasAnteriores() {
        def paciente = Paciente.get(params.id)
        def path = "/var/medico/empresa/emp_${paciente?.empresa?.id}/paciente/pac_${paciente?.id}/" + paciente.path

        def file = new File(path)
        if (file.exists()) {
            def b = file.getBytes()

            def ext = paciente.path.split("\\.")
            ext = ext[ext.size() - 1]

            response.setContentType(ext == 'pdf' ? "application/pdf" : "image/" + ext)
            response.setHeader("Content-disposition", "attachment; filename=" + paciente.path)
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        } else {
            flash.clase = "alert-error"
            flash.message = "No se encontró el documento " + " '" + paciente.path + "'"
            redirect(action: "errores")
        }
    }

    def geo_ajax() {

    }

    def situacionGeografica() {
        println "situacionGeografica" + params
        def comunidades
        def orden;
        def colorProv, colorCant, colorParr, colorComn;
        def select = "select provnmbr, cntnnmbr, parrnmbr, prov.prov__id, cntn.cntn__id, parr.parr__id " +
                "from prov, cntn, parr"
        def txwh = "where cntn.prov__id = prov.prov__id and parr.cntn__id = cntn.cntn__id "
        def campos = ['provnmbr', 'cntnnmbr', 'parrnmbr']
        def cmpo = params.buscarPor?.toInteger()
        def sqlTx = ""
        cmpo = cmpo?: 1

        if (params.ordenar == '1') {
            orden = "asc";
        } else {
            orden = "desc";
        }

        txwh += " and ${campos[cmpo - 1]} ilike '%${params.criterio}%'"

        sqlTx = "${select} ${txwh} order by ${campos[cmpo - 1]} ${orden} limit 70".toString()
        println "sql: cmpo: $cmpo $sqlTx"

        def cn = dbConnectionService.getConnection()
        comunidades = cn.rows(sqlTx)
        [comunidades: comunidades, colorComn: colorComn, colorProv: colorProv, colorParr: colorParr, colorCant: colorCant]

    }

    def datosCompletos_ajax() {
        def paciente

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa

        def pacientes = Paciente.findAllByEmpresa(empresa)
        def numeroActual = pacientes?.numeroHistorial?.max()

        if (params.id) {
            paciente = Paciente.get(params.id)
        } else {
            paciente = new Paciente()
        }

        return [paciente: paciente, numeroSiguiente: (numeroActual ? (numeroActual?.toInteger() + 1) : 1)]
    }

    def historicoExamenes_ajax(){
//        Cita, Fecha, Exámenes, Archivo
        println "historicoExamenes_ajax: $params"
        def cn = dbConnectionService.getConnection()
//        def paciente = Paciente.get(params.paciente)
//        def citas = Historial.findAllByPaciente(paciente, [sort: 'fecha', ])
//        def sql = "select distinct hscl.hscl__id, hsclmotv, hsclfcha, excmpath, " +
//                "(select array(select examdscr from dtex, exam where exam.exam__id = dtex.exam__id and " +
//                "dtex.excm__id in (select excm__id from excm ec where ec.hscl__id = hscl.hscl__id) ) as examenes) " +
//                "from hscl, excm where excm.hscl__id = hscl.hscl__id and pcnt__id = ${params.paciente} and " +
//                "excmpath is not null order by hsclfcha"

        def sql = "select hscl.hscl__id, hsclmotv, hsclfcha, excmpath, excm.excm__id, " +
                "string_agg(examdscr, ',' order by examdscr) examenes " +
                "from hscl, excm, exam, dtex where excm.hscl__id = hscl.hscl__id and " +
                "pcnt__id = ${params.paciente} and " +
                "excmpath is not null and dtex.excm__id = excm.excm__id and exam.exam__id = dtex.exam__id " +
                "group by hscl.hscl__id, hsclmotv, hsclfcha, excmpath, excm.excm__id;"

        println "sql: $sql"
        def data = cn.rows(sql.toString())
        return [citas: data]
    }

    def archivosPorExamen_ajax(){
        def cita = Historial.get(params.id)
        def examenes = ExamenComplementario.findAllByHistorialAndPathIsNotNull(cita, [sort: "id"])
        return [examenes: examenes]
    }

    def examenImagen_ajax() {
        def cita = Historial.get(params.id)
        def grupoExamen = GrupoExamen.get(6)
        def tipoExamen = TipoExamen.findAllByGrupoExamen(grupoExamen)
        def examenes = ExamenComplementario.findAllByHistorialAndTipoExamenInList(cita, tipoExamen, [sort: "id"])
        return [examenes: examenes, cita: cita]
    }

    def facturas(){
        println("params " + params)
        def paciente = Paciente.get(params.id)
        def empresa = paciente.empresa
        return [paciente: paciente, empresa: empresa]
    }

    def datosEmpresaFactura_ajax(){
        def empresa = Empresa.get(params.id)
        return [empresa: empresa]
    }

    def datosFactura_ajax(){
        def empresa = Empresa.get(params.id)
        return [empresa: empresa]
    }

    def datosLibretin_ajax(){
        def empresa = Empresa.get(params.id)
        return [empresa: empresa]
    }

    def libretines_ajax(){
        def establecimiento = Establecimiento.get(params.establecimiento)
        return [establecimiento: establecimiento]
    }

    def fechasValidez_ajax(){
        def libretin = DocumentoEmpresa.get(params.id)
        return [libretin: libretin]
    }

    def numeracionFactura_ajax(){
        def libretin = DocumentoEmpresa.get(params.id)
        return [libretin: libretin]
    }

    def datosPersona_ajax(){
        def paciente = Paciente.get(params.id)
        return [persona: paciente]
    }

    def formaDePago_ajax(){

    }
}

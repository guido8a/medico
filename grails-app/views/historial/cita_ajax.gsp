<g:form class="form-horizontal" name="frmCita" controller="historial" action="saveCita_ajax">
    <g:hiddenField name="paciente" value="${historial?.paciente?.id}"/>
    <g:hiddenField name="id" value="${historial?.id}"/>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label class="col-md-2 control-label text-info" style="text-align: left">
                Paciente
            </label>
            <span class="col-md-6">
                <g:textField name="nombrePaciente" class="form-control" readonly="" value=" ${historial?.paciente?.apellido + ' ' + historial?.paciente?.nombre + " - " + historial?.paciente?.cedula}"/>
            </span>
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label class="col-md-2 control-label text-info" style="text-align: left">
                Especialista
            </label>
            <span class="col-md-4">
                <g:select name="persona" from="${seguridad.Persona.list().sort{it.nombre}}" optionKey="id" optionValue="nombre" class="form-control " value="${historial?.persona?.id}" />
            </span>
            <label class="col-md-2 control-label text-info" style="text-align: left">
                Fecha de la cita
            </label>
            <span class="grupo" >
                <span class="col-md-2 " >
                    <input aria-label="" name="fecha" id='fecha' required type='text' class="form-control required"
                           value="${historial?.fecha ? historial?.fecha?.format("dd-MM-yyyy") : new Date().format("dd-MM-yyyy")}" />
                </span>
            </span>
            <label class="col-md-1 control-label text-info" style="text-align: left">
                Hora
            </label>
            <span class="grupo" >
                <span class="col-md-1 " >
                    <g:textField name="hora" class="form-control" value=" ${historial?.hora}"/>
                </span>
            </span>
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label class="col-md-2 control-label text-info" style="text-align: left">
                Motivo de consulta
            </label>
            <span class="col-md-10">
                <g:textArea name="motivo" maxlength="255" required="" style="resize: none; height: 60px;" class="form-control required"  value="${historial?.motivo}"/>
            </span>

        </div>
    </div>
    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label class="col-md-2 control-label text-info" style="text-align: left">
                Enfermedad actual
            </label>
            <span class="col-md-10">
                <g:textArea name="actual" maxlength="255" class="form-control" style="resize: none; height: 60px;"  value="${historial?.actual}"/>
            </span>
        </div>
    </div>
    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label class="col-md-2 control-label text-info" style="text-align: left">
                Exámenes
            </label>
            <span class="col-md-10">
                <g:textArea name="examenes" maxlength="255" class="form-control" style="resize: none; height: 60px;"  value="${historial?.examenes}"/>
            </span>
        </div>
    </div>
    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label class="col-md-2 control-label text-info" style="text-align: left">
                Observaciones
            </label>
            <span class="col-md-10">
                <g:textArea name="observaciones" maxlength="255" class="form-control" style="resize: none; height: 60px;"  value="${historial?.observaciones}"/>
            </span>
        </div>
    </div>
</g:form>

<script type="text/javascript">

    $('#fecha, #proximaCita').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });


</script>
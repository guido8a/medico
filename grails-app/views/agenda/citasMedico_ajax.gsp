<div class="modal-contenido">
    <g:each in="${citas}" var="cita">
        <div class="row">
            <label class="col-md-1  text-info">
                Médico:
            </label>
            <div class="col-md-3 text-success">
                <g:set var="medico" value="${seguridad.Persona.get(cita?.persona?.id)}" />
                ${(medico?.apellido ?: '')  + " " + (medico?.nombre ?: '')}
            </div>

            <label class="col-md-1  text-info">
                Paciente:
            </label>
            <div class="col-md-3 text-success">
                <g:set var="paciente" value="${seguridad.Paciente.get(cita?.paciente?.id)}" />
                ${(paciente?.apellido ?: '')  + " " + (paciente?.nombre ?: '')}
            </div>
        </div>
    </g:each>
</div>
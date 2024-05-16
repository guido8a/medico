<div class="modal-contenido">
    <div class="form-group keeptogether">
    <div class="col-md-6">
        <span class="grupo">
            <label class="col-md-2 control-label">
                Paciente
            </label>

            <div class="col-md-12" id="divPacientes">
                <g:select name="paciente" from="${pacientes}" class="form-control" optionKey="id" optionValue="${{it.apellido + " " + it.nombre}}"/>
            </div>
        </span>
    </div>
    </div>
</div>
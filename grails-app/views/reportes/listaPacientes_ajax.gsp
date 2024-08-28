<div class="modal-contenido">
    <div class="form-group keeptogether">
    <div class="col-md-12">
        <span class="grupo">
            <div class="col-md-2">
                <label class="control-label">
                    Paciente
                </label>
            </div>
            <div class="col-md-10" id="divPacientes">
                <g:select name="paciente" from="${pacientes}" class="form-control" optionKey="id"
                          optionValue="${{it.apellido + " " + it.nombre}}"/>
            </div>
        </span>
    </div>
    </div>
</div>
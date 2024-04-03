<g:form class="form-horizontal" name="frmAgenda" role="form" controller="agenda" action="saveAgenda_ajax" method="POST">
    <g:hiddenField name="semana" value="${semana?.id}" />
    <g:hiddenField name="persona" value="${persona?.id}" />
    <g:hiddenField name="dias" value="${dia?.id}" />
    <g:hiddenField name="hora" value="${hora?.id}" />
    <g:hiddenField name="id" value="${agenda?.id}" />

    <div class="form-group">
        <span class="grupo">
            <label for="paciente" class="col-md-2 control-label text-info">
                Paciente
            </label>
            <span class="col-md-4">
                <g:select from="${seguridad.Paciente.list([sort: 'apellido'])}" optionKey="id" optionValue="${{it.apellido + " " + it.nombre }}"  name="paciente" class="form-control" value="${agenda?.paciente?.id}"/>
            </span>
        </span>
    </div>

    <div class="form-group">
        <span class="grupo">
            <label for="observaciones" class="col-md-2 control-label text-info">
                Observaciones
            </label>
            <span class="col-md-10">
                <g:textArea name="observaciones" style="resize: none; height: 100px" maxlength="255" class="form-control" value="${agenda?.observaciones}" />
            </span>
        </span>
    </div>
</g:form>
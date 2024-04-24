
<g:form class="form-horizontal" name="frmAntecedentes" role="form" controller="paciente" action="savePaciente_ajax" method="POST">
    <g:hiddenField name="id" value="${paciente?.id}" />

    <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentes', 'error')}">
        <span class="grupo">
            <label for="antecedentes" class="col-md-2 control-label text-info">
                Antecedentes
            </label>
            <span class="col-md-8">
                <g:textArea name="antecedentes" style="resize: none; height: 70px" maxlength="255" class="form-control" value="${paciente?.antecedentes}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'alergias', 'error')}">
        <span class="grupo">
            <label for="alergias" class="col-md-2 control-label text-info">
                Alergias
            </label>
            <span class="col-md-8">
                <g:textArea name="alergias" style="resize: none; height: 70px" maxlength="255" class="form-control" value="${paciente?.alergias}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentesOcupacionales', 'error')}">
        <span class="grupo">
            <label for="antecedentesOcupacionales" class="col-md-2 control-label text-info">
                Antecedentes ocupacionales
            </label>
            <span class="col-md-8">
                <g:textArea name="antecedentesOcupacionales" style="resize: none; height: 70px" maxlength="255" class="form-control" value="${paciente?.antecedentesOcupacionales}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentesPatologicosFam', 'error')}">
        <span class="grupo">
            <label for="antecedentesPatologicosFam" class="col-md-2 control-label text-info">
                Antecedentes patológicos familiares
            </label>
            <span class="col-md-8">
                <g:textArea name="antecedentesPatologicosFam" style="resize: none; height: 70px" maxlength="255" class="form-control" value="${paciente?.antecedentesPatologicosFam}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'habitos', 'error')}">
        <span class="grupo">
            <label for="habitos" class="col-md-2 control-label text-info">
                Hábitos
            </label>
            <span class="col-md-8">
                <g:textArea name="habitos" style="resize: none; height: 70px" maxlength="255" class="form-control" value="${paciente?.habitos}"/>
            </span>
        </span>
    </div>

    <g:if test="${paciente?.sexo == 'F'}">
        <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentesGinecobstreticos', 'error')}">
            <span class="grupo">
                <label for="antecedentesGinecobstreticos" class="col-md-2 control-label text-info">
                    Antecedentes Gineco Obstétricos
                </label>
                <span class="col-md-8">
                    <g:textArea name="antecedentesGinecobstreticos" style="resize: none; height: 70px" maxlength="255" class="form-control" value="${paciente?.antecedentesGinecobstreticos}"/>
                </span>
            </span>
        </div>
    </g:if>
</g:form>
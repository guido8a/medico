
<g:form class="form-horizontal" name="frmAntecedentes" role="form" controller="paciente" action="savePaciente_ajax" method="POST">
    <g:hiddenField name="id" value="${paciente?.id}" />

    <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentesOcupacionales', 'error')}">
        <span class="grupo">
            <label for="antecedentesOcupacionales" class="col-md-2 control-label text-info">
                Antecedentes patológicos personales
            </label>
            <span class="col-md-10">
                <g:textArea name="antecedentesOcupacionales" style="resize: none; height: 70px" maxlength="255" class="form-control" value="${paciente?.antecedentesOcupacionales}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'alergias', 'error')}">
        <span class="grupo">
            <label for="alergias" class="col-md-2 control-label text-info">
                Alergias
            </label>
            <span class="col-md-10">
                <g:textField name="alergias" maxlength="255" class="form-control"
                            value="${paciente?.alergias}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentesPatologicosFam', 'error')}">
        <span class="grupo">
            <label for="antecedentesPatologicosFam" class="col-md-2 control-label text-info">
                Antecedentes patológicos familiares
            </label>
            <span class="col-md-10">
                <g:textArea name="antecedentesPatologicosFam" style="resize: none; height: 70px" maxlength="255" class="form-control" value="${paciente?.antecedentesPatologicosFam}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'habitosAlimentario', 'error')}">
        <span class="grupo">
            <label for="habitos" class="col-md-2 control-label text-info">
                Hábitos Alimentarios
            </label>
            <span class="col-md-10">
                <g:textField name="habitosAlimentario" maxlength="255" class="form-control" value="${paciente?.habitosAlimentario}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'habitosUrinario', 'error')}">
        <span class="grupo">
            <label for="habitos" class="col-md-2 control-label text-info">
                Hábitos Urinarios
            </label>
            <span class="col-md-2">
                <g:field type="number" name="habitosUrinario" maxlength="2" class="form-control" value="${paciente?.habitosUrinario}"/>
            </span>
            <label for="habitos" class="col-md-2 control-label text-info">
                Hábitos Defecatorios
            </label>
            <span class="col-md-2">
                <g:field name="habitosDefecatorio" type="number" maxlength="2" class="form-control" value="${paciente?.habitosDefecatorio}"/>
            </span>
        </span>
    </div>

    <g:if test="${!paciente?.nino}">
        <div class="form-group ${hasErrors(bean: paciente, field: 'habitosFumador', 'error')}">
            <span class="grupo">
                <label for="habitos" class="col-md-2 control-label text-info">
                    Hábitos Fumador
                </label>
                <span class="col-md-10">
                    <g:textField name="habitosFumador"  maxlength="255" class="form-control" value="${paciente?.habitosFumador}"/>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: paciente, field: 'habitosTomador', 'error')}">
            <span class="grupo">
                <label for="habitos" class="col-md-2 control-label text-info">
                    Hábitos Tomador
                </label>
                <span class="col-md-10">
                    <g:textField name="habitosTomador"  maxlength="255" class="form-control" value="${paciente?.habitosTomador}"/>
                </span>
            </span>
        </div>
    </g:if>
    <div class="form-group ${hasErrors(bean: paciente, field: 'habitos', 'error')}">
        <span class="grupo">
            <label for="habitos" class="col-md-2 control-label text-info">
                Otros Hábitos
            </label>
            <span class="col-md-10">
                <g:textField name="habitos"  maxlength="255" class="form-control" value="${paciente?.habitos}"/>
            </span>
        </span>
    </div>

    <g:if test="${paciente?.obstetricia}">
        <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentesGinecobstreticos', 'error')}">
            <span class="grupo">
                <label for="antecedentesGinecobstreticos" class="col-md-2 control-label text-info">
                    Antecedentes Gineco Obstétricos
                </label>
                <span class="col-md-10">
                    <g:textArea name="antecedentesGinecobstreticos" style="resize: none; height: 70px" maxlength="255" class="form-control" value="${paciente?.antecedentesGinecobstreticos}"/>
                </span>
            </span>
        </div>
    </g:if>

    <g:if test="${paciente?.nino}">
        <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentesDespuesdeNacer', 'error')}">
            <span class="grupo">
                <label for="habitos" class="col-md-2 control-label text-info">
                    Datos al nacer
                </label>
                <span class="col-md-10">
                    <g:textField name="antecedentesDespuesdeNacer"  maxlength="255" class="form-control" value="${paciente?.antecedentesDespuesdeNacer}"/>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentesAntesdeNacer', 'error')}">
            <span class="grupo">
                <label for="antecedentesAntesdeNacer" class="col-md-2 control-label text-info">
                    Vida antenatal
                </label>
                <span class="col-md-10">
                    <g:textArea name="antecedentesAntesdeNacer"  style="resize: none; height: 70px" maxlength="1024" class="form-control" value="${paciente?.antecedentesAntesdeNacer}"/>
                </span>
            </span>
        </div>
    </g:if>

</g:form>

<script type="text/javascript">

    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }


    $("#habitosUrinario, #habitosDefecatorio").keydown(function (ev) {
        return validarNum(ev);
    });


</script>

<div class="span" role="main">
    <g:uploadForm class="form-horizontal" method="post" name="frmExamenFisico" action="saveExamenFisico_ajax">
        <g:hiddenField name="id" value="${examen?.id}"/>
        <g:hiddenField name="paciente" value="${paciente.id}"/>

        <div class="form-group ${hasErrors(bean: examen, field: 'fecha', 'error')} required">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Fecha
                </label>
                <span class="col-md-4">
                    <input aria-label="" name="fechaExamenFisico" id='fechaExamenFisico' type='text' class="form-control required" value="${examen?.fecha?.format("dd-MM-yyyy") ?: new java.util.Date().format("dd-MM-yyyy")}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'cabeza', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Cabeza
                </label>
                <span class="col-md-5">
                    <g:textField name="cabeza" maxlength="255" class="form-control" value="${examen?.cabeza}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info">
                    Cuello
                </label>
                <span class="col-md-5">
                    <g:textField name="cuello" maxlength="255" class="form-control" value="${examen?.cuello}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'torax', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Torax
                </label>
                <span class="col-md-5">
                    <g:textField name="torax" maxlength="255" class="form-control" value="${examen?.torax}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Cardio Pulmonar
                </label>
                <span class="col-md-5">
                    <g:textField name="cardioPulmonar" maxlength="255" class="form-control" value="${examen?.cardioPulmonar}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'abdomen', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Abdomen
                </label>
                <span class="col-md-5">
                    <g:textField name="abdomen" maxlength="255" class="form-control" value="${examen?.abdomen}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Región Lumbar
                </label>
                <span class="col-md-5">
                    <g:textField name="regionLumbar" maxlength="255" class="form-control" value="${examen?.regionLumbar}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'neurologico', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Neurológico
                </label>
                <span class="col-md-5">
                    <g:textField name="neurologico" maxlength="255" class="form-control" value="${examen?.neurologico}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Genitales
                </label>
                <span class="col-md-5">
                    <g:textField name="genitales" maxlength="255" class="form-control" value="${examen?.genitales}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'extremidadesSuperiores', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Extremidades superiores
                </label>
                <span class="col-md-5">
                    <g:textField name="extremidadesSuperiores" maxlength="255" class="form-control" value="${examen?.extremidadesSuperiores}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Extremidades inferiores
                </label>
                <span class="col-md-5">
                    <g:textField name="extremidadesInferiores" maxlength="255" class="form-control" value="${examen?.extremidadesInferiores}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'peso', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Peso
                </label>
                <span class="col-md-2">
                    <g:textField name="peso" maxlength="4" class="form-control" value="${examen?.peso ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Talla
                </label>
                <span class="col-md-2">
                    <g:textField name="talla" maxlength="4" class="form-control" value="${examen?.talla ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    IMC
                </label>
                <span class="col-md-2">
                    <g:textField name="imc" maxlength="4" class="form-control" value="${examen?.imc ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    IC
                </label>
                <span class="col-md-2">
                    <g:textField name="ic" maxlength="4" class="form-control" value="${examen?.ic ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'temperatura', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Temperatura
                </label>
                <span class="col-md-2">
                    <g:textField name="temperatura" maxlength="4" class="form-control" value="${examen?.temperatura ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    SO2
                </label>
                <span class="col-md-2">
                    <g:textField name="so2" maxlength="4" class="form-control" value="${examen?.so2 ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    FC
                </label>
                <span class="col-md-2">
                    <g:textField name="fc" maxlength="4" class="form-control" value="${examen?.fc ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Glucosa
                </label>
                <span class="col-md-2">
                    <g:textField name="glucosa" maxlength="4" class="form-control" value="${examen?.glucosa ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'sistole', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Sístole
                </label>
                <span class="col-md-2">
                    <g:textField name="sistole" maxlength="4" class="form-control" value="${examen?.sistole ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Diástole
                </label>
                <span class="col-md-2">
                    <g:textField name="diastole" maxlength="4" class="form-control" value="${examen?.diastole ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

    </g:uploadForm>
</div>

<script type="text/javascript">

    $('#fechaExamenFisico').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });


    $("#frmExamenFisico").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });

</script>

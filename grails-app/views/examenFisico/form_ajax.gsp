
<div class="span" role="main">
    <g:uploadForm class="form-horizontal" method="post" name="frmExamenFisico" action="saveExamenFisico_ajax">
        <g:hiddenField name="id" value="${examen?.id}"/>
        <g:hiddenField name="historial" value="${historial.id}"/>

        <div class="form-group ${hasErrors(bean: examen, field: 'fecha', 'error')} required">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Fecha
                </label>
                <span class="col-md-2">
                    <input aria-label="" name="fechaExamenFisico" id='fechaExamenFisico' type='text' class="form-control required" value="${examen?.fecha?.format("dd-MM-yyyy") ?: new java.util.Date().format("dd-MM-yyyy")}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>


        <div class="col-md-12" style="border-top: solid; border-width: 1px; border-color: #888; text-align: center">Valores numéricos</div>

        <div class="form-group ${hasErrors(bean: examen, field: 'peso', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Peso
                </label>
                <span class="col-md-2">
                    <span class="input-group input-group-sm">
                        <g:textField name="peso" maxlength="4" class="form-control" value="${examen?.peso ?: 0}" />
                        <span class="input-group-addon">kg</span>
                    </span>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Talla
                </label>
                <span class="col-md-2">
                    <span class="input-group input-group-sm">
                        <g:textField name="talla" maxlength="10" class="form-control" value="${examen?.talla ?: 0}" />
                        <span class="input-group-addon">m</span>
                    </span>
                </span>

                <label class="col-md-1 control-label text-info" style="text-align: left">
                    IMC
                </label>
                <span class="col-md-2">
                    <g:textField name="imc" readonly="" class="form-control"  value="${formatNumber(number: examen?.imc ?: ( (examen?.peso && examen?.talla) ? ( (examen?.peso != 0 && examen?.talla != 0) ? (examen?.peso?.toDouble() / (examen?.talla?.toDouble() * examen?.talla?.toDouble()) ) : 0 ) : 0  ), format: '##,##0', maxFractionDigits: 3, minFractionDigits: 3, locale: 'ec')}" />

                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    I. Cintura
                </label>
                <span class="col-md-2">
                    <span class="input-group input-group-sm">
                        <g:textField name="ic" maxlength="4" class="form-control" value="${examen?.ic ?: 0}" title="Índice de cintura" />
                        <span class="input-group-addon">cm</span>
                    </span>
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
                    <g:textField name="so2" maxlength="4" class="form-control" value="${examen?.so2 ?: 95}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    FC
                </label>
                <span class="col-md-2">
                    <g:textField name="fc" maxlength="10" class="form-control" value="${examen?.fc ?: 0}" title="Frecuencia cardíaca" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Glucosa
                </label>
                <span class="col-md-2">
                    <g:textField name="glucosa" maxlength="10" class="form-control" value="${examen?.glucosa ?: 0}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'sistole', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Tensión arterial 1
                </label>
                <span class="col-md-1">
                    <g:textField name="sistole1" maxlength="4" class="form-control" value="${examen?.sistole1 ?: 0}" style="width: 50px"/>
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <span class="col-md-1" style="margin-left: -20px; margin-top: 10px"><i class="fa fa-slash"></i></span>
                <span class="col-md-1">
                    <g:textField name="diastole1" maxlength="4" class="form-control" value="${examen?.diastole1 ?: 0}" style="margin-left: -55px; width: 50px"/>
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>

            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Tensión arterial 2
                </label>
                <span class="col-md-1">
                    <g:textField name="sistole2" maxlength="4" class="form-control" value="${examen?.sistole2 ?: 0}" style="width: 50px" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <span class="col-md-1" style="margin-left: -20px; margin-top: 10px"><i class="fa fa-slash"></i></span>
                <span class="col-md-1">
                    <g:textField name="diastole2" maxlength="4" class="form-control" value="${examen?.diastole2 ?: 0}" style="margin-left: -55px; width: 50px"/>
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="col-md-12" style="border-top: solid; border-width: 1px; border-color: #888; text-align: center">Valores de Texto</div>



        <div class="form-group ${hasErrors(bean: examen, field: 'cabezaCraneo', 'error')} ">
            <span class="grupo">
                <label class="col-md-12 control-label text-info" style="text-align: center">
                    Cabeza
                </label>
                <label class="col-md-1 control-label text-info">
                    Cráneo
                </label>
                <span class="col-md-5">
                    <g:textField name="cabezaCraneo" maxlength="255" class="form-control" value="${examen?.cabezaCraneo ?: 'Normal'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info">
                    Cara
                </label>
                <span class="col-md-5">
                    <g:textField name="cabezaCara" maxlength="255" class="form-control" value="${examen?.cabezaCara ?: 'Normal'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'cuello', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Cuello
                </label>
                <span class="col-md-5">
                    <g:textField name="cuello" maxlength="255" class="form-control" value="${examen?.cuello ?: 'Normal'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Cardio Pulmonar
                </label>
                <span class="col-md-5">
                    <g:textField name="cardioPulmonar" maxlength="255" class="form-control" value="${examen?.cardioPulmonar ?: 'Normal'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'torax', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Torax
                </label>
                <span class="col-md-11">
                    <g:textField name="torax" maxlength="255" class="form-control" value="${examen?.torax ?: 'Normal'}" />
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
                    <g:textField name="abdomen" maxlength="255" class="form-control" value="${examen?.abdomen ?: 'Normal'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Región Lumbar
                </label>
                <span class="col-md-5">
                    <g:textField name="regionLumbar" maxlength="255" class="form-control" value="${examen?.regionLumbar ?: 'Normal'}" />
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
                    <g:textField name="neurologico" maxlength="255" class="form-control" value="${examen?.neurologico ?: 'Normal'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Genitales
                </label>
                <span class="col-md-5">
                    <g:textField name="genitales" maxlength="255" class="form-control" value="${examen?.genitales ?: 'No se explora'}" />
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
                    <g:textField name="extremidadesSuperiores" maxlength="255" class="form-control" value="${examen?.extremidadesSuperiores ?: 'Normal'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
                <label class="col-md-1 control-label text-info" style="text-align: left">
                    Extremidades inferiores
                </label>
                <span class="col-md-5">
                    <g:textField name="extremidadesInferiores" maxlength="255" class="form-control" value="${examen?.extremidadesInferiores ?: 'Normal'}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'pielFaneras', 'error')} ">
            <span class="grupo" >
                <label class="col-md-2 control-label text-info">
                    Piel y Faneras
                </label>
                <span class="col-md-10" style="margin-top: 10px !important;">
                    <g:textField name="pielFaneras" maxlength="255" class="form-control" value="${examen?.pielFaneras}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

    </g:uploadForm>
</div>

<script type="text/javascript">

    $("#peso, #talla").keyup(function (ev) {
        var peso = $("#peso").val();
        var talla = $("#talla").val();
        var imc =  (peso && talla) ? ( (peso !== 0 && talla !== 0) ? (peso / (talla * talla) ) : 0 ) : 0;

        if(imc){
            $("#imc").val(number_format(imc, 3, ".", ""))
        }else{
            $("#imc").val(0)
        }
    });

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
            ev.keyCode === 190 || ev.keyCode === 110 ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }


    $("#peso, #talla, #ic, #temperatura, #so2, #fc, #glucosa, #sistole1, #sistole2, #diastole1, #diastole2").keydown(function (ev) {
        return validarNum(ev);
    });


</script>

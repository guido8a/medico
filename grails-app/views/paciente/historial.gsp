
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Historial del paciente: ${paciente?.apellido + " " + paciente?.nombre}
    </title>
</head>
<body>

<div class="row" style="margin-bottom: 10px">
    <div class="btn-group col-md-6" >
        <a href="${createLink(controller: 'paciente', action: 'list')}" class="btn btn-info" title="Retornar a búsqueda de pacientes">
            <i class="fas fa-arrow-left"></i> Lista de pacientes
        </a>
    </div>
</div>

<div class="btn-group row" style="margin-top: 20px; text-align: center">
    <span style="font-size: 20px; font-weight: bold">Historial del paciente: ${paciente?.apellido + " " + paciente?.nombre}</span>
</div>

<div class="row">
    <div class="col-md-4">
        <a href="${createLink(controller: 'paciente', action: 'datos', id: paciente?.id)}" class="btn btn-primary" title="datos de afiliación">
            <i class="fas fa-user"></i> Datos de afiliación
        </a>
        %{--        <span class="badge badge-secondary" style="font-size: 16px">Datos de afiliación</span>--}%
    </div>
</div>

<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Apellidos:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.apellido}</td>
            <td style="width: 10%" class="alert alert-info">Nombres:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.nombre}</td>
            <td style="width: 10%;" class="alert alert-info">Cédula:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.cedula}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Edad:</td>
            <td style="width: 20%; background-color: #c1cfe7">${""}</td>
            <td style="width: 15%" class="alert alert-info">Fecha nacimiento:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.fechaNacimiento?.format("dd-MM-yyyy")}</td>
            <td style="width: 15%;" class="alert alert-info">Lugar nacimiento:</td>
            <td style="width: 20%;background-color: #c1cfe7">${""}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Dirección:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.direccion}</td>
            <td style="width: 15%" class="alert alert-info">Teléfono:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.telefono}</td>
            <td style="width: 15%;" class="alert alert-info">Email:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.mail}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Estado Civil:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.estadoCivil?.descripcion}</td>
            <td style="width: 15%" class="alert alert-info">Sexo:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.sexo == 'M' ? 'MASCULINO' : 'FEMENINO'}</td>
            <td style="width: 15%;" class="alert alert-info">G. Sanguineo:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.grupoSanguineo?.descripcion}</td>
        </tr>
        </tbody>
    </table>
</div>

<div class="row" style="margin-top: 20px">
    <div class="col-md-4">
        <a href="#" class="btn btn-primary" id="btnAntecedentes" title="Antecedentes">
            <i class="fas fa-book"></i> Antecedentes
        </a>
        %{--        <span class="badge badge-secondary" style="font-size: 16px">Antecedentes</span>--}%
    </div>
</div>

<div id="divAntecedentes">

</div>


<div class="row" style="margin-top: 20px">
    <div class="col-md-2" style="font-size: 12px; font-weight: bolder">
        <span class="badge badge-secondary" style="font-size: 16px">Seleccione una cita</span>
    </div>
    <div class="col-md-4">
        <g:select name="citaSeleccionada" from="${citas}" optionValue="${{it?.fecha?.format("dd-MM-yyyy") + " - " + it?.motivo}}" optionKey="id" class="form-control" />
%{--        <span class="badge badge-secondary" style="font-size: 16px">Cita</span>--}%
    </div>
</div>

<div class="row" style="margin-top: 10px">
    <div class="col-md-3">
    <a href="#" class="btn btn-primary" id="btnUltimaCita" title="Ir a la cita">
        <i class="fas fa-book"></i> Datos de la Cita
    </a>
    </div>
</div>

<div id="divUltimaCita">

</div>

%{--<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">--}%
%{--    <table class="table-bordered table-condensed " style="width: 100%">--}%
%{--        <tbody>--}%
%{--        <tr style="font-size: 16px">--}%
%{--            <td style="width: 20%; font-weight: bolder" class="alert alert-warning">Motivo de consulta:</td>--}%
%{--            <td style="width: 80%; background-color: #ccb35d">${cita?.motivo}</td>--}%
%{--        </tr>--}%
%{--        <tr style="font-size: 16px">--}%
%{--            <td style="width: 20%;font-weight: bolder" class="alert alert-warning">Enfermedad actual:</td>--}%
%{--            <td style="width: 80%; background-color:#ccb35d">${cita?.actual}</td>--}%
%{--        </tr>--}%
%{--        </tbody>--}%
%{--    </table>--}%
%{--</div>--}%

%{--<div class="row" style="margin-top: 20px">--}%
%{--    <div class="col-md-4">--}%
%{--        <a href="#" class="btn btn-primary" id="btnUltimoExamenFisico" title="Último Examen Físico">--}%
%{--            <i class="fas fa-book"></i> Último Examen Físico--}%
%{--        </a>--}%
%{--    </div>--}%
%{--</div>--}%

%{--<div id="divExamenFisico">--}%

%{--</div>--}%


%{--<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">--}%
%{--    <table class="table-bordered table-condensed " style="width: 100%">--}%
%{--        <tbody>--}%
%{--        <tr style="font-size: 16px">--}%
%{--            <td style="width: 20%;font-weight: bolder" class="alert alert-warning">Diagnóstico:</td>--}%
%{--            <td style="width: 80%; background-color:#ccb35d">--}%
%{--                <g:if test="${diagnosticos.size() > 0}">--}%
%{--                    <table class="table table-bordered table-striped table-condensed table-hover">--}%
%{--                        <thead>--}%
%{--                        <tr style="width: 100%">--}%
%{--                            <th style="width: 10%">Código</th>--}%
%{--                            <th style="width: 50%">Descripción </th>--}%
%{--                            <th style="width: 30%">Observaciones </th>--}%
%{--                        </tr>--}%
%{--                        </thead>--}%
%{--                        <tbody >--}%
%{--                        <g:each in="${diagnosticos}" status="i" var="diagnostico">--}%
%{--                            <tr style="width: 100%">--}%
%{--                                <td style="width: 10%">${diagnostico?.diagnostico?.codigo}</td>--}%
%{--                                <td style="width: 50%">${diagnostico?.diagnostico?.descripcion}</td>--}%
%{--                                <td style="width: 30%">${diagnostico?.descripcion}</td>--}%
%{--                            </tr>--}%
%{--                        </g:each>--}%
%{--                        </tbody>--}%
%{--                    </table>--}%
%{--                </g:if>--}%
%{--                <g:else>--}%
%{--                    <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin diagnósticos</div>--}%
%{--                </g:else>--}%
%{--            </td>--}%
%{--        </tr>--}%
%{--        <tr style="font-size: 16px">--}%
%{--            <td style="width: 20%;font-weight: bolder" class="alert alert-warning">Tratamiento:</td>--}%
%{--            <td style="width: 80%; background-color:#ccb35d">--}%
%{--                <g:if test="${tratamientos.size() > 0}">--}%
%{--                    <table class="table table-bordered table-striped table-condensed table-hover">--}%
%{--                        <thead>--}%
%{--                        <tr style="width: 100%">--}%
%{--                            <th style="width: 10%">Medicina </th>--}%
%{--                            <th style="width: 10%">Concentración </th>--}%
%{--                            <th style="width: 10%">Cantidad </th>--}%
%{--                            <th style="width: 35%">Prescripción</th>--}%
%{--                        </tr>--}%
%{--                        </thead>--}%
%{--                        <tbody >--}%
%{--                        <g:each in="${tratamientos}" status="i" var="tratamiento">--}%
%{--                            <tr style="width: 100%">--}%
%{--                                <td style="width: 25%">${tratamiento?.medicina?.codigo ? (tratamiento?.medicina?.codigo  + " - " + tratamiento?.medicina?.descripcion) : ''}</td>--}%
%{--                                <td style="width: 10%">${tratamiento?.medicina?.concentracion}</td>--}%
%{--                                <td style="width: 8%">${tratamiento?.cantidad}</td>--}%
%{--                                <td style="width: 47%">${tratamiento?.descripcion}</td>--}%
%{--                            </tr>--}%
%{--                        </g:each>--}%
%{--                        </tbody>--}%
%{--                    </table>--}%
%{--                </g:if>--}%
%{--                <g:else>--}%
%{--                    <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin tratamiento</div>--}%
%{--                </g:else>--}%
%{--            </td>--}%
%{--        </tr>--}%
%{--        </tbody>--}%
%{--    </table>--}%
%{--</div>--}%



<div class="row" style="margin-top: 20px; margin-bottom: 10px">
    <div class="col-md-4">
        <span class="badge badge-secondary" style="font-size: 16px">Citas médicas</span>
    </div>
</div>

<div id="divTablaCitas">

</div>


<script type="text/javascript">

    %{--$("#btnUltimoExamenFisico").click(function () {--}%
    %{--    createEditRowExamenFisico();--}%
    %{--});--}%

    %{--function createEditRowExamenFisico(id) {--}%
    %{--    var title = id ? "Editar " : "Crear ";--}%
    %{--    var data = {--}%
    %{--        id: id,--}%
    %{--        historial: '${cita?.id}'--}%
    %{--    };--}%
    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url: "${createLink(controller: 'examenFisico',  action:'form_ajax')}",--}%
    %{--        data    : data,--}%
    %{--        success : function (msg) {--}%
    %{--            cf = bootbox.dialog({--}%
    %{--                id      : "dlgCreateEditExamenFisico",--}%
    %{--                title   : " Examen Físico",--}%
    %{--                class: "modal-lg",--}%
    %{--                message : msg,--}%
    %{--                buttons : {--}%
    %{--                    // cancelar : {--}%
    %{--                    //     label     : "Cancelar",--}%
    %{--                    //     className : "btn-primary",--}%
    %{--                    //     callback  : function () {--}%
    %{--                    //     }--}%
    %{--                    // },--}%
    %{--                    guardar  : {--}%
    %{--                        id        : "btnSave",--}%
    %{--                        label     : "<i class='fa fa-save'></i> Guardar",--}%
    %{--                        className : "btn-success",--}%
    %{--                        callback  : function () {--}%
    %{--                            return submitFormExamenFisico();--}%
    %{--                        } //callback--}%
    %{--                    } //guardar--}%
    %{--                } //buttons--}%
    %{--            }); //dialog--}%
    %{--        } //success--}%
    %{--    }); //ajax--}%
    %{--} //createEdit--}%

    %{--function submitFormExamenFisico() {--}%
    %{--    var $form = $("#frmExamenFisico");--}%
    %{--    if ($form.valid()) {--}%
    %{--        var data = $form.serialize();--}%
    %{--        var dialog = cargarLoader("Guardando...");--}%
    %{--        $.ajax({--}%
    %{--            type    : "POST",--}%
    %{--            url     : $form.attr("action"),--}%
    %{--            data    : data,--}%
    %{--            success : function (msg) {--}%
    %{--                dialog.modal('hide');--}%
    %{--                var parts = msg.split("_");--}%
    %{--                if(parts[0] === 'ok'){--}%
    %{--                    log(parts[1], "success");--}%
    %{--                    cargarExamenFisico();--}%
    %{--                }else{--}%
    %{--                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');--}%
    %{--                    return false;--}%

    %{--                }--}%
    %{--            }--}%
    %{--        });--}%
    %{--    } else {--}%
    %{--        return false;--}%
    %{--    }--}%
    %{--}--}%


    $("#btnUltimaCita").click(function () {
        var cita = $("#citaSeleccionada option:selected").val();
        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + '${paciente?.id}' + "&id=" + cita + "&tipo=" + 1
    });

    $("#btnAntecedentes").click(function () {
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'antecedentes_ajax')}",
            data    : {
                id: '${paciente?.id}'
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditAntecedentes",
                    title   : "Antecedentes del paciente",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormAntecedentes();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    function submitFormAntecedentes() {
        var $form = $("#frmAntecedentes");
        if ($form.valid()) {
            var data = $form.serialize();
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log(parts[1], "success");
                        cargarTablaAntecedentes();
                    }else{
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;

                    }
                }
            });
        } else {
            return false;
        }
    }

    $("#citaSeleccionada").change(function () {
       var cita = $(this).val();
       cargarUltimaCita(cita);
    });

    cargarUltimaCita($("#citaSeleccionada option:selected").val());

    function cargarUltimaCita(cita) {
        var d = cargarLoader("Cargando...");
        var paciente = '${paciente?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'ultimaCita_ajax')}',
            data:{
                paciente: paciente,
                id: cita
            },
            success: function (msg){
                d.modal("hide");
                $("#divUltimaCita").html(msg)
            }
        })
    }

    cargarTablaAntecedentes();

    function cargarTablaAntecedentes() {
        var d = cargarLoader("Cargando...");
        var paciente = '${paciente?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'tablaAntecedentes_ajax')}',
            data:{
                id: paciente
            },
            success: function (msg){
                d.modal("hide");
                $("#divAntecedentes").html(msg)
            }
        })
    }

    cargarTablaCitas();

    function cargarTablaCitas() {
        var d = cargarLoader("Cargando...");
        var paciente = '${paciente?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'tablaTodasCitas_ajax')}',
            data:{
                id: paciente
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaCitas").html(msg)
            }
        })
    }

    cargarExamenFisico();

    function cargarExamenFisico() {
        var d = cargarLoader("Cargando...");
        var paciente = '${paciente?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'examenFisico_ajax')}',
            data:{
                id: paciente
            },
            success: function (msg){
                d.modal("hide");
                $("#divExamenFisico").html(msg)
            }
        })
    }

</script>


</body>
</html>

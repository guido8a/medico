
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
    <div class="btn-group col-md-4" >
        <a href="${createLink(controller: 'paciente', action: 'list')}" class="btn btn-info" title="Retornar a búsqueda de pacientes">
            <i class="fas fa-arrow-left"></i> Lista de pacientes
        </a>
    </div>
    <div class="btn-group col-md-6" >
        <span class="badge badge-pill badge-primary fa-2x">Historial del paciente: ${paciente?.apellido + " " + paciente?.nombre}</span>
    </div>

</div>

<h3>Datos de afiliación</h3>

<div id="divDatos">

</div>


<div id="divAntecedentes">

</div>

<h3> Citas médicas </h3>

<div class="row">
    <div class="col-md-2" style="font-size: 12px; font-weight: bolder; width: 270px">
        <span class="badge badge-pill badge-primary fa-2x">Seleccione la cita a visualizar</span>
    </div>
    <div class="col-md-6" id="divComboCita">
        %{--        <g:select name="citaSeleccionada" from="${citas}" optionValue="${{it?.fecha?.format("dd-MMM-yyyy HH:mm") + " - " + it?.motivo}}"--}%
        %{--                  optionKey="id" class="form-control" value="${cita_actual}" />--}%
    </div>
    <div class="col-md-3">
        <a href="#" class="btn btn-success" id="btnCrearCita" title="Nueva cita">
            <i class="fas fa-plus"></i> Crear Cita
        </a>
%{--        <a href="#" class="btn btn-warning" id="btnNuevaCita" title="Agendar próxima cita" >--}%
%{--            <i class="fas fa-plus"></i> Agendar Cita--}%
%{--        </a>--}%
    </div>
</div>

<div id="divUltimaCita">

</div>

<div class="row">
    <div class="col-md-2">
        <a href="#" class="btn btn-warning" id="btnNuevaCita" title="Agendar próxima cita" >
            <i class="fas fa-plus"></i> Agendar Cita
        </a>
    </div>
</div>



<h3>Citas médicas Anteriores</h3>

<div id="divTablaCitas">

</div>


<script type="text/javascript">

    cargarComboCita($("#citaSeleccionada option:selected").val());

    function cargarComboCita(actual){
        var paciente = '${paciente?.id}';
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'comboCitas_ajax')}',
            data:{
                id: paciente,
                cita: actual
            },
            success: function (msg){
                d.modal("hide");
                $("#divComboCita").html(msg)
            }
        })
    }


    $("#btnCrearCita").click(function () {
        editaDatosCita();
    });

    $("#btnDatosCita").click(function () {
        var cita = $("#citaSeleccionada option:selected").val();
        editaDatosCita(cita);
    });

    function editaDatosCita(cita) {
        var paciente = '${paciente?.id}';
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'historial', action:'cita_ajax')}",
            data    : {
                id: cita,
                paciente: paciente
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditCita",
                    title   : "Cita del paciente",
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
                                return submitFormDatosCita(cita);
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }

    function submitFormDatosCita(cita) {
        var $form = $("#frmCita");
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
                        cargarComboCita(cita);
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

    %{--$("#btnCreaCita").click(function () {--}%
    %{--    var cita = $("#citaSeleccionada option:selected").val();--}%
    %{--    location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + '${paciente?.id}' + "&tipo=" + 3--}%
    %{--});--}%

    $("#btnNuevaCita").click(function () {
        location.href="${createLink(controller: 'agenda', action: 'agenda')}?paciente=" + '${paciente?.id}'
    });

    function editaPaciente() {
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'datos_ajax')}",
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
                                return submitFormPaciente();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }

    function submitFormPaciente() {
        var $form = $("#frmPaciente");
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
                        cargarDatos();
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

    function editaAntecedentes() {
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
    }

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

    cargarDatos();

    function cargarDatos() {
        var d = cargarLoader("Cargando datos...");
        var paciente = '${paciente?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'tablaDatos_ajax')}',
            data:{
                id: paciente
            },
            success: function (msg){
                d.modal("hide");
                $("#divDatos").html(msg)
            }
        })
    }


</script>


</body>
</html>

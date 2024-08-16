
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Historia Clínica
    </title>

    <style>

    .modal{
        overflow-y: auto;
    }

    .modal-open{
        overflow:auto;
    }

    </style>

</head>
<body>

<div class="row" style="margin-bottom: 10px">
    <div class="btn-group col-md-4" >
        <a href="${createLink(controller: 'paciente', action: 'list')}" class="btn btn-info" title="Retornar a búsqueda de pacientes">
            <i class="fas fa-arrow-left"></i> Lista de pacientes
        </a>
    </div>
    <div class="btn-group col-md-8" >
        <span class="badge badge-pill badge-primary fa-2x">Historial del paciente: ${paciente?.apellido + " " + paciente?.nombre}
        HC:${paciente?.numeroHistorial}
        </span>
        <span class="badge badge-pill badge-info fa-2x">HC:${paciente?.numeroHistorial}</span>
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

    </div>
    <div class="col-md-3">
        <a href="#" class="btn btn-success" id="btnCrearCita" title="Nueva cita">
            <i class="fas fa-plus"></i> Crear Cita
        </a>
    </div>
</div>

<div id="divEstado" style="margin-top: 10px">

</div>

<div id="divUltimaCita">

</div>

<div class="row">
    <div class="col-md-6" id="divBotones">

    </div>
</div>

<div class="row">
    <h3 class="col-md-3">Citas médicas Anteriores</h3>

    <g:if test="${paciente?.path}">
        <div class="col-md-2" style="float: right; margin-top: 10px">
            <g:link action="downloadDocumentoCitasAnteriores" class="btn btn-success btnDescargarDocCitasAnteriores"
                    rel="tooltip" title="Descargar" id="${paciente?.id}">
                <i class="fa fa-download"></i> HC Anterior
            </g:link>
        </div>
    </g:if>
</div>

<div id="divTablaCitas">

</div>

<script type="text/javascript">

    function borrarCita() {
        var cita = $("#citaSeleccionada option:selected").val();
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea dar de baja la cita seleccionada? Esta acción no se puede deshacer.</p>",
            closeButton: false,
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-trash'></i> Dar de baja",
                    className: "btn-danger",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(controller: 'paciente', action:'cambiarEstadoCita_ajax')}',
                            data: {
                                id: cita
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] === 'ok') {
                                    log(parts[1], "success");
                                    setTimeout(function () {
                                        location.reload()
                                    }, 1000);
                                } else {
                                    log(parts[1], "error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function finalizarCita() {
        var cita = $("#citaSeleccionada option:selected").val();
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea finalizar la cita seleccionada? Esta acción no se puede deshacer.</p>",
            closeButton: false,
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-check'></i> Finalizar",
                    className: "btn-success",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(controller: 'paciente', action:'finalizarCita_ajax')}',
                            data: {
                                id: cita
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] === 'ok') {
                                    log(parts[1], "success");
                                    cargarComboCita(cita);
                                } else {
                                    log(parts[1], "error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

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

    function cargarBotones(cita){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'botones_ajax')}',
            data:{
                id: cita,
                paciente: '${paciente?.id}'
            },
            success: function (msg){
                $("#divBotones").html(msg)
            }
        })
    }

    function cargarEstado(cita){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'estado_ajax')}',
            data:{
                id: cita
            },
            success: function (msg){
                $("#divEstado").html(msg)
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

    %{--$("#btnNuevaCita").click(function () {--}%
    %{--    location.href="${createLink(controller: 'agenda', action: 'agenda')}?paciente=" + '${paciente?.id}'--}%
    %{--});--}%

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
                    title   : "Datos del paciente",
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



    function graficoNina() {
        var paciente = '${paciente?.id}';
        var g = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'examen', action:'graficoNina_ajax')}",
            data    : {
                paciente: paciente
            },
            success : function (msg) {
                g.modal("hide");
                var b = bootbox.dialog({
                    id      : "dlgFraficoNina",
                    title   : "Gráfico Estadístico",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cerrar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }



</script>

</body>
</html>
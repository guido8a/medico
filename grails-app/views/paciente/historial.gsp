
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
        <span style="font-size: 20px; font-weight: bold">Historial del paciente: ${paciente?.apellido + " " + paciente?.nombre}</span>
    </div>

</div>


<div class="row">
    <div class="col-md-12">
        <a href="#" class="btn btn-info col-md-12" role="alert" id="btnDatos" title="Datos de afiliación">
            <i class="fas fa-user"></i> Datos de afiliación
        </a>
    </div>
</div>

<div id="divDatos">

</div>

<div class="row" style="margin-top: 15px">
    <div class="col-md-12">
        <a href="#" class="btn btn-info col-md-12" id="btnAntecedentes" title="Antecedentes">
            <i class="fas fa-edit"></i> Antecedentes
        </a>
    </div>
</div>

<div id="divAntecedentes">

</div>

<div class="row">
    <div class="btn btn-success col-md-12">
        Citas médicas
    </div>
</div>

<div class="row">
    <div class="col-md-3" style="font-size: 12px; font-weight: bolder">
        <div class="btn btn-success col-md-12" style="font-size: 16px">Seleccione la cita a visualizar</div>
    </div>
    <div class="col-md-5">
        <g:select name="citaSeleccionada" from="${citas}" optionValue="${{it?.fecha?.format("dd-MMM-yyyy HH:mm") + " - " + it?.motivo}}"
                  optionKey="id" class="form-control" value="${cita_actual}" />
    </div>
    <div class="col-md-2">
        <a href="#" class="btn btn-info" id="btnUltimaCita" title="Ir a la cita">
            <i class="fas fa-edit"></i> Datos de la Cita
        </a>
    </div>
    <div class="col-md-2">
        <a href="#" class="btn btn-info" id="btnNuevaCita" title="Crear una cita">
            <i class="fas fa-plus"></i> Nueva Cita
        </a>
    </div>
</div>

<div id="divUltimaCita">

</div>

<div class="row" style="margin-top: 20px; margin-bottom: 10px">
    <div class="col-md-12">
        <div class="alert alert-primary col-md-12" style="font-size: 16px">Citas médicas Anteriores</div>
    </div>
</div>

<div id="divTablaCitas">

</div>


<script type="text/javascript">

    $("#btnUltimaCita").click(function () {
        var cita = $("#citaSeleccionada option:selected").val();
        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + '${paciente?.id}' + "&id=" + cita + "&tipo=" + 1
    });

    $("#btnNuevaCita").click(function () {
        location.href="${createLink(controller: 'agenda', action: 'agenda')}?paciente=" + '${paciente?.id}'
    });

    $("#btnDatos").click(function () {
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
    });

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

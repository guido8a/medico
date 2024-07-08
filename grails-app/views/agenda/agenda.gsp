<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Agenda</title>

    <style type="text/css">
    .gestion > td {
        /*background-color: #ff8080;*/
        background-color: #edc384;
        color: #0c0460;
    }

    .normal > td {
        background-color: #d7dff9;
        color: #0c3440;
    }
    .usado {
        text-align: center !important;
        background-image: repeating-linear-gradient(#618acf, #c1faf8, #618acf)
    }
    .conjunta {
        text-align: center !important;
        color: #404040;
        border-top-left-radius: 20px;
        border-bottom-right-radius: 20px;
    }
    .otro {
        text-align: center !important;
        background-color: #edc384;
    }
    .clase_hoy {
        text-align: center !important;
        background-color: #7380b3;
        /*background-color: #133053;*/
    }
    .libre {
        color: #606060;
    }
    .horas {
        text-align: center !important;
    }

    .titl {
        font-family: 'open sans condensed';
        font-weight: bold;
        text-shadow: -2px 2px 1px rgba(0, 0, 0, 0.25);
        color: #0070B0;
        margin-top: 15px;
        text-align: center;
    }
    </style>

</head>

<body>


<div class="col-md-12">
    <h3 class="titl" style="margin-top: 5px">Agenda del médico: <span id="divNombreMedico" style="color: #aa7700"></span></h3>
</div>

<div class="btn-toolbar toolbar" style="margin-top: 10px">
    <div class="col-md-2">
        <g:if test="${paciente}">
            <a href="${createLink(controller: 'paciente', action: 'historial')}/${paciente}"  class="btn btn-sm btn-info"
               style="float: left; margin-top: 25px" title="Retornar a historial del paciente">
                <i class="fas fa-arrow-left"></i> Regresar a Historial
            </a>
        </g:if>
        <g:else>
            <a href="${createLink(controller: 'paciente', action: 'list')}"  class="btn btn-sm btn-info"
               style="float: left; margin-top: 25px" title="Retornar a lista de pacientes">
                <i class="fas fa-arrow-left"></i> Regresar a Pacientes
            </a>
        </g:else>

    </div>

    <div class="col-md-2">
        <label for="fecha" class="col-md-1 control-label" style="text-align: right">
            Fecha
        </label>
        <input aria-label="" name="fecha" id='fecha' type='text' class="form-control" value="${new Date()?.format("dd-MM-yyyy")}" />
    </div>

    %{--<div class="col-md-3">--}%
        %{--<label for="semana" class="col-md-1 control-label" style="text-align: right">--}%
            %{--Semana--}%
        %{--</label>--}%
        %{--<g:select name="semana" from="${medico.Semana.list([sort: "numero" ])}"--}%
                  %{--class="form-control input-sm " optionValue="${{it?.fechaInicio?.format("dd-MM-yyyy")  + " - " +  it?.fechaFin?.format("dd-MM-yyyy") }}" optionKey="id"--}%
        %{--/>--}%
    %{--</div>--}%

    <div class="col-md-3">
        <label for="doctor" class="col-md-1 control-label" style="text-align: right">
            Doctor
        </label>
        <g:select name="doctor" from="${seguridad.Persona.findAllByEmpresa(consultorio).sort{it.apellido}}"
                  class="form-control input-sm " optionValue="${{it.apellido + " " + it.nombre}}" optionKey="id" data-nombre="${{it.apellido + " " + it.nombre}}"
        />
    </div>

    <div class="col-md-2">
        <div class="btn-group" role="navigation" style="margin-top: 20px">
            <a href="#" class="btn btn-success btnNuevoPaciente">
                <i class="fa fa-user"></i>
                Nuevo Paciente
            </a>
        </div>
    </div>

</div>

<div id="divTabla">

</div>



<script type="text/javascript">
    var id = null;

    $('#fecha').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    }).on('dp.change', function(e){
        var fecha = $('#fecha').val();
        var doctor = $("#doctor option:selected").val();
        console.log('cambia', fecha);
        cargaTabla(1, doctor);
    });


    %{--$('#ini').datetimepicker({--}%
        %{--locale: 'es',--}%
        %{--format: 'DD-MM-YYYY',--}%
        %{--sideBySide: true,--}%
        %{--minDate: new Date(${min}),--}%
        %{--maxDate: new Date(${max}),--}%
        %{--icons: {--}%
        %{--}--}%
    %{--}).on('dp.change', function(e){--}%
        %{--updateDias();--}%
    %{--});--}%


    cargarNombre($("#doctor option:selected").val());

    function cargarNombre(id) {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'agenda', action:'nombre_ajax')}",
            data: {
                id: id
            },
            success: function (msg) {
                $("#divNombreMedico").html(msg)
            } //success
        });
    }

    $(".btnNuevoPaciente").click(function () {
        %{--location.href="${createLink(controller: 'paciente', action: 'datos')}?tipo=" + 1--}%
        crearPaciente();
    });

    function crearPaciente() {
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'paciente', action:'datos_ajax')}",
            data    : {
                id: null
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreatePaciente",
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

    cargaTabla($("#semana option:selected").val(), $("#doctor option:selected").val());

    function borrarAgendado(itemId) {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea eliminar la cita seleccionada? Esta acción no se puede deshacer.</p>",
            closeButton: false,
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-trash'></i> Eliminar",
                    className: "btn-danger",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(controller: 'agenda', action:'borrarCita_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] === 'ok') {
                                    log(parts[1], "success");
                                    cargaTabla($("#semana option:selected").val(), $("#doctor option:selected").val());
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

    function agendar(dia, hora, id) {
        var semana = $("#semana option:selected").val();
        var doctor = $("#doctor option:selected").val();
        var fecha = $('#fecha').val();
        console.log('fecha', fecha)

        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'agenda', action:'paciente_ajax')}",
            data: {
                fecha: fecha,
                semana: semana,
                doctor: doctor,
                dia: dia,
                hora: hora,
                id: id
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    title: "Agendar cita",
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        crear: {
                            label: "<i class='fa fa-check'></i> Agendar",
                            className: "btn-success",
                            callback: function () {
                                return submitFormAgendar();
                            }
                        }
                    }
                }); //dialog
            } //success
        });
    }

    function submitFormAgendar() {
        var $form = $("#frmAgenda");
        $.ajax({
            type: "POST",
            url: $form.attr("action"),
            data: $form.serialize(),
            success: function (msg) {
                var parts = msg.split("_");
                if (parts[0] === 'ok') {
                    log(parts[1], "success");
                    cargaTabla($("#semana option:selected").val(), $("#doctor option:selected").val());
                } else {
                    log(parts[1], "error")
                }
            }
        });
    }

    function cargaTabla(semana, doctor) {
        var fecha = $('#fecha').val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'agenda', action:'tabla_ajax')}",
            data: {
                fecha: fecha,
                semana: semana,
                doctor: doctor
            },
            success: function (msg) {
                $("#divTabla").html(msg);
            } //success
        });
        //location.reload()//ajax
    }// /createEdit

    $("#semana").change(function () {
        var semana = $(this).val();
        var doctor = $("#doctor option:selected").val();
        cargaTabla(semana, doctor);
    });

    $("#doctor").change(function () {
        var doctor = $(this).val();
        var semana = $("#semana option:selected").val();
        cargaTabla(semana, doctor);
        cargarNombre(doctor);
    });


</script>

</body>
</html>

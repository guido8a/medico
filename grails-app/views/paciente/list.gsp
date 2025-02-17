<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Lista de Pacientes
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

<body class="scr">

<div >
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid" style="margin-left: 10px">
            %{--<span class="grupo">--}%
                %{--<span class="col-md-2">--}%
                %{--<label class="control-label text-info">Consultorio</label>--}%
                %{--<g:select name="empresa" class="empresa col-md-12 form-control" from="${seguridad.Empresa.list().sort{it.nombre}}" noSelection="[0: 'Todos']" value="${empresa ? empresa?.id : 0}" optionKey="id"--}%
                %{--optionValue="nombre"/>--}%
                %{--</span>--}%
                <div class="row">
                <div class="col-md-3">
                    <a href="#" class="btn btn-success btnNuevoPaciente">
                        <i class="fa fa-user"></i>
                        Nuevo Paciente
                    </a>

                </div>
                    %{--<div class="col-md-1">--}%
                        %{--<label class="control-label text-info">Buscar Por</label>--}%
                    %{--</div>--}%

                    %{--<div class="col-md-2">--}%
                        %{--<g:select name="buscarPor" class="buscarPor col-md-12 form-control"--}%
                                  %{--from="${[3: 'Nombre', 2: 'Apellido', 1: 'Cédula']}" optionKey="key"--}%
                                  %{--optionValue="value"/>--}%
                    %{--</div>--}%

                    <div class="col-md-1">
                        <label class="control-label text-info" style="margin-top: 10px">Buscar por:</label>
                    </div>

                    <div class="col-md-2" style="margin-left: 0px; max-width: 220px">
                        <g:textField name="criterio" id="criterio" class="form-control"/>
                    </div>

                    <div class="col-sm-2">
                        <button class="btn btn-info" id="btnBuscarEmpresa"><i class="fa fa-search"></i> Buscar pacientes
                        </button>
                    </div>

                    <div class="col-sm-1" >
                        <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i
                                class="fa fa-eraser"></i>
                        </button>
                    </div>

                    <div class="col-sm-3">
                        <label class="control-label text-info" style="margin-top: 10px">Pacientes en el sistema: ${pacientes}</label>
                    </div>
                </div>

            %{--</span>--}%

        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaPacientes">
        </div>
    </fieldset>
</div>


<script type="text/javascript">
    var di;
    var dcp;

    $(".btnNuevoPaciente").click(function () {
        crearPaciente();
    });

    $("#btnLimpiar").click(function () {
        $("#buscarPor").val(1);
        $("#criterio").val('');
        $("#empresa").val(0);
       cargarTablaPacientes();
    });

    $("#btnBuscarEmpresa").click(function () {
        cargarTablaPacientes();
    });

    $("#criterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaPacientes();
            return false;
        }
        return true;
    });

    cargarTablaPacientes();

    function cargarTablaPacientes() {
        var d = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPor option:selected").val();
        var criterio = $("#criterio").val();
        var empresa = $("#empresa").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'tablaPacientes_ajax')}',
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                empresa: empresa
            },
            success: function (msg) {
                d.modal("hide");
                $("#divTablaPacientes").html(msg)
            }
        })
    }

    %{--function createEditRow(id) {--}%
    %{--    var title = id ? "Editar " : "Crear ";--}%
    %{--    var data = id ? {id : id}: {};--}%

    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url: "${createLink(action:'form_ajax')}",--}%
    %{--        data    : data,--}%
    %{--        success : function (msg) {--}%
    %{--            var b = bootbox.dialog({--}%
    %{--                id      : "dlgCreateEditPaciente",--}%
    %{--                title   : title + " Paciente",--}%
    %{--                class: "modal-lg",--}%
    %{--                message : msg,--}%
    %{--                buttons : {--}%
    %{--                    cancelar : {--}%
    %{--                        label     : "Cancelar",--}%
    %{--                        className : "btn-primary",--}%
    %{--                        callback  : function () {--}%
    %{--                        }--}%
    %{--                    },--}%
    %{--                    guardar  : {--}%
    %{--                        id        : "btnSave",--}%
    %{--                        label     : "<i class='fa fa-save'></i> Guardar",--}%
    %{--                        className : "btn-success",--}%
    %{--                        callback  : function () {--}%
    %{--                            return submitFormPaciente();--}%
    %{--                        } //callback--}%
    %{--                    } //guardar--}%
    %{--                } //buttons--}%
    %{--            }); //dialog--}%
    %{--        } //success--}%
    %{--    }); //ajax--}%
    %{--} //createEdit--}%

    // function submitFormPaciente() {
    //     var $form = $("#frmPaciente");
    //     if ($form.valid()) {
    //         var data = $form.serialize();
    //         var dialog = cargarLoader("Guardando...");
    //         $.ajax({
    //             type    : "POST",
    //             url     : $form.attr("action"),
    //             data    : data,
    //             success : function (msg) {
    //                 dialog.modal('hide');
    //                 var parts = msg.split("_");
    //                 if(parts[0] === 'ok'){
    //                     log(parts[1], "success");
    //                     cargarTablaPacientes();
    //                 }else{
    //                     if(parts[0] === 'err'){
    //                         bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
    //                         return false;
    //                     }else{
    //                         bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
    //                         return false;
    //                     }
    //
    //                 }
    //             }
    //         });
    //     } else {
    //         return false;
    //     }
    // }

    function deleteRow(itemId) {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold'> Está seguro que desea eliminar este paciente? Esta acción no se puede deshacer.</p>",
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
                        var v = cargarLoader("Eliminando...");
                        $.ajax({
                            type: "POST",
                            url: '${createLink(action:'borrarPaciente_ajax')}',
                            data: {
                                id: itemId
                            },
                            success: function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if (parts[0] === 'ok') {
                                    log(parts[1], "success");
                                    cargarTablaPacientes();
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

    function crearPaciente() {
        $.ajax({
            type: "POST",
            url: "${createLink(action:'datos_ajax')}",
            data: {
                id: null
            },
            success: function (msg) {
                dcp = bootbox.dialog({
                    id: "dlgCreatePaciente",
                    title: "Datos del paciente",
                    class: "modal-lg",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        guardar: {
                            id: "btnSave",
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
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
                type: "POST",
                url: $form.attr("action"),
                data: data,
                success: function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if (parts[0] === 'ok') {
                        log(parts[1], "success");
                        cerrarDialogoCrearPaciente();
                        cargarTablaPacientes();
                    } else {
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
                }
            });
            return false;
        } else {
            return false;
        }
    }

    function cerrarDialogoCrearPaciente(){
        dcp.modal("hide");
    }



</script>

</body>
</html>

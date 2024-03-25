
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Citas
    </title>
</head>
<body>

<div class="row" style="margin-bottom: 10px">
    <div class="btn-group col-md-6" >
        <a href="${createLink(controller: 'paciente', action: 'list')}" class="btn btn-info" title="Retornar a búsqueda de pacientes">
            <i class="fas fa-arrow-left"></i> Lista de pacientes
        </a>
        <a href="#" class="btn btn-success " id="btnNuevaCita" title="Nueva Cita médica">
            <i class="fa fa-file"></i>
            Nueva Cita
        </a>
    </div>
    <div class="btn-group col-md-6" style="margin-top: -20px">
        <h4>Citas del paciente ${paciente?.nombre + " " + paciente?.apellido}    </h4>
    </div>
</div>


<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-2">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPor" class="buscarPor col-md-12 form-control" from="${[1: 'Fecha', 2: 'Motivo', 3: 'Diagnóstico']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-4">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="criterio" id="criterio" class="form-control"/>
                </span>
            </span>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarCita"><i class="fa fa-search"></i> Buscar</button>
            </div>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i> Limpiar</button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaCitas" >
        </div>
    </fieldset>
</div>


<script type="text/javascript">
    var di;

    $("#btnNuevaCita").click(function () {
        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + '${paciente?.id}'
    });

    $(".btnNuevoPaciente").click(function () {
        location.href="${createLink(controller: 'paciente', action: 'datos')}"
    });

    $("#btnLimpiar").click(function  () {
        $("#buscarPor").val(1);
        $("#criterio").val('');
        cargarTablaCitas();
    });

    $("#btnBuscarCita").click(function () {
        cargarTablaCitas();
    });

    $("#criterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaCitas();
            return false;
        }
        return true;
    });

    cargarTablaCitas();

    function cargarTablaCitas() {
        var d = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPor option:selected").val();
        var criterio = $("#criterio").val();
        var paciente = '${paciente?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'tablaCitas')}',
            data:{
                buscarPor: buscarPor,
                criterio: criterio,
                pcnt: paciente
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaCitas").html(msg)
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

    %{--function deleteRow(itemId) {--}%
    %{--    bootbox.dialog({--}%
    %{--        title   : "Alerta",--}%
    %{--        message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold'> Está seguro que desea eliminar este paciente? Esta acción no se puede deshacer.</p>",--}%
    %{--        buttons : {--}%
    %{--            cancelar : {--}%
    %{--                label     : "Cancelar",--}%
    %{--                className : "btn-primary",--}%
    %{--                callback  : function () {--}%
    %{--                }--}%
    %{--            },--}%
    %{--            eliminar : {--}%
    %{--                label     : "<i class='fa fa-trash'></i> Eliminar",--}%
    %{--                className : "btn-danger",--}%
    %{--                callback  : function () {--}%
    %{--                    var v = cargarLoader("Eliminando...");--}%
    %{--                    $.ajax({--}%
    %{--                        type    : "POST",--}%
    %{--                        url     : '${createLink(action:'borrarPaciente_ajax')}',--}%
    %{--                        data    : {--}%
    %{--                            id : itemId--}%
    %{--                        },--}%
    %{--                        success : function (msg) {--}%
    %{--                            v.modal("hide");--}%
    %{--                            var parts = msg.split("_");--}%
    %{--                            if(parts[0] === 'ok'){--}%
    %{--                                log(parts[1],"success");--}%
    %{--                                cargarTablaPacientes();--}%
    %{--                            }else{--}%
    %{--                                log(parts[1],"error")--}%
    %{--                            }--}%
    %{--                        }--}%
    %{--                    });--}%
    %{--                }--}%
    %{--            }--}%
    %{--        }--}%
    %{--    });--}%
    %{--}--}%



</script>

</body>
</html>

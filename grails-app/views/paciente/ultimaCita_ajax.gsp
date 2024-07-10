

<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <div style="width: 3%; float: left; margin-right: 5px">
        <a href="#" class="btn btn-info col-md-12" role="alert" id="btnEditaCita" title="Editar los datos de la cita médica">
            <i class="fas fa-edit"></i>
        </a>
    </div>
    <div style="width:96%; float: left">
        <table class="table-bordered table-condensed " style="width: 100%">
            <tbody>
            <tr style="font-size: 16px">
                <td style="width: 20%" class="alert alert-success">Motivo de consulta:</td>
                <td style="width: 80%; background-color: #b7d6a9">${cita?.motivo}</td>
            </tr>
            <tr style="font-size: 16px">
                <td style="width: 20%" class="alert alert-success">Enfermedad actual:</td>
                <td style="width: 80%; background-color:#b7d6a9">${cita?.actual}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<h4>Examen Físico</h4>

<div id="divExamenFisico">

</div>

<h4>Diagnóstico</h4>
<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <div style="width: 3%; float: left; margin-right: 5px">
        <a href="#" class="btn btn-info col-md-12" role="alert" id="btnBuscarDiagnostico" title="Editar los datos del diagnóstico">
            <i class="fas fa-edit"></i>
        </a>
    </div>
    <div style="width:96%; float: left">

        <table class="table-bordered table-condensed " style="width: 100%">
            <tbody>
            <tr style="font-size: 16px">
                <td style="width: 20%;font-weight: bolder" class="alert alert-success">Diagnóstico:</td>
                <td style="width: 80%; background-color:#b7d6a9">
                    <g:if test="${diagnosticos.size() > 0}">
                        <table class="table table-bordered table-striped table-condensed table-hover">
                            <thead>
                            <tr style="width: 100%">
                                <th style="width: 10%">Código</th>
                                <th style="width: 50%">Descripción </th>
                                <th style="width: 30%">Observaciones </th>
                                <th style="width: 10%">Acciones </th>
                            </tr>
                            </thead>
                            <tbody >
                            <g:each in="${diagnosticos}" status="i" var="diagnostico">
                                <tr style="width: 100%">
                                    <td style="width: 10%">${diagnostico?.diagnostico?.codigo}</td>
                                    <td style="width: 50%">${diagnostico?.diagnostico?.descripcion}</td>
                                    <td style="width: 30%">${diagnostico?.descripcion}</td>
                                    <td style="width: 10%; text-align: center">
                                        <a class="btn btn-info btn-xs btnObservacionesDiagnostico" href="#" rel="tooltip" title="Observaciones" data-id="${diagnostico.id}">
                                            <i class="fa fa-book"></i>
                                        </a>
                                        <a class="btn btn-danger btn-xs btnBorrarDiagnostico" href="#" rel="tooltip" title="Eliminar" data-id="${diagnostico.id}">
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </g:if>
                    <g:else>
                        <div class="alert alert-success" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin diagnósticos</div>
                    </g:else>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<h4>Tratamiento</h4>

<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <div style="width: 3%; float: left; margin-right: 5px">
        <a href="#" class="btn btn-info col-md-12" role="alert" id="btnTratamiento" title="Editar los datos del tratamiento">
            <i class="fas fa-edit"></i>
        </a>
    </div>
    <div style="width:96%; float: left">
        <table class="table-bordered table-condensed " style="width: 100%">
            <tbody>

            <tr style="font-size: 16px">
                <td style="width: 20%;font-weight: bolder" class="alert alert-success">Tratamiento:</td>
                <td style="width: 80%; background-color:#b7d6a9">
                    <g:if test="${tratamientos.size() > 0}">
                        <table class="table table-bordered table-striped table-condensed table-hover">
                            <thead>
                            <tr style="width: 100%">
                                <th style="width: 10%">Medicina </th>
                                <th style="width: 10%">Concentración </th>
                                <th style="width: 10%">Cantidad </th>
                                <th style="width: 35%">Prescripción</th>
                            </tr>
                            </thead>
                            <tbody >
                            <g:each in="${tratamientos}" status="i" var="tratamiento">
                                <tr style="width: 100%">
                                    <td style="width: 25%">${tratamiento?.medicina ? tratamiento?.medicina?.descripcion : ''}</td>
                                    <td style="width: 10%">${tratamiento?.medicina?.concentracion}</td>
                                    <td style="width: 8%">${tratamiento?.cantidad}</td>
                                    <td style="width: 47%">${tratamiento?.descripcion}</td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </g:if>
                    <g:else>
                        <div class="alert alert-success" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin tratamiento</div>
                    </g:else>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<h4>Exámenes Complementarios</h4>

<div id="divExamenLaboratorio">

</div>

<script type="text/javascript">

    var dp;

    $("#btnEditaCita").click(function () {
        var cita = $("#citaSeleccionada option:selected").val();
        if(cita != null){
            editaDatosCita(cita);
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Seleccione una cita" + '</strong>');
        }
    });

    $("#btnUltimoExamenFisico").click(function () {
        var cita = $("#citaSeleccionada option:selected").val();
        if(cita != null){
            createEditRowExamenFisico();
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Seleccione una cita" + '</strong>');
        }
    });

    function createEditRowExamenFisico(id) {
        var title = id ? "Editar " : "Crear ";
        var data = {
            id: id,
            historial: '${cita?.id}'
        };
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'examenFisico',  action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                cf = bootbox.dialog({
                    id      : "dlgCreateEditExamenFisico",
                    title   : " Examen Físico",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormExamenFisico();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormExamenFisico() {
        var $form = $("#frmExamenFisico");
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
                        cargarExamenFisico('${cita?.id}');
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

    $("#btnUltimaCita").click(function () {
        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + '${paciente?.id}' + "&id=" + '${cita?.id}' + "&tipo=" + 1
    });

    cargarExamenFisico('${cita?.id}');

    function cargarExamenFisico(cita) {
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'examenFisico_ajax')}',
            data:{
                id: cita,
                paciente: '${paciente?.id}'
            },
            success: function (msg){
                d.modal("hide");
                $("#divExamenFisico").html(msg)
            }
        })
    }

    cargarExamenLaboratorio('${cita?.id}');

    function cargarExamenLaboratorio(cita) {
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'examenLaboratorio_ajax')}',
            data:{
                id: cita
            },
            success: function (msg){
                d.modal("hide");
                $("#divExamenLaboratorio").html(msg)
            }
        })
    }

    function cargarExamenes() {
        var cita = "${cita?.id}";
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'historial', action:'examenes_ajax')}",
            data    : {
                cita: cita
            },
            success : function (msg) {
                bcpc = bootbox.dialog({
                    id      : "dlgExamenes",
                    title   : "Exámenes de la cita",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }

    $("#btnTratamiento").click(function () {
        var cita = "${cita?.id}";
        if(cita){
            $.ajax({
                type    : "POST",
                url: "${createLink(controller: 'tratamiento', action:'tratamiento_ajax')}",
                data    : {
                    cita: cita
                },
                success : function (msg) {
                    bcpc = bootbox.dialog({
                        id      : "dlgTratamiento",
                        title   : "Tratamiento de la cita",
                        class: "modal-lg",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                    return submitTextoTratamiento();
                                }
                            }
                        } //buttons
                    }); //dialog
                } //success
            }); //ajax
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Seleccione una cita" + '</strong>');
        }
    });

    function submitTextoTratamiento() {
        var dialog = cargarLoader("Guardando...");
        var tratamiento = $("#tratamiento").val();
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'tratamiento',  action:'saveTextoTratamiento_ajax')}",
            data    : {
                tratamiento: tratamiento,
                id: '${cita?.id}'
            },
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
    }

    $("#btnBuscarDiagnostico").click(function () {
        var cita = '${cita?.id}';
        if(cita){
            $.ajax({
                type    : "POST",
                url: "${createLink(controller: 'historial', action:  'buscarDiagnostico_ajax')}",
                data    : {
                    cita: cita
                },
                success : function (msg) {
                    dp = bootbox.dialog({
                        id      : "dlgBuscarDiagnostico",
                        title   : "Buscar diagnóstico",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            }
                        } //buttons
                    }); //dialog
                } //success
            }); //ajax
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Seleccione una cita" + '</strong>');
        }
    });

    function cerrarBusqueda(){
        dp.modal("hide");
    }

    $(".btnBorrarDiagnostico").click(function () {
        var id = $(this).data("id");
        deleteRowDiagnostico(id)
    });

    $(".btnObservacionesDiagnostico").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'historial', action:'observacionesDiagnostico_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var aa = bootbox.dialog({
                    id      : "dlgObservacionesDiagnostico",
                    title   : "Observaciones",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar : {
                            label     : "Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return guardarObservaciones(id);
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    function guardarObservaciones (id) {
        var observaciones = $("#observacionesDiagnostico").val();
        $.ajax({
            type    : "POST",
            url     : '${createLink(controller: 'historial', action:'saveObservaciones_ajax')}',
            data    : {
                id: id,
                observaciones: observaciones
            },
            success : function (msg) {
                var parts = msg.split("_");
                if(parts[0] === 'ok'){
                    log(parts[1], "success");
                    // cargarTablaDiagnostico();
                    cargarUltimaCita('${cita?.id}');
                }else{
                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                    return false;
                }
            }
        });
    }

    function deleteRowDiagnostico(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<span style='text-align: center; font-size: 14px; font-weight: bold'><i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Está seguro que desea eliminar este diagnóstico?.</span>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        var v = cargarLoader("Eliminando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'historial', action: 'borrarDiagnostico_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    // cargarTablaDiagnostico();
                                    cargarUltimaCita('${cita?.id}');
                                }else{
                                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        });
    }

</script>
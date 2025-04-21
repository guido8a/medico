
<g:if test="${cita?.id}">
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

    <div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
        <div style="width: 3%; float: left; margin-right: 5px">
            <a href="#" class="btn btn-info col-md-12" id="btnEditarInterconsulta" title="Editar los datos de la interconsulta">
                <i class="fas fa-edit"></i>
            </a>
        </div>
        <div style="width:96%; float: left">
            <table class="table-bordered table-condensed " style="width: 100%">
                <tbody>

                <g:if test="${cita?.motivoExterno}">
                    <tr style="font-size: 16px">
                        <td style="width: 20%" class="alert alert-info">Médico de interconsulta:</td>
                        <td style="width: 80%" class="alert alert-info">${(cita?.medicoExterno?.apellido ?: '') + " " + (cita?.medicoExterno?.nombre ?: '')}</td>
                    </tr>
                    <tr style="font-size: 16px">
                        <td style="width: 20%" class="alert alert-info">Motivo de consulta:</td>
                        <td style="width: 80%" class="alert alert-info">${cita?.motivoExterno}</td>
                    </tr>
                    <tr style="font-size: 16px">
                        <td style="width: 20%" class="alert alert-info">Informe:</td>
                        <td style="width: 80%" class="alert alert-info">${cita?.informeExterno}</td>
                    </tr>
                </g:if>
                <g:else>
                    <tr style="font-size: 16px">
                        <td style="width: 20%" class="alert alert-info">Interconsulta:</td>
                        <td style="width: 80%" class="alert alert-info">${"NINGUNA"}</td>
                    </tr>
                </g:else>
                </tbody>
            </table>
        </div>
    </div>

    <g:if test="${cita?.motivo != 'Cita médica agendada'}">

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

        <g:if test="${diagnosticos.size() > 0}">

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
                            <td style="width: 80%; background-color:#b7d6a9">
                                <g:if test="${tratamientos.size() > 0}">
                                    <table class="table table-bordered table-striped table-condensed table-hover">
                                        <thead>
                                        <tr style="width: 100%">
                                            <th style="width: 5%">Orden</th>
                                            <th style="width: 15%">Nombre Comercial </th>
                                            <th style="width: 12%">Nombre Genérico </th>
                                            <th style="width: 10%">Concentración </th>
                                            <th style="width: 8%">Cantidad </th>
                                            <th style="width: 50%">Prescripción</th>
                                        </tr>
                                        </thead>
                                        <tbody >
                                        <g:each in="${tratamientos}" status="i" var="tratamiento">
                                            <tr style="width: 100%">
                                                <td style="width: 5%">${tratamiento?.orden}</td>
                                                <td style="width: 15%">${tratamiento?.medicina ? tratamiento?.medicina?.descripcion : ''}</td>
                                                <td style="width: 12%">${tratamiento?.medicina ? tratamiento?.medicina?.padre?.descripcion : ''}</td>
                                                <td style="width: 10%">${tratamiento?.medicina?.concentracion}</td>
                                                <td style="width: 8%">${tratamiento?.cantidad}</td>
                                                <td style="width: 50%">${tratamiento?.descripcion}</td>
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

            <h4>Exámenes Imágenes</h4>

            <div id="divExamenImagenes">

            </div>

            <div id="comentario">

            </div>

        </g:if>
    </g:if>
</g:if>
<g:else>
    <div class="alert alert-warning" style="font-weight: bold; font-size: 12px; text-align: center">
        <i class="fa fa-exclamation-triangle text-danger fa-2x"></i> <strong style="font-size: 14px; font-weight: bold"> No existe una cita seleccionada </strong>
    </div>
</g:else>

<script type="text/javascript">

    var dp;

    $("#btnEditarInterconsulta").click(function () {
        var cita = $("#citaSeleccionada option:selected").val();
        if(cita != null){
            editaInterconsulta();
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' +
                '<strong style="font-size: 14px">' + "No ha seleccionado una cita" + '</strong>');
        }
    });

    $("#btnEditaCita").click(function () {
        var cita = $("#citaSeleccionada option:selected").val();
        if(cita != null){
            editaDatosCita(cita);
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' +
                '<strong style="font-size: 14px">' + "No ha seleccionado una cita" + '</strong>');
        }
    });

    $("#btnUltimoExamenFisico").click(function () {
        var cita = $("#citaSeleccionada option:selected").val();
        if(cita != null){
            createEditRowExamenFisico();
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' +
                '<strong style="font-size: 14px">' + "No ha seleccionado una cita" + '</strong>');
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

    function cargarExamenImagen(cita) {
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'examenImagen_ajax')}',
            data:{
                id: cita
            },
            success: function (msg){
                d.modal("hide");
                $("#divExamenImagenes").html(msg)
            }
        })
    }

    cargarExamenImagen('${cita?.id}');

    function cargarExamenes(tipo) {
        var cita = "${cita?.id}";
        var texto = tipo === 1 ? "Exámenes de Imagen de la cita" : 'Exámenes de la cita';
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'historial', action:'examenes_ajax')}",
            data    : {
                cita: cita,
                tipo: tipo
            },
            success : function (msg) {
                bcpc = bootbox.dialog({
                    id      : "dlgExamenes",
                    title   : texto,
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
                                    // return submitTextoTratamiento();
                                }
                            },
                            guardar  : {
                                id        : "btnSave",
                                label     : "<i class='fa fa-save'></i> Guardar",
                                className : "btn-success",
                                callback  : function () {
                                    return submitTextoTratamiento();
                                } //callback
                            } //guardar,
                        } //buttons
                    }); //dialog
                } //success
            }); //ajax
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' +
                '<strong style="font-size: 14px">' + "No ha seleccionado una cita" + '</strong>');
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
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' +
                '<strong style="font-size: 14px">' + "No ha seleccionado una cita" + '</strong>');
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
                                    %{--cargarUltimaCita('${cita?.id}');--}%
                                    cargarComboCita('${cita?.id}');
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

    cargarComentario('${cita?.id}');

    function cargarComentario(cita){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'historial', action: 'comentario_ajax')}',
            data:{
                id: cita
            },
            success: function (msg){
                $("#comentario").html(msg)
            }
        })
    }

    function editaInterconsulta() {
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'historial', action:'interconsulta_ajax')}",
            data    : {
                id: '${cita?.id}'
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditInterconsulta",
                    title   : "Interconsulta",
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
                                return submitFormInterconsulta();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }

    function submitFormInterconsulta() {
        var $form = $("#frmInterconsulta");
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
                        cargarUltimaCita('${cita?.id}');
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

</script>
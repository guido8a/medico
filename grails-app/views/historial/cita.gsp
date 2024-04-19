<%@ page import="medico.Diagnostico; seguridad.Persona" contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="main">
    <title>

        <g:if test="${paciente?.id}">
            Cita del Paciente:  ${(paciente?.apellido ?: '') + " " + (paciente?.nombre ?: '')}
        </g:if>
        <g:else>
            Nueva cita
        </g:else>

    </title>

    <style type="text/css">
    .mediano {
        margin-top: 5px;
        padding-top: 9px;
        height: 30px;
        font-size: inherit;
        text-align: right;
    }

    .izquierda{
        margin-left: 4px;
    }

    .arriba{
        display: block;
        top: 10px;
        left: 0px;
    }

    </style>

</head>

<body>

<h4>
    <g:if test="${historial?.id}">
        Paciente: <strong style="font-style: italic"> ${(paciente?.apellido ?: '') + " " + (paciente?.nombre ?: '') + " - fecha: " + historial?.fecha?.format('dd-MM-yyyy')}</strong>
    </g:if>
    <g:else>
        Nueva cita
    </g:else>
</h4>

<div class="panel panel-primary col-md-12" style="height: 700px">

    <div class="panel-heading" style="padding: 3px; margin-top: 2px; margin-bottom: 5px; text-align: center; height: 40px">
        <g:if test="${tipo == '2'}">
            <a href="${createLink(controller: 'paciente', action: 'citas')}/${paciente?.id}"  class="btn btn-sm btn-info" style="float: left" title="Retornar a lista de citas del paciente">
                <i class="fas fa-arrow-left"></i> Lista de citas
            </a>
        </g:if>
        <g:else>
            <a href="${createLink(controller: 'paciente', action: 'historial')}/${paciente?.id}?cita=${historial?.id}"  class="btn btn-sm btn-info" style="float: left" title="Retornar a historial del paciente">
                <i class="fas fa-arrow-left"></i> Historial
            </a>
        </g:else>

        <a href="#" id="btnGuardar" class="btn btn-sm btn-success" style="float: left; margin-left: 20px" title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
        <g:if test="${historial?.id}">
            <a href="#" id="btnCargarExamenes" class="btn btn-sm btn-info" title="Documentos del paciente">
                <i class="fa fa-flask"></i> Exámenes de laboratorio
            </a>
            <a href="#" id="btnExFisico" class="btn btn-sm btn-info" title="Exámenes físicos del paciente">
                <i class="fa fa-stethoscope"></i> Examen Físico
            </a>
            <a href="#" id="btnTratamiento" class="btn btn-sm btn-info" title="Tratamiento del paciente">
                <i class="fa fa-medkit"></i> Tratamiento
            </a>
        </g:if>

    </div>

    <div class="tab-content" style="margin-top: 10px">
        <div id="home" class="tab-pane fade in active">
            <g:form class="form-horizontal" name="frmCita" controller="historial" action="saveCita_ajax">
                <g:hiddenField name="paciente" value="${paciente?.id}"/>
                <g:hiddenField name="id" value="${historial?.id}"/>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Paciente</span>
                        <span class="col-md-4">
                            <g:textField name="nombrePaciente" class="form-control" readonly="" value=" ${paciente?.apellido + ' ' + paciente?.nombre + " - " + paciente?.cedula}"/>
                        </span>
                        <span class="col-md-1 label label-primary text-info mediano" >Fecha de la cita</span>
                        <span class="grupo" >
                            <span class="col-md-2 " >
                                <input aria-label="" name="fecha" id='fecha' required type='text' class="form-control required"
                                       value="${historial?.fecha ? historial?.fecha?.format("dd-MM-yyyy") : new Date().format("dd-MM-yyyy")}" />
                            </span>
                        </span>
                        <span class="col-md-1 label label-primary text-info mediano" >Hora</span>
                        <span class="grupo" >
                            <span class="col-md-1 " >
                                <g:textField name="hora" class="form-control" value=" ${historial?.hora}"/>
                            </span>
                            <span class="col-md-1"> Ej: 08:30</span>
                        </span>


                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Especialista</span>
                        <span class="col-md-4">
                            <g:select name="persona" from="${seguridad.Persona.list().sort{it.nombre}}" optionKey="id" optionValue="nombre" class="form-control " value="${historial?.persona?.id}" />
                        </span>

                        <span class="col-md-1 label label-primary text-info mediano" >Próxima cita</span>
                        <span class="grupo" >
                            <span class="col-md-2 " >
                                <input aria-label="" name="proximaCita" id='proximaCita' type='text' class="form-control" value="${historial?.proximaCita?.format("dd-MM-yyyy")}" />
                            </span>
                        </span>
                        <div class="col-md-2">
                        <a href="#" class="btn btn-warning" id="btnNuevaCita" title="Agendar próxima cita" style="margin-left: 0px">
                            <i class="fas fa-plus"></i> Agendar próxima Cita
                        </a>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Motivo de consulta</span>
                        <span class="col-md-10">
                            <g:textArea name="motivo" maxlength="255" required="" style="resize: none; height: 60px;" class="form-control required"  value="${historial?.motivo}"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Enfermedad actual</span>
                        <span class="col-md-10">
                            <g:textArea name="actual" maxlength="255" class="form-control" style="resize: none; height: 60px;"  value="${historial?.actual}"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Tratamiento</span>
                        <span class="col-md-10">
                            <g:textArea name="tratamiento" maxlength="255" class="form-control" style="resize: none; height: 60px;"  value="${historial?.tratamiento}"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Exámenes</span>
                        <span class="col-md-10">
                            <g:textArea name="examenes" maxlength="255" class="form-control" style="resize: none; height: 60px;"  value="${historial?.examenes}"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Diagnóstico</span>
                        <span class="col-md-9">
                            <table class="table table-bordered table-striped table-condensed table-hover">
                                <thead>
                                <tr style="width: 100%">
                                    <th style="width: 10%">Código</th>
                                    <th style="width: 50%">Descripción </th>
                                    <th style="width: 30%">Observaciones </th>
                                    <th style="width:10%">Acciones</th>
                                </tr>
                                </thead>
                            </table>
                            <span id="divDiagnosticos">

                            </span>
                        </span>
                        <span class="col-md-1">
                            <a href="#" id="btnBuscarDiagnostico" class="btn btn-sm btn-info" style="margin-left: -8px" title="Buscar diagnóstico">
                                <i class="fa fa-search"></i> Buscar
                            </a>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Observaciones</span>
                        <span class="col-md-10">
                            <g:textArea name="observaciones" maxlength="255" class="form-control" style="resize: none; height: 60px;"  value="${historial?.observaciones}"/>
                        </span>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>

<script type="text/javascript">

    var di;
    var dp;

    $('#fecha, #proximaCita').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });

    cargarTablaDiagnostico();

    function cargarTablaDiagnostico(){
        var e = cargarLoader("Cargando...");
        var cita = '${historial?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'historial', action: 'tablaDiagnostico_ajax')}',
            data:{
                cita: cita
            },
            success: function (msg){
                e.modal("hide");
                $("#divDiagnosticos").html(msg)
            }
        })
    }

    %{--$("#btnDiagnostico").click(function () {--}%
    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url: "${createLink(action:'diagnostico_ajax')}",--}%
    %{--        data    : {--}%
    %{--            id: '${paciente?.id}'--}%
    %{--        },--}%
    %{--        success : function (msg) {--}%
    %{--            var b = bootbox.dialog({--}%
    %{--                id      : "dlgCreateEditDiagnostico",--}%
    %{--                title   : "Diagnóstico del paciente",--}%
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
    %{--                            return submitFormDiagnostico();--}%
    %{--                        } //callback--}%
    %{--                    } //guardar--}%
    %{--                } //buttons--}%
    %{--            }); //dialog--}%
    %{--        } //success--}%
    %{--    }); //ajax--}%
    %{--});--}%

    %{--function submitFormDiagnostico() {--}%
    %{--    var $form = $("#frmDiagnostico");--}%
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
    %{--                }else{--}%
    %{--                    if(parts[0] === 'err'){--}%
    %{--                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');--}%
    %{--                        return false;--}%
    %{--                    }else{--}%
    %{--                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');--}%
    %{--                        return false;--}%
    %{--                    }--}%
    %{--                }--}%
    %{--            }--}%
    %{--        });--}%
    %{--    } else {--}%
    %{--        return false;--}%
    %{--    }--}%
    %{--}--}%

    $("#btnGuardar").click(function () {
        submitFormCita();
    });

    function submitFormCita() {
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
                        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + '${paciente?.id}' + "&id=" + parts[2]
                    }else{
                        if(parts[0] === 'err'){
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }else{
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }

                    }
                }
            });
        } else {
            return false;
        }
    }

    %{--$("#btnHistoria").click(function (){--}%
    %{--    location.href="${createLink(controller: 'historial', action: 'list')}?id=" + '${paciente?.id}'--}%
    %{--});--}%

    $("#btnBuscarDiagnostico").click(function () {
        var cita = '${historial?.id}';
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'buscarDiagnostico_ajax')}",
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
    });

    function cerrarBusqueda(){
        dp.modal("hide");
    }

    $("#btnCargarExamenes").click(function () {
        var cita = "${historial?.id}";
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
    });

    $("#btnTratamiento").click(function () {
        var cita = "${historial?.id}";
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
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    $("#btnExFisico").click(function () {
        createEditRowExamenFisico();
    });

    function createEditRowExamenFisico(id) {
        var title = id ? "Editar " : "Crear ";
        var data = {
            id: id,
            historial: '${historial?.id}'
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
                        // cancelar : {
                        //     label     : "Cancelar",
                        //     className : "btn-primary",
                        //     callback  : function () {
                        //     }
                        // },
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
                    }else{
                        if(parts[0] === 'err'){
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }else{
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }
                    }
                }
            });
        } else {
            return false;
        }
    }

</script>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="main">
    <title>Paciente: ${paciente?.apellido + " " + paciente?.nombre} </title>

    <style type="text/css">
    .mediano {
        margin-top: 5px;
        padding-top: 9px;
        height: 30px;
        font-size: inherit;
        text-align: right;
    }

    .sobrepuesto {
        position: absolute;
        top: 3px;
        font-size: 14px;
    }

    .negrita {
        font-weight: bold;
    }

    .izquierda{
        margin-left: 4px;
    }
    </style>

</head>

<body>

<h3>Paciente: <strong style="font-style: italic"> ${paciente?.apellido + " " + paciente?.nombre}</strong></h3>

<div class="panel panel-primary col-md-12">

    <div class="panel-heading" style="padding: 3px; margin-top: 2px; text-align: center">
        <a href="${createLink(controller: 'buscarBase', action: 'busquedaBase')}" id="btnConsultarBase"
           class="btn btn-sm btn-info" title="Consultar artículo">
            <i class="fas fa-clipboard-check"></i> Base de Conocimiento
        </a>
        <a href="${createLink(controller: 'documento', action: 'listProyecto')}" id="btnConsultar"
           class="btn btn-sm btn-info" title="Consultar documentos del proyecto">
            <i class="fas fa-book-reader"></i> Biblioteca
        </a>
        <a href="#" id="btnFinanciamiento" class="btn btn-sm btn-info" title="Nuevo financiamiento">
            <i class="fa fa-dollar-sign"></i> Financiamiento
        </a>
        <g:if test="${proy?.fechaRegistro}">
            <a href="#" id="btnEstado" class="btn btn-sm btn-warning" title="Cambiar de estado al proyecto">
                <i class="fa fa-check"></i> Desregistrar
            </a>
        </g:if>
        <g:else>
            <a href="#" id="btnEstado" class="btn btn-sm btn-info" title="Cambiar de estado al proyecto">
                <i class="fa fa-check"></i> Estado
            </a>
        </g:else>
        <a href="#" id="btnVerMarco" class="btn btn-sm btn-info" title="Ver marco lógico">
            <i class="fa fa-search"></i> Ver Marco Lógico
        </a>
        <a href="#" id="editMrlg" class="btn btn-sm btn-info" title="Editar marco lógico">
            <i class="fa fa-clipboard"></i> Editar Marco Lógico
        </a>
        <a href="#" id="btnVerCronograma" class="btn btn-sm btn-info" title="Ver cronograma">
            <i class="fa fa-calendar-alt"></i> Ver Cronograma
        </a>
        <a href="#" id="btnMeta" class="btn btn-sm btn-info"  title="Ver metas">
            <i class="fa fa-bullseye"></i> Metas
        </a>
        <a href="#" id="btnGuardar" class="btn btn-sm btn-success" title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
    </div>

    <div class="tab-content">
        <div id="home" class="tab-pane fade in active">
            <g:form class="form-horizontal" name="frmPaciente" controller="paciente" action="savePaciente_ajax">
                <g:hiddenField name="id" value="${paciente?.id}"/>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Empresa</span>

                        <span class="col-md-4">
                            <g:select name="empresa" from="${seguridad.Empresa.list().sort{it.nombre}}" optionKey="id" optionValue="nombre" class="form-control " value="${paciente?.empresa?.id}" noSelection="[null : 'Ninguna']"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Cédula</span>

                        <span class="col-md-3">
                            <g:textField name="cedula" maxlength="10" minlength="10" required="" class="form-control required allCaps"  value="${paciente?.cedula}"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Apellido</span>
                        <span class="grupo">
                            <span class="col-md-3">
                                <g:textField name="apellido" minlength="3" maxlength="31" required="" class="form-control required" value="${paciente?.nombre}"/>
                                %{--                                            <p class="help-block ui-helper-hidden"></p>--}%
                            </span>
                        </span>
                        <span class="col-md-1 mediano"></span>
                        <span class="col-md-1 label label-primary text-info mediano">Nombre</span>
                        <span class="grupo">
                            <span class="col-md-3">
                                <g:textField name="nombre" minlength="3" maxlength="31" required="" class="form-control required" value="${paciente?.nombre}"/>
                                %{--                                            <p class="help-block ui-helper-hidden"></p>--}%
                            </span>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano" style="margin-top: 24px">Provincia</span>
                        <span class="grupo">
                            <span class="col-md-3" style="margin-top: 24px">
                                <g:select name="provincia" from="${geografia.Provincia.list().sort{it.nombre}}" optionKey="id" optionValue="nombre" class="form-control" value="${paciente?.parroquia?.canton?.provincia?.id}"/>
                            </span>
                        </span>
                        <span class="grupo">
                            <span class="col-md-3" id="divCanton">
                            </span>
                        </span>
                        <span class="grupo">
                            <span class="col-md-3" id="divParroquia">
                            </span>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Dirección</span>
                        <span class="col-md-8">
                            <g:textField name="direccion" style="resize: none" maxlength="255" class="form-control" value="${paciente?.direccion}"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Referencia</span>
                        <span class="col-md-8">
                            <g:textField name="referencia" style="resize: none" maxlength="255" class="form-control" value="${paciente?.referencia}"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Teléfono</span>
                        <span class="grupo">
                            <span class="col-md-3">
                                <g:textField name="telefono" maxlength="31" class="number form-control" value="${paciente?.telefono}"/>
                            </span>
                        </span>
                        <span class="col-md-1 mediano"></span>
                        <span class="col-md-1 label label-primary text-info mediano">Email</span>
                        <span class="grupo">
                            <span class="col-md-4">
                                <g:textField name="mail" maxlength="63" class="email mail form-control" value="${paciente?.mail}"/>
                            </span>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Fecha de nacimiento</span>
                        <span class="grupo">
                            <span class="col-md-3">
                                <input aria-label="" name="fechaNacimiento" id='fechaNacimiento' type='text' class="form-control" value="${paciente?.fechaNacimiento?.format("dd-MM-yyyy")}" />
                            </span>
                        </span>
                        <span class="col-md-1 mediano"></span>
                        <span class="col-md-1 label label-primary text-info mediano">Sexo</span>
                        <span class="grupo">
                            <span class="col-md-3">
                                <g:select name="sexo" from="${['F' :  'FEMENINO', 'M' : 'MASCULINO']}" optionKey="key" optionValue="value" class="form-control" value="${paciente?.sexo}"/>
                            </span>
                        </span>
                    </div>
                </div>




            %{--                <div class="row izquierda">--}%
            %{--                    <div class="col-md-12 input-group">--}%
            %{--                        <span class="col-md-2 label label-primary text-info mediano">Nombre</span>--}%

            %{--                        <div class="col-md-10">--}%
            %{--                            <span class="grupo">--}%
            %{--                                <g:textField name="nombre" id="nombre" class="form-control required"--}%
            %{--                                             maxlength="255" value="${proy?.nombre}"/>--}%
            %{--                            </span>--}%
            %{--                        </div>--}%
            %{--                    </div>--}%
            %{--                </div>--}%

            %{--                <div class="row izquierda">--}%
            %{--                    <div class="col-md-12 input-group">--}%
            %{--                        <span class="col-md-2 label label-primary text-info mediano">Productos</span>--}%

            %{--                        <div>--}%
            %{--                            <div class="col-md-10">--}%
            %{--                                <span class="grupo">--}%
            %{--                                    <g:textField name="producto" id="producto" class="form-control"--}%
            %{--                                                 maxlength="127" value="${proy?.producto}"/>--}%
            %{--                                </span>--}%
            %{--                            </div>--}%
            %{--                        </div>--}%
            %{--                    </div>--}%
            %{--                </div>--}%

            %{--                <div class="row izquierda">--}%
            %{--                    <div class="col-md-12 input-group">--}%
            %{--                        <span class="col-md-2 label label-primary text-info mediano">Descripción</span>--}%

            %{--                        <div class="col-md-10">--}%
            %{--                            <span class="grupo">--}%
            %{--                                <g:textArea name="descripcion" id="descripcion" class="form-control" maxlength="1023"--}%
            %{--                                            style="height: 80px; resize: none" value="${proy?.descripcion}"/>--}%
            %{--                            </span>--}%
            %{--                        </div>--}%
            %{--                    </div>--}%
            %{--                </div>--}%

            %{--                <div class="row izquierda">--}%
            %{--                    <div class="col-md-12 input-group">--}%
            %{--                        <span class="col-md-2 label label-primary text-info mediano">Problema</span>--}%

            %{--                        <div class="col-md-10">--}%
            %{--                            <g:textArea name="problema" id="problema" class="form-control required" maxlength="1023"--}%
            %{--                                        style="height: 80px; resize: none" value="${proy?.problema}"/>--}%
            %{--                        </div>--}%
            %{--                    </div>--}%
            %{--                </div>--}%

            %{--                <div class="row izquierda">--}%
            %{--                    <div class="col-md-12 input-group">--}%
            %{--                        <span class="col-md-2 label label-primary text-info mediano">Justificación</span>--}%

            %{--                        <div class="col-md-10">--}%
            %{--                            <g:textArea name="justificacion" id="justificacion" class="form-control required"--}%
            %{--                                        maxlength="1023"--}%
            %{--                                        style="height: 80px; resize: none" value="${proy?.justificacion}"/>--}%
            %{--                        </div>--}%
            %{--                    </div>--}%
            %{--                </div>--}%

            %{--                <div class="row izquierda">--}%
            %{--                    <div class="col-md-12 input-group">--}%
            %{--                        <span class="col-md-2 label label-primary text-info mediano">Fecha Inicio</span>--}%
            %{--                        <span class="grupo">--}%
            %{--                            <div class="col-md-2 ">--}%
            %{--                                <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"--}%
            %{--                                       value="${proy?.fechaInicio?.format("dd-MM-yyyy")}"/>--}%

            %{--                                <p class="help-block ui-helper-hidden"></p>--}%
            %{--                            </div>--}%
            %{--                        </span>--}%
            %{--                        <span class="col-md-2 mediano"></span>--}%
            %{--                        <span class="col-md-2 label label-primary text-info mediano">Fecha Fin</span>--}%
            %{--                        <span class="grupo">--}%
            %{--                            <div class="col-md-2">--}%
            %{--                                <input name="fechaFin" id='fechaFin' type='text' class="form-control"--}%
            %{--                                       value="${proy?.fechaFin?.format("dd-MM-yyyy")}"/>--}%

            %{--                                <p class="help-block ui-helper-hidden"></p>--}%
            %{--                            </div>--}%
            %{--                        </span>--}%
            %{--                    </div>--}%
            %{--                </div>--}%

            %{--                <div class="row izquierda" style="margin-bottom: 20px">--}%
            %{--                    <div class="col-md-6 input-group">--}%
            %{--                        <span class="col-md-4 label label-primary text-info mediano">Informar cada (meses)</span>--}%

            %{--                        <div class="col-md-2">--}%
            %{--                            <g:textField name="mes" id="mes" class="form-control" maxlength="5" value="${proy?.mes}"/>--}%
            %{--                        </div>--}%
            %{--                    </div>--}%
            %{--                    <div class="col-md-6 input-group">--}%
            %{--                        <span class="col-md-4 label label-primary text-info mediano">Monto del Proyecto</span>--}%

            %{--                        <div class="col-md-4">--}%
            %{--                            <g:textField name="monto" id="monto" class="form-control negrita" maxlength="16"--}%
            %{--                                         value="${util.formatNumber(number: proy?.monto, maxFractionDigits: 2, minFractionDigits: 2)}"/>--}%
            %{--                        </div>--}%
            %{--                    </div>--}%
            %{--                </div>--}%
            </g:form>
        </div>
    </div>
</div>

<script type="text/javascript">

    $('#fechaNacimiento').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });

    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            // ev.keyCode === 190 || ev.keyCode === 110 ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }


    $("#cedula, #telefono").keydown(function (ev) {
        return validarNum(ev);
    });

    $("#provincia").change(function () {
        var provincia = $(this).val();
        cargarCanton(provincia);
    });

    cargarCanton($("#provincia option:selected").val());

    function cargarCanton(provincia) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'canton_ajax')}',
            data:{
                id: '${paciente?.id}',
                provincia: provincia
            },
            success: function (msg) {
                $("#divCanton").html(msg)
            }
        });
    }

    %{--$("#btnEstado").click(function () {--}%
    %{--    bootbox.confirm({--}%
    %{--        size: "small",--}%
    %{--        title: 'Alerta',--}%
    %{--        message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> ¿Está seguro de cambiar el estado del proyecto?",--}%
    %{--        buttons: {--}%
    %{--            confirm: {--}%
    %{--                label: 'Aceptar',--}%
    %{--                className: 'btn-success'--}%
    %{--            },--}%
    %{--            cancel: {--}%
    %{--                label: 'Cancelar',--}%
    %{--                className: 'btn-primary'--}%
    %{--            }--}%
    %{--        },--}%
    %{--        callback: function(result){--}%
    %{--            if(result){--}%
    %{--                $.ajax({--}%
    %{--                    type: 'POST',--}%
    %{--                    url: '${createLink(controller: 'proyecto', action: 'cambiarEstado_ajax')}',--}%
    %{--                    data:{--}%
    %{--                        id: '${proy?.id}'--}%
    %{--                    },--}%
    %{--                    success: function (msg) {--}%
    %{--                        if(msg === 'ok'){--}%
    %{--                            log("Estado cambiado correctamente","success");--}%
    %{--                            setTimeout(function () {--}%
    %{--                                location.reload(true)--}%
    %{--                            }, 1000);--}%
    %{--                        }else{--}%
    %{--                            if(msg === 'er'){--}%
    %{--                                bootbox.alert({--}%
    %{--                                    size: "small",--}%
    %{--                                    title: "Alerta!!!",--}%
    %{--                                    message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i>  No se puede cambiar el estado, el marco lógico ya ha sido modificado!",--}%
    %{--                                    callback: function(){}--}%
    %{--                                })--}%
    %{--                            }else{--}%
    %{--                                log("Error al cambiar de estado","error")--}%
    %{--                            }--}%
    %{--                        }--}%
    %{--                    }--}%
    %{--                });--}%
    %{--            }--}%
    %{--        }--}%
    %{--    });--}%
    %{--});--}%

    %{--$("#btnVerCronograma").click(function () {--}%
    %{--    location.href="${createLink(controller: 'cronograma', action: 'form')}/" + '${proy?.id}'--}%
    %{--});--}%

    %{--$("#btnMeta").click(function () {--}%
    %{--    location.href="${createLink(controller: 'meta', action: 'list')}/" + '${proy?.id}'--}%
    %{--});--}%

    %{--$("#btnFinanciamiento").click(function () {--}%
    %{--    var id = '${proy?.id}';--}%

    %{--    <g:if test="${anioActual}">--}%
    %{--    $.ajax({--}%
    %{--        type    : "POST",--}%
    %{--        url     : "${createLink(controller: 'financiamiento', action:'list_ajax')}",--}%
    %{--        data    : {--}%
    %{--            id : id--}%
    %{--        },--}%
    %{--        success : function (msg) {--}%
    %{--            bootbox.dialog({--}%
    %{--                title   : "Presupuesto/Fuentes",--}%
    %{--                class   : "modal-lg",--}%
    %{--                message : msg,--}%
    %{--                buttons : {--}%
    %{--                    ok : {--}%
    %{--                        label     : "Salir",--}%
    %{--                        className : "btn-primary",--}%
    %{--                        callback  : function () {--}%
    %{--                        }--}%
    %{--                    }--}%
    %{--                }--}%
    %{--            });--}%
    %{--        }--}%
    %{--    });--}%
    %{--    </g:if>--}%
    %{--    <g:else>--}%
    %{--    bootbox.alert( "<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> " +--}%
    %{--        "<span style='margin-left: 5px; font-weight: bold; font-size: 14px'> No se ha ingresado el año actual! </span>" +--}%
    %{--        "<br/>  <span style='margin-left: 5px'> Para ingresarlo, diríjase a Parametros -> Año Fiscal </span> ");--}%
    %{--    </g:else>--}%


    %{--});--}%

    %{--$("#btnVerMarco").click(function () {--}%
    %{--    location.href="${createLink(controller: 'marcoLogico', action: 'verMarco')}/${proy?.id}"--}%
    %{--});--}%

    %{--$("#btnBase").click(function () {--}%
    %{--    location.href = "${createLink(controller: 'proyecto', action: 'proy')}"--}%
    %{--});--}%

    %{--$("#editMrlg").click(function () {--}%
    %{--    location.href = "${createLink(controller: 'marcoLogico', action: 'marcoLogicoProyecto')}/${proy?.id}?list=list"--}%
    %{--});--}%

    %{--$("#btnGuardar").click(function () {--}%

    %{--    var $form = $("#frmProyecto");--}%
    %{--    var base_id = '${proy?.id}';--}%
    %{--    $form.validate();--}%
    %{--    // console.log('val:', $form.validate());--}%
    %{--    // console.log('val:', $form.validate().label);--}%
    %{--    if($form.valid()){--}%
    %{--        var dialog = cargarLoader("Guardando...");--}%
    %{--        $.ajax({type: 'POST',--}%
    %{--            url: "${createLink(controller: 'proyecto', action: 'save_ajax')}",--}%
    %{--            data:  $form.serialize(),--}%
    %{--            success: function (msg) {--}%
    %{--                dialog.modal('hide');--}%
    %{--                var parte = msg.split("_");--}%
    %{--                if(parte[0] === 'ok'){--}%
    %{--                    log("Proyecto guardado correctamente","success");--}%
    %{--                    setTimeout(function () {--}%
    %{--                        reCargar(parte[1]);--}%
    %{--                    }, 800);--}%
    %{--                }else{--}%
    %{--                    dialog.modal('hide');--}%
    %{--                    log("Error al guardar el proyecto" + parte[1],"error")--}%
    %{--                }--}%
    %{--            }--}%
    %{--        });--}%
    %{--    }--}%
    %{--});--}%

    %{--function reCargar(id) {--}%
    %{--    location.href = "${createLink(controller: 'proyecto', action: 'proy')}" + "/" + id;--}%
    %{--}--}%

    %{--/*--}%
    %{--    $("#frmProyecto").validate({--}%
    %{--        errorClass     : "help-block",--}%
    %{--        errorPlacement : function (error, element) {--}%
    %{--            if (element.parent().hasClass("input-group")) {--}%
    %{--                error.insertAfter(element.parent());--}%
    %{--            } else {--}%
    %{--                error.insertAfter(element);--}%
    %{--            }--}%
    %{--            element.parents(".grupo").addClass('has-error');--}%
    %{--        },--}%
    %{--        success        : function (label) {--}%
    %{--            label.parents(".grupo").removeClass('has-error');--}%
    %{--            label.remove();--}%
    %{--        }--}%
    %{--    });--}%
    %{--*/--}%

    %{--$("#frmProyecto").validate({--}%
    %{--    errorClass: "help-block",--}%
    %{--    errorPlacement: function (error, element) {--}%
    %{--        if (element.parent().hasClass("input-group")) {--}%
    %{--            error.insertAfter(element.parent());--}%
    %{--        } else {--}%
    %{--            error.insertAfter(element);--}%
    %{--        }--}%
    %{--        element.parents(".grupo").addClass('has-error');--}%
    %{--    },--}%
    %{--    success: function (label) {--}%
    %{--        label.parents(".grupo").removeClass('has-error');--}%
    %{--        label.remove();--}%
    %{--    },--}%
    %{--    rules: {--}%
    %{--        nombre: {--}%
    %{--            remote: {--}%
    %{--                url: "${createLink(action: 'validarNombre_ajax')}",--}%
    %{--                type: "post"--}%
    %{--            }--}%
    %{--        }--}%
    %{--    },--}%
    %{--    messages: {--}%
    %{--        nombre: {--}%
    %{--            remote: "El nombre no contiene FAREPS"--}%
    %{--        }--}%
    %{--    }--}%
    %{--});--}%

    %{--$(".form-control").keydown(function (ev) {--}%
    %{--    if (ev.keyCode === 13) {--}%
    %{--        submitForm();--}%
    %{--        return false;--}%
    %{--    }--}%
    %{--    return true;--}%
    %{--});--}%




    %{--$('#fechaInicio').datetimepicker({--}%
    %{--    locale: 'es',--}%
    %{--    format: 'DD-MM-YYYY',--}%
    %{--    daysOfWeekDisabled: [0, 6],--}%
    %{--    sideBySide: true,--}%
    %{--    showClose: true--}%
    %{--});--}%

    %{--$('#fechaFin').datetimepicker({--}%
    %{--    locale: 'es',--}%
    %{--    format: 'DD-MM-YYYY',--}%
    %{--    daysOfWeekDisabled: [0, 6],--}%
    %{--    sideBySide: true,--}%
    %{--    showClose: true--}%
    %{--});--}%

    %{--$("input[maxlength]").maxlength({--}%
    %{--    alwaysShow: true,--}%
    %{--    threshold: 10,--}%
    %{--    warningClass: "label label-success",--}%
    %{--    limitReachedClass: "label label-danger"--}%
    %{--});--}%
    %{--$("textarea[maxlength]").maxlength();--}%

</script>

</body>
</html>
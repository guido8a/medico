<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="main">
    <title>

        <g:if test="${paciente?.id}">
            Paciente:  ${(paciente?.apellido ?: '') + " " + (paciente?.nombre ?: '')}
        </g:if>
        <g:else>
            Nuevo paciente
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

<h3>
    <g:if test="${paciente?.id}">
        Paciente: <strong style="font-style: italic"> ${(paciente?.apellido ?: '') + " " + (paciente?.nombre ?: '')}</strong>
    </g:if>
    <g:else>
        Nuevo paciente
    </g:else>
</h3>

<div class="panel panel-primary col-md-12">

    <div class="panel-heading" style="padding: 3px; margin-top: 2px; margin-bottom: 5px; text-align: center; height: 40px">
        <a href="${createLink(controller: 'paciente', action: 'list')}" class="btn btn-sm btn-info" style="float: left" title="Retornar a búsqueda de pacientes">
            <i class="fas fa-arrow-left"></i> Regresar
        </a>
        <a href="#" id="btnGuardar" class="btn btn-sm btn-success" style="float: left; margin-left: 20px" title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
        <g:if test="${paciente?.id}">
            <a href="#" id="btnFoto" class="btn btn-sm btn-info" title="Foto del paciente">
                <i class="fa fa-image"></i> Foto
            </a>
            <a href="#" id="btnAntecedentes" class="btn btn-sm btn-info" title="Antecedentes del paciente">
                <i class="fa fa-clipboard"></i> Antecedentes
            </a>
            <a href="#" id="btnExFisico" class="btn btn-sm btn-info" title="Exámenes físicos del paciente">
                <i class="fa fa-user"></i> Examen Físico
            </a>
            <a href="#" id="btnHistoria"
               class="btn btn-sm btn-info" title="Historial del paciente">
                <i class="fas fa-book-reader"></i> Historia
            </a>

            <a href="#" id="btnCitas" class="btn btn-sm btn-info" title="Citas médicas">
                <i class="fa fa-list"></i> Citas
            </a>

            <a href="#" id="btnNuevaCita" class="btn btn-sm btn-info" title="Nueva Cita médica">
                <i class="fa fa-calendar-alt"></i> Nueva Cita
            </a>

            <a href="#" id="btnEstado" class="btn btn-sm btn-info"  title="Cambiar el estado del paciente">
                <i class="fa fa-bullseye"></i> Estado
            </a>
        %{--            <a href="#" id="btnBorrarPaciente" class="btn btn-sm btn-info"  title="Borrar Paciente">--}%
        %{--                <i class="fa fa-trash"></i> Eliminar--}%
        %{--            </a>--}%
        </g:if>

    </div>

    <div class="tab-content" style="margin-top: 10px">
        <div id="home" class="tab-pane fade in active">
            <g:form class="form-horizontal" name="frmPaciente" controller="paciente" action="savePaciente_ajax">
                <g:hiddenField name="id" value="${paciente?.id}"/>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Empresa</span>
                        <span class="col-md-6">
                            <g:select name="empresa" from="${seguridad.Empresa.list([sort: 'nombre'])}" optionKey="id" optionValue="nombre" class="form-control " value="${paciente?.empresa?.id}" />
                        </span>


                        <span class="col-md-1 label label-primary text-info mediano">Estado</span>
                        <span class="grupo">
                            <span class="col-md-2">
                                <g:textField name="act" class="form-control" readonly="" style="background-color:
                                ${paciente?.activo == 1 ? '#67a153' : '#e22b0c'}; text-align: center "
                                             value=" ${paciente?.activo == 1 ? 'ACTIVO' : 'INACTIVO'}"/>
                            </span>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Cédula</span>
                        <span class="col-md-2">
                            <g:textField name="cedula" maxlength="10" minlength="10" required="" class="form-control required allCaps"  value="${paciente?.cedula}"/>
                        </span>
                        <span class="col-md-1 label label-primary text-info mediano">Nombre</span>
                        <span class="grupo">
                            <span class="col-md-3">
                                <g:textField name="nombre" minlength="3" maxlength="31" required="" class="form-control required" value="${paciente?.nombre}"/>
                            </span>
                        </span>
                        <span class="col-md-1 label label-primary text-info mediano">Apellido</span>
                        <span class="grupo">
                            <span class="col-md-3">
                                <g:textField name="apellido" minlength="3" maxlength="31" required="" class="form-control required" value="${paciente?.apellido}"/>
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
                        <span class="col-md-9">
                            <g:textField name="direccion" style="resize: none" maxlength="255" class="form-control" value="${paciente?.direccion}"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Referencia</span>
                        <span class="col-md-9">
                            <g:textField name="referencia" style="resize: none" maxlength="255" class="form-control" value="${paciente?.referencia}"/>
                        </span>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Teléfonos</span>
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

                <div class="row izquierda" style="margin-bottom: 15px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano" style="margin-top: 10px">Fecha de nacimiento</span>
                        <span class="grupo" >
                            <span class="col-md-2 arriba" >
                                <input aria-label="" name="fechaNacimiento" id='fechaNacimiento' type='text' required="" class="form-control required" value="${paciente?.fechaNacimiento?.format("dd-MM-yyyy")}" />
                            </span>
                        </span>
                        <span class="col-md-2 mediano"></span>
                        <span class="col-md-1 label label-primary text-info mediano">Estado Civil</span>
                        <span class="grupo">
                            <span class="col-md-2">
                                <g:select name="estadoCivil" from="${medico.EstadoCivil.list()}" optionKey="id" optionValue="descripcion" class="form-control" value="${paciente?.estadoCivil?.id}"/>
                            </span>
                        </span>
                    </div>
                </div>
                <div class="row izquierda" style="margin-bottom: 15px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Sexo</span>
                        <span class="grupo">
                            <span class="col-md-2">
                                <g:select name="sexo" from="${['F' :  'FEMENINO', 'M' : 'MASCULINO']}" optionKey="key" optionValue="value" class="form-control" value="${paciente?.sexo}"/>
                            </span>
                        </span>
                        <span class="col-md-2 mediano"></span>
                        <span class="col-md-1 label label-primary text-info mediano">Grupo Sanguineo</span>
                        <span class="grupo">
                            <span class="col-md-2">
                                <g:select name="grupoSanguineo" from="${medico.GrupoSanguineo.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control " value="${paciente?.grupoSanguineo?.id}"/>
                            </span>
                        </span>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>

<script type="text/javascript">

    var di;

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

    $("#btnNuevaCita").click(function () {
        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + '${paciente?.id}'
    });


    $("#btnFoto").click(function () {
        cargarFotoPaciente('${paciente?.id}');
    });

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

    $("#btnGuardar").click(function () {
        submitFormPaciente();
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
                        location.href="${createLink(controller: 'paciente', action: 'datos')}?id=" + parts[2]
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

    $("#btnEstado").click(function () {
        bootbox.confirm({
            size: "small",
            title: 'Alerta',
            message: "<i class='fa fa-exclamation-triangle fa-2x pull-left text-warning text-shadow'></i> <strong style='font-size: 14px'> Está seguro de cambiar el estado del paciente?</strong>",
            buttons: {
                confirm: {
                    label: 'Aceptar',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'Cancelar',
                    className: 'btn-primary'
                }
            },
            callback: function(result){
                if(result){
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'paciente', action: 'cambiarEstado_ajax')}',
                        data:{
                            id: '${paciente?.id}'
                        },
                        success: function (msg) {
                            if(msg === 'ok'){
                                log("Estado cambiado correctamente","success");
                                setTimeout(function () {
                                    location.reload()
                                }, 1000);
                            }else{
                                bootbox.alert({
                                    size: "small",
                                    title: "Alerta!!!",
                                    message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i>  Error, No se puede cambiar el estado!",
                                    callback: function(){}
                                })
                            }
                        }
                    });
                }
            }
        });
    });


    $("#btnBorrarPaciente").click(function () {
        bootbox.confirm({
            size: "small",
            title: 'Alerta',
            message: "<i class='fa fa-exclamation-triangle fa-2x pull-left text-danger text-shadow'></i> <strong style='font-size: 14px'> Está seguro de borrar a este paciente?</strong>",
            buttons: {
                confirm: {
                    label: 'Aceptar',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'Cancelar',
                    className: 'btn-primary'
                }
            },
            callback: function(result){
                if(result){
                    %{--$.ajax({--}%
                    %{--    type: 'POST',--}%
                    %{--    url: '${createLink(controller: 'paciente', action: 'cambiarEstado_ajax')}',--}%
                    %{--    data:{--}%
                    %{--        id: '${paciente?.id}'--}%
                    %{--    },--}%
                    %{--    success: function (msg) {--}%
                    %{--        if(msg === 'ok'){--}%
                    %{--            log("Estado cambiado correctamente","success");--}%
                    %{--            setTimeout(function () {--}%
                    %{--                location.reload()--}%
                    %{--            }, 1000);--}%
                    %{--        }else{--}%
                    %{--            bootbox.alert({--}%
                    %{--                size: "small",--}%
                    %{--                title: "Alerta!!!",--}%
                    %{--                message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i>  Error, No se puede cambiar el estado!",--}%
                    %{--                callback: function(){}--}%
                    %{--            })--}%
                    %{--        }--}%
                    %{--    }--}%
                    %{--});--}%
                }
            }
        });
    });

    function cargarFotoPaciente(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'paciente', action:'foto_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                di = bootbox.dialog({
                    id      : "dlgFoto",
                    title   : "Foto del paciente",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-gris",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function cerrarDialogoImagen () {
        di.modal("hide");
    }

    $("#btnHistoria").click(function (){
        location.href="${createLink(controller: 'historial', action: 'arbolCitas')}?id=" + '${paciente?.id}'
    });

    $("#btnCitas").click(function () {
        var pcnt = "${paciente?.id}";
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'paciente', action:'buscarCitas')}",
            data    : {pcnt: pcnt},
            success : function (msg) {
                bcpc = bootbox.dialog({
                    id      : "dlgBuscarCPC",
                    title   : "Buscar Cita",
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
        var id = "${paciente?.id}";
        $.ajax({
            type    : "POST",
            url: "${createLink(controller: 'examenFisico', action:'list')}",
            data    : {
                id: id
            },
            success : function (msg) {
                bcpc = bootbox.dialog({
                    id      : "dlgExamenesFisicos",
                    title   : "Exámenes Físicos",
                    // class: "modal-lg",
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

</script>

</body>
</html>
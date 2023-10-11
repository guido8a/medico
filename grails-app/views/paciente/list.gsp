
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Lista de Pacientes
    </title>
</head>
<body>

<div class="row" style="margin-bottom: 10px">
    <div class="span9 btn-group" role="navigation">
        <a href="#" class="btn btn-success btnNuevoPaciente">
            <i class="fa fa-user"></i>
            Nuevo Paciente
        </a>
    </div>
</div>


<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-2">
                    <label class="control-label text-info">Empresa</label>
                    <g:select name="empresa" class="empresa col-md-12 form-control" from="${seguridad.Empresa.list().sort{it.nombre}}" noSelection="[0: 'Todos']" value="${empresa ? empresa?.id : 0}" optionKey="id"
                              optionValue="nombre"/>
                </span>
                <span class="col-md-2">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPor" class="buscarPor col-md-12 form-control" from="${[1: 'Cédula', 2: 'Apellido', 3: 'Nombre']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-2">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="criterio" id="criterio" class="form-control"/>
                </span>
            </span>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarEmpresa"><i class="fa fa-search"></i></button>
            </div>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaPacientes" >
        </div>
    </fieldset>
</div>


<script type="text/javascript">
    var di;

    $(".btnNuevoPaciente").click(function () {
        // createEditRow();
        location.href="${createLink(controller: 'paciente', action: 'datos')}"
    });

    $("#btnLimpiar").click(function  () {
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
            data:{
                buscarPor: buscarPor,
                criterio: criterio,
                empresa: empresa
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaPacientes").html(msg)
            }
        })
    }

    function createEditRow(id) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id}: {};

        $.ajax({
            type    : "POST",
            url: "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditPaciente",
                    title   : title + " Paciente",
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
    } //createEdit

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
                        cargarTablaPacientes();
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

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold'> Está seguro que desea eliminar este paciente? Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(action:'borrarPaciente_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaPacientes();
                                }else{
                                    log(parts[1],"error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function cargarImagenePaciente(id) {
        %{--$.ajax({--}%
        %{--    type    : "POST",--}%
        %{--    url     : "${createLink(controller: 'empresa', action:'logoEmpresa_ajax')}",--}%
        %{--    data    : {--}%
        %{--        id:id--}%
        %{--    },--}%
        %{--    success : function (msg) {--}%
        %{--        di = bootbox.dialog({--}%
        %{--            id      : "dlgImas",--}%
        %{--            title   : "Logo de la empresa",--}%
        %{--            message : msg,--}%
        %{--            buttons : {--}%
        %{--                cancelar : {--}%
        %{--                    label     : "<i class='fa fa-times'></i> Cerrar",--}%
        %{--                    className : "btn-gris",--}%
        %{--                    callback  : function () {--}%

        %{--                    }--}%
        %{--                }--}%
        %{--            } //buttons--}%
        %{--        }); //dialog--}%
        %{--    } //success--}%
        %{--}); //ajax--}%
    } //createEdit

    function cerrarDialogoImagen () {
        di.modal("hide");
    }

    %{--function createContextMenu(node) {--}%
    %{--    var $tr = $(node);--}%

    %{--    var items = {--}%
    %{--        header: {--}%
    %{--            label: "Acciones",--}%
    %{--            header: true--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var id = $tr.data("id");--}%

    %{--    var ver = {--}%
    %{--        label: " Ver",--}%
    %{--        icon: "fa fa-search",--}%
    %{--        action: function () {--}%
    %{--            $.ajax({--}%
    %{--                type    : "POST",--}%
    %{--                url     : "${createLink(controller: 'paciente', action:'show_ajax')}",--}%
    %{--                data    : {--}%
    %{--                    id : id--}%
    %{--                },--}%
    %{--                success : function (msg) {--}%
    %{--                    bootbox.dialog({--}%
    %{--                        title   : "Empresa",--}%
    %{--                        message : msg,--}%
    %{--                        buttons : {--}%
    %{--                            ok : {--}%
    %{--                                label     : "Aceptar",--}%
    %{--                                className : "btn-primary",--}%
    %{--                                callback  : function () {--}%
    %{--                                }--}%
    %{--                            }--}%
    %{--                        }--}%
    %{--                    });--}%
    %{--                }--}%
    %{--            });--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var editar = {--}%
    %{--        label: " Editar",--}%
    %{--        icon: "fa fa-edit",--}%
    %{--        action: function () {--}%
    %{--            createEditRow(id)--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var historia = {--}%
    %{--        label: "Historia",--}%
    %{--        icon: "fa fa-book",--}%
    %{--        separator_before : true,--}%
    %{--        action: function () {--}%
    %{--            // createEditRowCont(id)--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var foto = {--}%
    %{--        label: "Foto",--}%
    %{--        icon: "fa fa-images",--}%
    %{--        separator_before : true,--}%
    %{--        action: function () {--}%
    %{--            cargarImagenePaciente(id);--}%
    %{--        }--}%
    %{--    };--}%

    %{--    var eliminar = {--}%
    %{--        label: " Eliminar",--}%
    %{--        icon: "fa fa-trash",--}%
    %{--        separator_before : true,--}%
    %{--        action: function () {--}%
    %{--            deleteRow(id);--}%
    %{--        }--}%
    %{--    };--}%

    %{--    items.ver = ver;--}%
    %{--    items.editar = editar;--}%
    %{--    items.historia = historia;--}%
    %{--    items.foto = foto;--}%
    %{--    items.eliminar = eliminar;--}%

    %{--    return items--}%
    %{--}--}%


</script>

</body>
</html>


<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Lista de Medicinas
    </title>
</head>
<body>

<div class="row" style="margin-bottom: 10px">
    <div class="btn-group" role="navigation">
        <a href="#" class="btn btn-success btnNuevaMedicina">
            <i class="fa fa-medkit"></i>
            Nueva Medicina
        </a>
    </div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-2">
                    <label class="control-label text-info">Tipo</label>
                    <g:select name="tipoMedicina" class="col-md-12 form-control" from="${['C': 'Comercial', 'G': 'Genérico']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-2">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPor" class="buscarPor col-md-12 form-control" from="${[1: 'Nombre', 2: 'Descripción', 3 : 'Código']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-4">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="criterio" id="criterio" class="form-control"/>
                </span>
            </span>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarMedicina"><i class="fa fa-search"></i> Buscar</button>
            </div>
            <div class="col-md-1" style="margin-top: 20px">
                <button class="btn btn-warning" id="btnLimpiar" title="Limpiar Búsqueda"><i class="fa fa-eraser"></i> Limpiar</button>
            </div>
        </div>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTablaMedicinas" >
        </div>
    </fieldset>
</div>


<script type="text/javascript">
    var di;

    $("#tipoMedicina").change(function () {
        cargarTablaMedicinas();
    });

    $("#buscarPor").change(function () {
        cargarTablaMedicinas();
    });

    $(".btnNuevaMedicina").click(function () {
        createEditRow();
    });

    $("#btnLimpiar").click(function  () {
        $("#buscarPor").val(1);
        $("#criterio").val('');
        $("#tipoMedicina").val('G');
        cargarTablaMedicinas();
    });

    $("#btnBuscarMedicina").click(function () {
        cargarTablaMedicinas();
    });

    $("#criterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaMedicinas();
            return false;
        }
        return true;
    });

    cargarTablaMedicinas();

    function cargarTablaMedicinas() {
        var d = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPor option:selected").val();
        var criterio = $("#criterio").val();
        var tipoMedicina = $("#tipoMedicina option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'medicina', action: 'tablaMedicinas_ajax')}',
            data:{
                buscarPor: buscarPor,
                criterio: criterio,
                tipoMedicina: tipoMedicina
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaMedicinas").html(msg)
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
                    id      : "dlgCreateEdit",
                    title   : title + " Medicina",
                    // class: "modal-lg",
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
                                return submitFormMedicina();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormMedicina() {
        var $form = $("#frmMedicina");
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
                        cargarTablaMedicinas();
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
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold'> Está seguro que desea dar de baja esta medicina? </p>",
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
                            url     : '${createLink(action:'borrarEmpresa_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaMedicinas();
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

    function cargarImagenesEmpresa(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empresa', action:'logoEmpresa_ajax')}",
            data    : {
                id:id
            },
            success : function (msg) {
                di = bootbox.dialog({
                    id      : "dlgImas",
                    title   : "Logo de la empresa",
                    // class : "modal-lg",
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
</script>

</body>
</html>

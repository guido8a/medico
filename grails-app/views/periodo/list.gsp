<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Períodos Contables</title>
</head>

<body>
<div class="row">
    <div class="col-md-12">
        <div class="col-md-3 btn-group">
            <a href="#" class="btn btn-primary" id="btnRegresarProcesos">
                <i class="fa fa-arrow-left"></i> Regresar
            </a>
            <a href="#" class="btn btn-success" id="btnAgregarPeriodo">
                <i class="fa fa-plus"></i> Agregar período
            </a>
        </div>
    </div>

    <div class="col-md-12">
        <div style="margin-top: 10px; min-height: 350px">
            <table class="table table-bordered table-hover table-striped table-condensed" style="width: 100%">
                <thead>
                <tr>
                    <th class="alinear" style="width: 20%">Número</th>
                    <th class="alinear" style="width: 30%">Fecha Inicio</th>
                    <th class="alinear" style="width: 30%">Fecha Fin</th>
                    <th class="alinear" style="width: 20%">Acciones</th>
                </tr>
                </thead>
            </table>

            <div id="tablaPeriodos">
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $("#btnRegresarProcesos").click(function(){
        location.href="${createLink(controller: 'inicio', action: 'parametrosContabilidad')}"
    });

    cargarTablaPeriodos();

    $("#btnAgregarPeriodo").click(function () {
        createEditPeriodo();
    });

    function cargarTablaPeriodos(){
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'periodo', action: 'tablaPeriodos_ajax')}',
            data:{
            },
            success: function(msg){
                $("#tablaPeriodos").html(msg)
            }
        });
    }

    function createEditPeriodo(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'periodo', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Período",
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
                                return submitFormPeriodo();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function submitFormPeriodo() {
        var $form = $("#frmPeriodo");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            var data = $form.serialize();
            $btn.replaceWith(spinner);
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
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
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

    function borrarPeriodo(id){
        bootbox.confirm({
            message: "<i class='fa fa-3x fa-trash text-danger'></i> <strong style='font-size: 14px'>  Está seguro de eliminar este período? </strong>",
            buttons: {
                confirm: {
                    label: '<i class="fa fa-trash"></i> Borrar',
                    className: 'btn-danger'
                },
                cancel: {
                    label: '<i class="fa fa-times"></i> Cancelar',
                    className: 'btn-primary'
                }
            },
            callback: function (result) {
                if(result){
                    $.ajax({
                        type:'POST',
                        url:'${createLink(controller: 'periodo', action: 'borrarPeriodo_ajax')}',
                        data:{
                            id: id
                        },
                        success:function(msg){
                            var parts = msg.split("_");
                            if(parts[0] === 'ok'){
                                log("Período borrado correctamente","success");
                                setTimeout(function () {
                                    location.reload();
                                }, 1000);
                            }else{
                                if(parts[0] === 'er'){
                                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                                    return false;
                                }else{
                                    log("Error al borrar el período","error")
                                }
                            }
                        }
                    })
                }
            }
        });
    }

</script>
</body>
</html>
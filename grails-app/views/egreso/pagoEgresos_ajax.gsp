<style type="text/css">

.centro{
    text-align: center;
}

.derecha{
    text-align: right;
}

.cajachica {
    color: #4040af;
    background-color: #efefdf !important;
}
.normal {
    background-color: #ffffff !important;
}

</style>

<div class="alert alert-warning col-md-12">
    <div class="col-md-5" style="font-size: 16px">
        <label style="color: #1b8e36">Pagado: $
        ${g.formatNumber(number: pagos?.valor?.sum() ?: 0, format: '##,##0', maxFractionDigits: 2, minFractionDigits: 2,
                locale: 'en_US')}
        </label>
    </div>
    <div class="col-md-5" style="font-size: 16px">
        <label style="color: #701b19">Saldo: $
        ${g.formatNumber(number: saldo ?: 0, format: '##,##0', maxFractionDigits: 2, minFractionDigits: 2, locale: 'en_US')}
        </label>
    </div>

    <div class="col-md-2">
        <a href="#" class="btn btn-success btn-sm btnPago ${(saldo ?: 0) > 0 ? '' : 'disabled'}" data-ing="${egreso?.id}"
           title="Ingresar Pago" style="margin-left: -20px;">
            <i class="fa fa-plus"></i> Pagar
        </a>
    </div>
</div>

<g:if test="${pagos.size() > 0}">
    <div style="text-align: center"><strong style="font-size: 16px"> Detalle de pagos </strong></div>
    <table class="table table-bordered table-hover table-condensed table-striped">
        <thead>
        <tr>
            <th class="alinear" style="width: 15%">Fecha</th>
            <th class="alinear" style="width: 45%">Doc.</th>
            <th class="alinear" style="width: 20%">Valor</th>
%{--            <th class="alinear" style="width: 29%">Obser.</th>--}%
            <th class="centro" style="width: 20%">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${pagos}" var="pagoUsuario">
            <tr data-id="${pagoUsuario.id}" style="width: 100%" class="${pagoUsuario.cajaChica == 'S' ? 'cajachica' : 'normal'}">
                <td style="width: 15%"><g:formatDate date="${pagoUsuario?.fechaPago}" format="dd-MM-yyyy"/></td>
                <td style="width: 45%">${pagoUsuario?.documento}</td>
                <td class="derecha" style="width: 20%"><g:formatNumber number="${pagoUsuario?.valor}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
%{--                <td style="width: 20%">${pagoUsuario?.observaciones}</td>--}%
                <td style="text-align: center; width: 20%">
                    <g:if test="${pagoUsuario?.estado != 'R'}">
                        <a href="#" class="btn btn-success btn-xs btnEditar" data-id="${pagoUsuario?.id}" data-ing="${egreso?.id}" title="Editar Pago">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a href="#" class="btn btn-danger btn-xs btnEliminar" data-id="${pagoUsuario?.id}" data-ing="${egreso?.id}" title="Borrar Pago">
                            <i class="fa fa-trash"></i>
                        </a>
                    </g:if>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</g:if>
<g:else>
    <div class="alert alert-info centro">
        <i class="fa fa-exclamation-triangle fa-2x"></i> <strong style="font-size: 14px">No existen pagos registrados</strong>
    </div>
</g:else>

<script type="text/javascript">

    var id = null;
    var dgp;

    $(".btnEditarEgg").click(function () {
        var egreso = $(this).data('ing');
        createEditRow(egreso);
    });

    function createEditRow(id) {
        var title = id ? "Editar" : "Nuevo";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'egreso', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Egreso",

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
                                return submitFormEgreso();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormEgreso() {
        var $form = $("#frmEgreso");
        if ($form.valid()) {
            openLoader("Guardando Egreso");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] === "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] === "SUCCESS") {
                        cargarBusqueda();
                    } else {
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    //pagos

    $(".btnEliminar").click(function () {
        var pago = $(this).data("id");
        var egreso = $(this).data("egreso");
        bootbox.confirm({
            message: "<i class='fa fa-3x fa-exclamation-triangle text-danger'></i> <strong style='font-size: 14px'> Está seguro que desea eliminar el pago? </strong>",
            buttons: {
                cancel: {
                    label: 'Cancelar',
                    className: 'btn-primary'
                },
                confirm: {
                    label: '<i class="fa fa-trash"></i> Borrar',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if(result){
                    var bp = cargarLoader("Borrando...");
                    $.ajax({
                        type:'POST',
                        url:'${createLink(controller: 'egreso', action: 'borrarPagoEgreso_ajax')}',
                        data:{
                            id: pago
                        },
                        success:function(msg){
                            bp.modal("hide");
                            var parts = msg.split("_");
                            if(parts[0] === 'ok'){
                                log(parts[1],"success");
                                cargarPagosE(egreso);
                                cargarBusqueda();
                            }else{
                                log(parts[1],"error")
                            }
                        }
                    })
                }
            }
        });
    });

    $(".btnPago").click(function () {
        var egreso = $(this).data('ing');
        createEditPago(egreso, null)
    });

    $(".btnEditar").click(function () {
        var egreso = $(this).data('ing');
        var pago = $(this).data('id');
        createEditPago(egreso, pago)
    });

    $(".btnBorrarEgg").click(function () {
        var egreso = $(this).data("ing");
        bootbox.confirm("<i class='fa fa-warning fa-3x pull-left text-danger text-shadow'></i> Está seguro que desea eliminar el egreso seleccionado?", function (res) {
            if (res) {
                openLoader("Borrando Egreso...");
                $.ajax({
                    type    : "POST",
                    url : "${createLink(controller:'egreso', action:'borrarEgreso_ajax')}",
                    data    : {
                        id: egreso
                    },
                    success : function (msg) {
                        if(msg === 'ok'){
                            closeLoader();
                            log("Egreso borrado correctamente","success");
                            cargarPagosE(egreso);
                            cargarBusqueda();
                        }else{
                            if(msg === 'di'){
                                closeLoader();
                                log("No se puede borrar este egreso, contiene pagos","error")
                            }else{
                                closeLoader();
                                log("Error al borrar el egreso","error")
                            }
                        }
                    }
                });
            }
        });
    });

    function createEditPago(id, pago) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'egreso', action:'pagoEgreso_ajax')}",
            data    : {
                id: id,
                pago: pago
            },
            success : function (msg) {
                dgp = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : "Pago Egreso",
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
                                return submitFormPagoEgreso(id);
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormPagoEgreso(egreso) {
        var $form = $("#frmEgresoPago");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            var gp = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    gp.modal("hide");
                    if(msg === 'ok'){
                        log("Pago guardado correctamente!" , "success");
                        cargarPagosE(egreso);
                        cargarBusqueda();
                        cerrraGuardarPago();
                    }else{
                        if(msg === 'di'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> " +
                                "<strong style='font-size: 14px'> El abono ingresado supera el valor del saldo! </strong>")
                        }
                        else{
                            log("Error al guardar el pago","error");
                        }
                    }
                }
            });
            return false
        } else {
            return false;
        } //else
    }

    function cerrraGuardarPago() {
        dgp.modal("hide")
    }

</script>


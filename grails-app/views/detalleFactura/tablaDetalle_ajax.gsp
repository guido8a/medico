<style type="text/css">
.colorAsiento {
    color: #0b0b0b;
    background-color: #72af97;
}
</style>

<div class="" style="width: 99.7%;height: 500px; overflow-y: auto;float: right; margin-top: -20px">
<table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
    <tbody>
    <g:if test="${detalles.size() > 0}">
        <g:each in="${detalles}" var="detalle">
            <tr style="color:${detalle?.producto?.tipoIva?.id == 2? '#000000' : '#005060'}">
                <td style="width: 90px;">${detalle?.producto?.numero}</td>
                <td style="width: 200px">${detalle?.producto?.texto}</td>
                <td style="width: 50px">${detalle?.bodega?.descripcion}</td>
                <td style="width: 45px; text-align: right">${detalle?.cantidad?.toInteger()}</td>
                <td style="width: 80px; text-align: right"><g:formatNumber number="${detalle?.precioUnitario}" maxFractionDigits="4" minFractionDigits="4"/></td>
                <g:if test="${detalle?.proceso?.tipoProceso?.codigo?.trim() != 'T'}">
                    <td style="width: 50px;text-align: right">${detalle?.descuento}</td>
                </g:if>
                <td style="width: 90px;text-align: right"><g:formatNumber number="${detalle?.cantidad * detalle?.precioUnitario}" maxFractionDigits="2" minFractionDigits="2"/></td>
                <g:if test="${truncar}">
                    <td style="width: 60px; text-align: center"></td>
                </g:if>
                <g:else>
                    <td style="width: 60px; text-align: center">
                        <a href="#" class="btn btn-danger btn-xs btnBorrarItemDetalle"
                           title="Borrar Item" idI="${detalle?.id}"><i class="fa fa-trash"></i>
                        </a>
                        <a href="#" class="btn btn-success btn-xs btnEditarItem"
                           title="Editar Item"  idI="${detalle?.id}"><i class="fa fa-edit"></i>
                        </a>
                    </td>
                </g:else>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr style="text-align: center;">
            <td class="alert alert-warning" colspan="7"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> <strong style="font-size: 16px"> No existen registros </strong></td>
        </tr>
    </g:else>
    </tbody>
</table>

<g:if test="${detalles}">
    <table class="table table-bordered table-hover table-condensed">
        <tbody>
        <tr class="colorAsiento">
            <td style="width: 90px; text-align: right">Tarifa 0%:</td>
            <td style="width: 80px; font-weight: bold">${totl?.basecero + totl?.basenoiv}</td>
            <td style="width: 110px">Tarifa 12%:</td>
            <td style="width: 80px; font-weight: bold">${totl?.base__nz}</td>
            <td style="width: 80px; text-align: right">Descuento:</td>
            <td style="width: 80px; font-weight: bold">${totl?.dsct}</td>
            <td style="width: 40px; text-align: right">IVA:</td>
            <td style="width: 80px; font-weight: bold">${totl?.iva}</td>
            <td style="width: 70px; text-align: right">Flete:</td>
            <td style="width: 80px; font-weight: bold">${totl?.flte}</td>
            <td style="width: 40px; text-align: right">Ice:</td>
            <td style="width: 60px; text-align: right">Total:</td>
            <td style="width: 80px; font-weight: bold">${totl?.totl}</td>
        </tr>
        </tbody>
    </table>
</g:if>

</div>

<script type="text/javascript">

    $(".btnEditarItem").click(function () {
        var det = $(this).attr('idI');
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'detalleFactura', action: 'cargarEdicion_ajax')}',
            data:{
                detalle: det
            },
            success: function (msg) {
                var parts = msg.split("_");
                $("#idDetalle").val(parts[0]);
                $("#codigoItem").val(parts[1]);
                $("#nombreItem").val(parts[2]);
                $("#precioItem").val(parts[3]);
                $("#cantidadItem").val(parts[4]);
                $("#descuentoItem").val(parts[5]);
                $("#bodegas").val(parts[6]);
                $("#centros").val(parts[7]);
                $("#idItem").val(parts[8]);
                $("#totalItem").val((parts[3] * parts[4]).toFixed(2)).attr('readonly',true);
                $("#btnBuscar").addClass('hidden');
                $("#btnAgregar").addClass('hidden');
                $("#btnGuardar").removeClass('hidden');
                $("#btnCancelar").removeClass('hidden');
            }
        });

    });

    $(".btnBorrarItemDetalle").click(function () {
        var det = $(this).attr('idI');
        bootbox.confirm({
            message: "<i class='fa fa-3x fa-exclamation-triangle text-danger'></i> <strong style='font-size: 14px'>  Está seguro que desea borrar el item de la factura? </strong>",
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
                        url:'${createLink(controller: 'detalleFactura', action: 'borrarItemDetalle_ajax')}',
                        data:{
                            detalle: det
                        },
                        success: function (msg){
                            if(msg === 'ok'){
                                log("Item borrado correctamente", "success");
                                cargarTablaDetalle();
                            }else{
                                log("Error al borrar el item al detalle","error");
                            }
                        }
                    });
                }
            }
        });
    });

</script>